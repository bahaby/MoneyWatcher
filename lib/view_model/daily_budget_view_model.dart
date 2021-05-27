import 'package:money_watcher/model/budget.dart';

class DailyBudgetViewModel {
  final double monthIncome;
  final double monthExpense;
  List<DailyBudgetsItemViewModel> daysBudgetsItems;
  DailyBudgetViewModel({
    required this.monthIncome,
    required this.monthExpense,
    required this.daysBudgetsItems,
  });

  factory DailyBudgetViewModel.fromBudgets(List<Budget> budgetsToMap) {
    List<Budget> budgets = List.from(budgetsToMap);
    double monthExpense = 0;
    double monthIncome = 0;
    //for storing days which have budgets
    List<int> days = [];

    List<DailyBudgetsItemViewModel> daysBudgetsItems = [];
    budgets.forEach((budget) {
      //if day isn't already in list add that day
      if (!days.contains(budget.budgetDate.startDate.day)) {
        days.add(budget.budgetDate.startDate.day);
      }

      //looking budgets for monthly income and expense
      if (budget.budgetType == false) {
        monthExpense += budget.price;
      } else {
        monthIncome += budget.price;
      }
    });

    days.forEach((dayNumber) {
      //for storing day's budget view models
      List<DailyBudgetItemViewModel> dayBudgetItems = [];
      double dayExpense = 0;
      double dayIncome = 0;

      //getting day's budgets
      var dayBudgets = budgets
          .where((budget) => budget.budgetDate.startDate.day == dayNumber)
          .toList();

      DateTime day = dayBudgets.first.budgetDate.startDate;

      //looping through day's budgets
      dayBudgets.forEach((budget) {
        //storing day's budget view models
        dayBudgetItems.add(DailyBudgetItemViewModel(
          price: budget.price,
          budgetType: budget.budgetType,
          name: budget.name,
          detail: budget.detail,
          categoryId: budget.categoryId,
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
  final int categoryId;
  DailyBudgetItemViewModel({
    required this.price,
    required this.budgetType,
    required this.name,
    required this.detail,
    required this.categoryId,
  });
}
