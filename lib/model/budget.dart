import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:money_watcher/model/budget_date.dart';
import 'package:money_watcher/model/category.dart';
import 'package:money_watcher/model/user.dart';

part 'budget.g.dart';

@JsonSerializable(includeIfNull: false)
class Budget extends Equatable {
  final String? id;
  final String name;
  final double price;
  final String detail;
  final bool budgetType;
  final User? user;
  final String? userId;
  final Category? category;
  final int categoryId;
  final BudgetDate budgetDate;

  Budget({
    this.id,
    required this.name,
    required this.price,
    required this.detail,
    required this.budgetType,
    this.user,
    this.userId,
    this.category,
    required this.categoryId,
    required this.budgetDate,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        detail,
        budgetType,
        user,
        userId,
        category,
        categoryId,
        budgetDate,
      ];

  factory Budget.fromJson(Map<String, dynamic> json) => _$BudgetFromJson(json);
  Map<String, dynamic> toJson() => _$BudgetToJson(this);

  Budget copyWith({
    String? id,
    String? name,
    double? price,
    String? detail,
    bool? budgetType,
    User? user,
    String? userId,
    Category? category,
    int? categoryId,
    BudgetDate? budgetDate,
  }) {
    return Budget(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      detail: detail ?? this.detail,
      budgetType: budgetType ?? this.budgetType,
      user: user ?? this.user,
      userId: userId ?? this.userId,
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      budgetDate: budgetDate ?? this.budgetDate,
    );
  }
}
