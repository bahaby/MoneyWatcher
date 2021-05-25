part of 'add_budget_bloc.dart';

abstract class AddBudgetEvent extends Equatable {
  const AddBudgetEvent();

  @override
  List<Object> get props => [];
}

class AddBudgetNameChanged extends AddBudgetEvent {
  final String name;

  AddBudgetNameChanged({required this.name});

  @override
  List<Object> get props => [name];
}

class AddBudgetPriceChanged extends AddBudgetEvent {
  final double price;

  AddBudgetPriceChanged({required this.price});

  @override
  List<Object> get props => [price];
}

class AddBudgetDetailChanged extends AddBudgetEvent {
  final String detail;

  AddBudgetDetailChanged({required this.detail});

  @override
  List<Object> get props => [detail];
}

class AddBudgetBudgetTypeChanged extends AddBudgetEvent {
  final bool budgetType;

  AddBudgetBudgetTypeChanged({required this.budgetType});

  @override
  List<Object> get props => [budgetType];
}

class AddBudgetCategoryChanged extends AddBudgetEvent {
  final int categoryId;

  AddBudgetCategoryChanged({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}

class AddBudgetStartDateChanged extends AddBudgetEvent {
  final DateTime startDate;

  AddBudgetStartDateChanged({required this.startDate});

  @override
  List<Object> get props => [startDate];
}

class AddBudgetFinishDateChanged extends AddBudgetEvent {
  final DateTime finishDate;

  AddBudgetFinishDateChanged({required this.finishDate});

  @override
  List<Object> get props => [finishDate];
}

class AddBudgetIsMonthlyChanged extends AddBudgetEvent {
  final bool isMonthly;

  AddBudgetIsMonthlyChanged({required this.isMonthly});

  @override
  List<Object> get props => [isMonthly];
}

class AddBudgetSubmitted extends AddBudgetEvent {}

class AddBudgetLoading extends AddBudgetEvent {}
