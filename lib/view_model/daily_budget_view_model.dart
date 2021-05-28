import 'package:money_watcher/model/budget.dart';
import 'package:money_watcher/model/category.dart';

class DailyBudgetViewModel {
  final double monthIncome;
  final double monthExpense;
  List<DailyBudgetsItemViewModel> daysBudgetsItems;
  DailyBudgetViewModel({
    required this.monthIncome,
    required this.monthExpense,
    required this.daysBudgetsItems,
  });

  factory DailyBudgetViewModel.fromBudgets({
    required List<Budget> budgetsToMap,
    required List<Category> categories,
  }) {
    List<Budget> budgets = List.from(budgetsToMap);
    double monthExpense = 0;
    double monthIncome = 0;
    //for storing days which have budgets
    List<DateTime> days = [];

    List<DailyBudgetsItemViewModel> daysBudgetsItems = [];
    budgets.forEach((budget) {
      var date = budget.budgetDate.startDate;
      //if day isn't already in list add that day
      if (!days.any((day) => date.difference(day).inDays == 0)) {
        days.add(date);
      }

      //looking budgets for monthly income and expense
      if (budget.budgetType == false) {
        monthExpense += budget.price;
      } else {
        monthIncome += budget.price;
      }
    });
    if (days.isEmpty) {
      return DailyBudgetViewModel(
        daysBudgetsItems: daysBudgetsItems,
        monthExpense: monthExpense,
        monthIncome: monthIncome,
      );
    }
    days.forEach((day) {
      //for storing day's budget view models
      List<DailyBudgetItemViewModel> dayBudgetItems = [];

      double dayExpense = 0;
      double dayIncome = 0;
      //getting day's budgets
      var dayBudgets = budgets
          .where((budget) =>
              budget.budgetDate.startDate.difference(day).inDays == 0)
          .toList();
      //looping through day's budgets
      dayBudgets.forEach((budget) {
        //storing day's budget view models
        dayBudgetItems.add(DailyBudgetItemViewModel(
          price: budget.price,
          budgetType: budget.budgetType,
          name: budget.name,
          detail: budget.detail,
          category: categories
              .firstWhere((category) => category.id == budget.categoryId)
              .name,
        ));

        //calculating daily expanses and incomes
        if (budget.budgetType == false) {
          dayExpense += budget.price;
        } else {
          dayIncome += budget.price;
        }
      });

      //adding results to day's budgets view model for each day
      daysBudgetsItems.add(DailyBudgetsItemViewModel(
        day: day,
        dayIncome: dayIncome,
        dayExpense: dayExpense,
        dayBudgetItems: dayBudgetItems,
      ));
    });
    daysBudgetsItems.sort((a, b) {
      return b.day.compareTo(a.day);
    });
    return DailyBudgetViewModel(
      monthIncome: monthIncome,
      monthExpense: monthExpense,
      daysBudgetsItems: daysBudgetsItems,
    );
  }
}

class DailyBudgetsItemViewModel {
  final DateTime day;
  final double dayIncome;
  final double dayExpense;
  final List<DailyBudgetItemViewModel> dayBudgetItems;

  DailyBudgetsItemViewModel({
    required this.day,
    required this.dayIncome,
    required this.dayExpense,
    required this.dayBudgetItems,
  });
}

class DailyBudgetItemViewModel {
  final double price;
  final bool budgetType;
  final String name;
  final String detail;
  final String category;
  DailyBudgetItemViewModel({
    required this.price,
    required this.budgetType,
    required this.name,
    required this.detail,
    required this.category,
  });
}
