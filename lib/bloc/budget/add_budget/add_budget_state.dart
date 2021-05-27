part of 'add_budget_bloc.dart';

class AddBudgetState extends Equatable {
  final String name;
  final String price;
  final String detail;
  final bool? budgetType;
  final int? categoryId;
  final List<Category> categories;
  late final DateTime startDate;
  late final DateTime? finishDate;
  final bool isMonthly;
  final FormSubmissionStatus formStatus;

  AddBudgetState({
    this.name = "",
    this.price = "",
    this.detail = "",
    this.budgetType,
    this.categoryId,
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
    String? price,
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

  bool get isValidName {
    return name.length > 3;
  }

  bool get isValidPrice {
    return double.tryParse(price) != null;
  }

  bool get isValidDetail {
    return detail.length > 10;
  }

  bool get isValidBudgetType {
    return budgetType != null;
  }

  bool get isValidCategory {
    return categoryId != null;
  }
}
