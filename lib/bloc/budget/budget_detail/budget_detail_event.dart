part of 'budget_detail_bloc.dart';

abstract class BudgetDetailEvent extends Equatable {
  const BudgetDetailEvent();

  @override
  List<Object> get props => [];
}

class GetBudget extends BudgetDetailEvent {
  final String budgetId;
  GetBudget({
    required this.budgetId,
  });
  @override
  List<Object> get props => [budgetId];
}

class DeleteBudget extends BudgetDetailEvent {
  final String budgetId;
  DeleteBudget({
    required this.budgetId,
  });
  @override
  List<Object> get props => [budgetId];
}
