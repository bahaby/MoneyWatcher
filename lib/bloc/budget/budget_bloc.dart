import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:money_watcher/model/budget.dart';
import 'package:money_watcher/page/login_page.dart';
import 'package:money_watcher/service/budget_service.dart';
import 'package:money_watcher/service/local_storage_service.dart';

import '../../service_locator.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final budgetService = getIt<BudgetService>();
  final storageService = getIt<LocalStorageService>();
  final GlobalKey<NavigatorState> navigatorKey;
  BudgetBloc(
    this.navigatorKey,
  ) : super(BudgetInitial()) {
    add(GetBudgets(selectedDate: DateTime.now()));
  }

  @override
  Stream<BudgetState> mapEventToState(
    BudgetEvent event,
  ) async* {
    if (event is GetBudgets) {
      if (!storageService.isJwtTokenValid()) {
        navigatorKey.currentState!.pushNamed(LoginPage.routeName);
      } else {
        yield BudgetLoading();
        final List<Budget> budgets = await budgetService.getLastMonthBudgets();
        yield BudgetLoaded(
          selectedMonthBudgets: budgets,
          selectedDate: event.selectedDate,
        );
      }
    }
  }
}
