// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Budget _$BudgetFromJson(Map<String, dynamic> json) {
  return Budget(
    id: json['id'] as String?,
    name: json['name'] as String,
    price: (json['price'] as num).toDouble(),
    detail: json['detail'] as String,
    budgetType: json['budgetType'] as bool,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    userId: json['userId'] as String,
    category: json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>),
    categoryId: json['categoryId'] as String,
    budgetDate: BudgetDate.fromJson(json['budgetDate'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BudgetToJson(Budget instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['name'] = instance.name;
  val['price'] = instance.price;
  val['detail'] = instance.detail;
  val['budgetType'] = instance.budgetType;
  writeNotNull('user', instance.user);
  val['userId'] = instance.userId;
  writeNotNull('category', instance.category);
  val['categoryId'] = instance.categoryId;
  val['budgetDate'] = instance.budgetDate;
  return val;
}
