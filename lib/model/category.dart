import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:money_watcher/model/budget.dart';

part 'category.g.dart';

@JsonSerializable(includeIfNull: false)
class Category extends Equatable {
  final int id;
  final String name;
  final List<Budget> budgets;

  Category({
    required this.id,
    required this.name,
    required this.budgets,
  });

  @override
  List<Object> get props => [id, name, budgets];

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
