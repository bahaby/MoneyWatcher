part of 'add_budget_bloc.dart';

class AddBudgetState extends Equatable {
  final String name;
  final double price;
  final String detail;
  final bool budgetType;
  final int categoryId;
  final List<Category> categories;
  late final DateTime startDate;
  late final DateTime? finishDate;
  final bool isMonthly;
  final FormSubmissionStatus formStatus;

  AddBudgetState({
    this.name = "",
    this.price = 0,
    this.detail = "",
    this.budgetType = false,
    this.categoryId = 0,
    this.categories = const [],
    startDate,
    this.finishDate,
    this.isMonthly = false,
    this.formStatus = const FormLoading(),
  }) {
    this.startDate = startDate ?? DateTime.now();
  }

  @override
  List<Object?> get props => [
        name,
        price,
        detail,
        budgetType,
        categoryId,
        categories,
        startDate,
        finishDate,
        isMonthly,
        formStatus,
      ];

  AddBudgetState copyWith({
    String? name,
    double? price,
    String? detail,
    bool? budgetType,
    int? categoryId,
    List<Category>? categories,
    String? userId,
    DateTime? startDate,
    DateTime? finishDate,
    bool? isMonthly,
    FormSubmissionStatus? formStatus,
  }) {
    return AddBudgetState(
      name: name ?? this.name,
      price: price ?? this.price,
      detail: detail ?? this.detail,
      budgetType: budgetType ?? this.budgetType,
      categoryId: categoryId ?? this.categoryId,
      categories: categories ?? this.categories,
      startDate: startDate ?? this.startDate,
      finishDate: finishDate ?? this.finishDate,
      isMonthly: isMonthly ?? this.isMonthly,
      formStatus: formStatus ?? this.formStatus,
    );
  }
  // TODO: validation missing
}
