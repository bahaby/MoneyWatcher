part of 'budget_bloc.dart';

abstract class BudgetState extends Equatable {
  const BudgetState();

  @override
  List<Object> get props => [];
}

class BudgetInitial extends BudgetState {}

class BudgetLoading extends BudgetState {}

class BudgetDaily extends BudgetState {
  final List<Budget> budgets;

  BudgetDaily(this.budgets);
  
}

class BudgetWeekly extends BudgetState {}

class BudgetMonthly extends BudgetState {}
