import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'budget_date.g.dart';

@JsonSerializable(includeIfNull: false)
class BudgetDate extends Equatable {
  final String? id;
  final DateTime startDate;
  final DateTime finishDate;
  final bool isMountly;
  final String? budgetId;

  BudgetDate({
    this.id,
    required this.startDate,
    required this.finishDate,
    required this.isMountly,
    this.budgetId,
  });

  @override
  List<Object?> get props => [id, startDate, finishDate, isMountly, budgetId];

  factory BudgetDate.fromJson(Map<String, dynamic> json) =>
      _$BudgetDateFromJson(json);
  Map<String, dynamic> toJson() => _$BudgetDateToJson(this);
}
