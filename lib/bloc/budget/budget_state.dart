part of 'budget_bloc.dart';

abstract class BudgetState extends Equatable {
  const BudgetState();

  @override
  List<Object> get props => [];
}

class BudgetInitial extends BudgetState {}

class BudgetEmpty extends BudgetState {}

class BudgetLoading extends BudgetState {}

class BudgetLoaded extends BudgetState {
  final List<Budget> selectedMonthBudgets;
  late final DateTime selectedDate;

  BudgetLoaded({
    required this.selectedMonthBudgets,
    selectedDate,
  }) {
    this.selectedDate = selectedDate ?? DateTime.now();
  }

  BudgetLoaded copyWith({
    List<Budget>? selectedMonthBudgets,
    DateTime? selectedDate,
  }) {
    return BudgetLoaded(
      selectedMonthBudgets: selectedMonthBudgets ?? this.selectedMonthBudgets,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  @override
  List<Object> get props => [selectedDate, selectedMonthBudgets];
}
