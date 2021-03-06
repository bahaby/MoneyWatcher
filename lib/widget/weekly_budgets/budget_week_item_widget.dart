import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:money_watcher/view_model/weekly_budget_view_model.dart';

class BudgetWeekItemWidget extends StatelessWidget {
  final WeeklyBudgetItemViewModel model;
  const BudgetWeekItemWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[800],
      margin: EdgeInsets.all(2),
      child: ListTile(
        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        leading: Container(
          padding: EdgeInsets.all(3),
          child: Text(
            DateFormat('dd.MM').format(model.startOfWeek) +
                ' - ' +
                DateFormat('dd.MM').format(model.endOfWeek),
            style: TextStyle(fontSize: 14),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              model.weekIncome.toStringAsFixed(2) + ' ₺',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            SizedBox(
              width: 100,
              child: Text(
                model.weekExpense.toStringAsFixed(2) + ' ₺',
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
