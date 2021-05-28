import 'package:flutter/material.dart';
import 'package:money_watcher/model/budget.dart';

class WeeklyBudgetViewModel {
  final double monthIncome;
  final double monthExpense;
  List<WeeklyBudgetItemViewModel> weekBudgetItems;
  WeeklyBudgetViewModel({
    required this.monthIncome,
    required this.monthExpense,
    required this.weekBudgetItems,
  });

  factory WeeklyBudgetViewModel.fromBudgets(
      {required List<Budget> budgetsToMap, required DateTime selectedDate}) {
    List<Budget> budgets = List.from(budgetsToMap);
    double monthExpense = 0;
    double monthIncome = 0;
    DateTime firstDayOfMonth =
        DateTime(selectedDate.year, selectedDate.month, 1);
    //for storing days which have budgets
    List<DateTime> days = [];
    List<WeeklyBudgetItemViewModel> weekBudgetItems = [];

    budgets.forEach((budget) {
      var date = budget.budgetDate.startDate;
      //if day isn't already in list add that day
      if (!days.any((day) => day.day == date.day)) {
        days.add(DateTime(selectedDate.year, selectedDate.month, date.day));
      }

      //looking budgets for monthly income and expense
      if (budget.budgetType == false) {
        monthExpense += budget.price;
      } else {
        monthIncome += budget.price;
      }
      //to get date of current month
    });
    var firstWeekStartDate =
        firstDayOfMonth.subtract(Duration(days: firstDayOfMonth.weekday - 1));
    for (var i = firstWeekStartDate;
        i.isBefore(DateUtils.addMonthsToMonthDate(firstDayOfMonth, 1));
        i = i.add(Duration(days: 7))) {
      double weekIncome = 0;
      double weekExpense = 0;
      //getting days which have budget in that week
      var daysOfWeek =
          days.where((day) => day.day >= i.day && day.day <= i.day + 6);
      budgets.forEach((budget) {
        if (daysOfWeek
            .any((day) => day.day == budget.budgetDate.startDate.day)) {
          if (budget.budgetType == false) {
            weekExpense += budget.price;
          } else {
            weekIncome += budget.price;
          }
        }
      });
      weekBudgetItems.add(WeeklyBudgetItemViewModel(
        weekExpense: weekExpense,
        weekIncome: weekIncome,
        startOfWeek: i,
        endOfWeek: i.add(Duration(days: 6)),
      ));
    }

    return WeeklyBudgetViewModel(
      weekBudgetItems: weekBudgetItems,
      monthExpense: monthExpense,
      monthIncome: monthIncome,
    );
  }
}

class WeeklyBudgetItemViewModel {
  final DateTime startOfWeek;
  final DateTime endOfWeek;
  final double weekIncome;
  final double weekExpense;
  WeeklyBudgetItemViewModel({
    required this.startOfWeek,
    required this.endOfWeek,
    required this.weekIncome,
    required this.weekExpense,
  });
}
