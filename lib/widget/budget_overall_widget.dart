import 'package:flutter/material.dart';

class BudgetOverallWidget extends StatelessWidget {
  final double income;
  final double expense;
  const BudgetOverallWidget({
    Key? key,
    required this.income,
    required this.expense,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Column(
              children: [
                Text('Gelir'),
                Text(
                  income.toStringAsFixed(2),
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text('Gider'),
                Text(
                  expense.toStringAsFixed(2),
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text('Toplam'),
                Text(
                  (income - expense).toStringAsFixed(2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}