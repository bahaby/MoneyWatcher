import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_watcher/bloc/budget/budget_detail/budget_detail_bloc.dart';
import 'package:money_watcher/page/detail_budget_page.dart';
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
      color: Colors.grey[800],
      margin: EdgeInsets.only(top: 4),
      child: ListTile(
        onTap: () {
          context
              .read<BudgetDetailBloc>()
              .add(GetBudget(budgetId: model.budgetId));
          Navigator.pushNamed(
            context,
            DetailBudgetPage.routeName,
          );
        },
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
