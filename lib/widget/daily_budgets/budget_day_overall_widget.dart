import 'package:flutter/material.dart';
import 'package:money_watcher/view_model/daily_budget_view_model.dart';
import 'package:money_watcher/widget/budget_overall_widget.dart';
import 'package:money_watcher/widget/daily_budgets/budget_day_widget.dart';

class BudgetDayOverallWidget extends StatelessWidget {
  final DailyBudgetViewModel model;
  BudgetDayOverallWidget({
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
              children: model.daysBudgetsItems
                  .map((model) => BudgetDayWidget(model: model))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
