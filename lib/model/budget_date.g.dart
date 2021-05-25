// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_date.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetDate _$BudgetDateFromJson(Map<String, dynamic> json) {
  return BudgetDate(
    id: json['id'] as String?,
    startDate: DateTime.parse(json['startDate'] as String),
    finishDate: json['finishDate'] == null
        ? null
        : DateTime.parse(json['finishDate'] as String),
    isMonthly: json['isMonthly'] as bool,
    budgetId: json['budgetId'] as String?,
  );
}

Map<String, dynamic> _$BudgetDateToJson(BudgetDate instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['startDate'] = instance.startDate.toIso8601String();
  writeNotNull('finishDate', instance.finishDate?.toIso8601String());
  val['isMonthly'] = instance.isMonthly;
  writeNotNull('budgetId', instance.budgetId);
  return val;
}
