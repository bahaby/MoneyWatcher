import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:money_watcher/model/budget.dart';
import 'package:money_watcher/service/budget_service.dart';
import 'package:money_watcher/service_locator.dart';

part 'budget_detail_event.dart';
part 'budget_detail_state.dart';

class BudgetDetailBloc extends Bloc<BudgetDetailEvent, BudgetDetailState> {
  BudgetDetailBloc() : super(BudgetDetailInitial());
  final budgetService = getIt<BudgetService>();

  @override
  Stream<BudgetDetailState> mapEventToState(
    BudgetDetailEvent event,
  ) async* {
    if (event is GetBudget) {
      yield BudgetDetailLoading();
      final budget = await budgetService.getBudget(event.budgetId);
      yield BudgetDetailLoaded(budget: budget);
    }
  }
}
