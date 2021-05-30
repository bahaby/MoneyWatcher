import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_watcher/view_model/daily_budget_view_model.dart';
import 'package:money_watcher/widget/daily_budgets/budget_day_item_widget.dart';

class BudgetDayWidget extends StatelessWidget {
  final DailyBudgetsItemViewModel model;
  const BudgetDayWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.zero,
            ),
            child: ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -3),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              dense: true,
              leading: Text(
                model.day.day.toString(),
                style: TextStyle(fontSize: 25),
              ),
              title: Text(DateFormat('MM.y').format(model.day)),
              subtitle: Text(
                DateFormat('E').format(model.day),
                style: TextStyle(fontSize: 14.0),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      model.dayIncome.toStringAsFixed(2) + ' ₺',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      model.dayExpense.toStringAsFixed(2) + ' ₺',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ...model.dayBudgetItems
              .map((model) => BudgetDayItemWidget(model: model)),
        ],
      ),
    );
  }
}
