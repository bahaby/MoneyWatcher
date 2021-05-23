import 'package:equatable/equatable.dart';
import 'package:money_watcher/model/budget_date.dart';
import 'package:money_watcher/model/category.dart';
import 'package:money_watcher/model/user.dart';

import 'package:json_annotation/json_annotation.dart';

part 'budget.g.dart';

@JsonSerializable(includeIfNull: false)
class Budget extends Equatable {
  final String? id;
  final String name;
  final double price;
  final String detail;
  final bool budgetType;
  final User? user;
  final String userId;
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
    required this.userId,
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
}
