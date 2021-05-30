part of 'budget_form_bloc.dart';

class BudgetFormState extends Equatable {
  final String id;
  final String name;
  final String price;
  final String detail;
  final bool? budgetType;
  final int? categoryId;
  late final DateTime startDate;
  late final DateTime finishDate;
  final bool isMonthly;
  final FormSubmissionStatus formStatus;
  final bool isUpdate;

  BudgetFormState({
    this.id = "",
    this.name = "",
    this.price = "",
    this.detail = "",
    this.budgetType,
    this.categoryId,
    startDate,
    finishDate,
    this.isMonthly = false,
    this.isUpdate = false,
    this.formStatus = const InitialFormStatus(),
  }) {
    this.startDate = startDate ?? DateTime.now();
    this.finishDate = finishDate ??
        DateUtils.addMonthsToMonthDate(DateTime.now(), 1)
            .add(Duration(days: DateTime.now().day - 1));
  }

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        detail,
        budgetType,
        categoryId,
        startDate,
        isUpdate,
        finishDate,
        isMonthly,
        formStatus,
      ];

  BudgetFormState copyWith({
    String? id,
    String? name,
    String? price,
    String? detail,
    bool? budgetType,
    int? categoryId,
    DateTime? startDate,
    DateTime? finishDate,
    bool? isMonthly,
    FormSubmissionStatus? formStatus,
    bool? isUpdate,
  }) {
    return BudgetFormState(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      detail: detail ?? this.detail,
      budgetType: budgetType ?? this.budgetType,
      categoryId: categoryId ?? this.categoryId,
      startDate: startDate ?? this.startDate,
      finishDate: finishDate ?? this.finishDate,
      isMonthly: isMonthly ?? this.isMonthly,
      formStatus: formStatus ?? this.formStatus,
      isUpdate: isUpdate ?? this.isUpdate,
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
