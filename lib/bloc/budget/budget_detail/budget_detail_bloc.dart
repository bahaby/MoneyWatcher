import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:money_watcher/model/budget.dart';
import 'package:money_watcher/page/home_page.dart';
import 'package:money_watcher/page/login_page.dart';
import 'package:money_watcher/service/budget_service.dart';
import 'package:money_watcher/service/local_storage_service.dart';
import 'package:money_watcher/service_locator.dart';

part 'budget_detail_event.dart';
part 'budget_detail_state.dart';

class BudgetDetailBloc extends Bloc<BudgetDetailEvent, BudgetDetailState> {
  final GlobalKey<NavigatorState> navigatorKey;
  final storageService = getIt<LocalStorageService>();
  BudgetDetailBloc(
    this.navigatorKey,
  ) : super(BudgetDetailInitial());
  final budgetService = getIt<BudgetService>();

  @override
  Stream<BudgetDetailState> mapEventToState(
    BudgetDetailEvent event,
  ) async* {
    if (!storageService.isJwtTokenValid()) {
      navigatorKey.currentState!.pushReplacementNamed(LoginPage.routeName);
    } else {
      if (event is GetBudget) {
        yield BudgetDetailLoading();
        final budget = await budgetService.getBudget(event.budgetId);
        yield BudgetDetailLoaded(budget: budget);
      } else if (event is DeleteBudget) {
        yield BudgetDetailLoading();
        await budgetService.deleteBudget(event.budgetId);
        navigatorKey.currentState!
            .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
      }
    }
  }
}
