import 'package:flutter/material.dart';
import 'package:money_watcher/view_model/daily_budget_view_model.dart';

class BudgetDayItemWidget extends StatelessWidget {
  final DailyBudgetItemViewModel model;
  BudgetDayItemWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.zero,
      ),
      margin: EdgeInsets.only(top: 0),
      child: ListTile(
        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        dense: true,
        leading: SizedBox(width: 60, child: Text(model.category)),
        title: Text(model.name),
        trailing: Text(
          model.price.toStringAsFixed(2) + ' ₺',
          style: TextStyle(
            color: model.budgetType ? Colors.blue : Colors.red,
          ),
        ),
      ),
    );
  }
}
