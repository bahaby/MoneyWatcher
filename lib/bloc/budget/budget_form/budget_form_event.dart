part of 'budget_form_bloc.dart';

abstract class BudgetFormEvent extends Equatable {
  const BudgetFormEvent();

  @override
  List<Object> get props => [];
}

class BudgetFormNameChanged extends BudgetFormEvent {
  final String name;

  BudgetFormNameChanged({required this.name});

  @override
  List<Object> get props => [name];
}

class BudgetFormPriceChanged extends BudgetFormEvent {
  final String price;

  BudgetFormPriceChanged({required this.price});

  @override
  List<Object> get props => [price];
}

class BudgetFormDetailChanged extends BudgetFormEvent {
  final String detail;

  BudgetFormDetailChanged({required this.detail});

  @override
  List<Object> get props => [detail];
}

class BudgetFormBudgetTypeChanged extends BudgetFormEvent {
  final bool budgetType;

  BudgetFormBudgetTypeChanged({required this.budgetType});

  @override
  List<Object> get props => [budgetType];
}

class BudgetFormCategoryChanged extends BudgetFormEvent {
  final int categoryId;

  BudgetFormCategoryChanged({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}

class BudgetFormStartDateChanged extends BudgetFormEvent {
  final DateTime startDate;

  BudgetFormStartDateChanged({required this.startDate});

  @override
  List<Object> get props => [startDate];
}

class BudgetFormFinishDateChanged extends BudgetFormEvent {
  final DateTime finishDate;

  BudgetFormFinishDateChanged({required this.finishDate});

  @override
  List<Object> get props => [finishDate];
}

class BudgetFormIsMonthlyChanged extends BudgetFormEvent {
  final bool isMonthly;

  BudgetFormIsMonthlyChanged({required this.isMonthly});

  @override
  List<Object> get props => [isMonthly];
}

class BudgetFormSubmitted extends BudgetFormEvent {}

class BudgetFormLoading extends BudgetFormEvent {
  final Budget? budgetToUpdate;

  BudgetFormLoading({this.budgetToUpdate});
}
