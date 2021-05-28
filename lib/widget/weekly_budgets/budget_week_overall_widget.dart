import 'package:flutter/material.dart';

import 'package:money_watcher/view_model/weekly_budget_view_model.dart';
import 'package:money_watcher/widget/budget_overall_widget.dart';
import 'package:money_watcher/widget/weekly_budgets/budget_week_item_widget.dart';

class BudgetWeekOverallWidget extends StatelessWidget {
  final WeeklyBudgetViewModel model;
  BudgetWeekOverallWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: BudgetOverallWidget(
            income: model.monthIncome,
            expense: model.monthExpense,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: model.weekBudgetItems
                  .map((model) => BudgetWeekItemWidget(model: model))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
