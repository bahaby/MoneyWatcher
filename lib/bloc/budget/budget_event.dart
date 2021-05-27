part of 'budget_bloc.dart';

abstract class BudgetEvent extends Equatable {
  const BudgetEvent();

  @override
  List<Object> get props => [];
}

class GetBudgets extends BudgetEvent {
  final DateTime? selectedDate;

  GetBudgets({this.selectedDate});
}
