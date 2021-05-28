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
      {required List<Budget> budgetsToMap}) {
    List<Budget> budgets = List.from(budgetsToMap);
    double monthExpense = 0;
    double monthIncome = 0;
    //for storing days which have budgets
    List<DateTime> days = [];
    DateTime? currentDate;
    List<WeeklyBudgetItemViewModel> weekBudgetItems = [];

    budgets.forEach((budget) {
      var date = budget.budgetDate.startDate;
      if (days.isEmpty) {
        currentDate = DateTime(date.year, date.month, 1);
      }
      //if day isn't already in list add that day
      if (!days.any((day) => day.day == date.day && day.month == date.month)) {
        days.add(budget.budgetDate.startDate);
      }

      //looking budgets for monthly income and expense
      if (budget.budgetType == false) {
        monthExpense += budget.price;
      } else {
        monthIncome += budget.price;
      }
      //to get date of current month
    });

    if (days.isEmpty) {
      return WeeklyBudgetViewModel(
        weekBudgetItems: weekBudgetItems,
        monthExpense: monthExpense,
        monthIncome: monthIncome,
      );
    }
    var firstWeekStartDate =
        currentDate!.subtract(Duration(days: currentDate!.weekday - 1));
    for (var i = firstWeekStartDate;
        i.month <= currentDate!.month && i.year == currentDate!.year;
        i = i.add(Duration(days: 7))) {
      double weekIncome = 0;
      double weekExpense = 0;
      //getting days which have budget in that week
      var daysOfWeek = days.where(
          (day) => day.isAfter(i) && day.isBefore(i.add(Duration(days: 6))));
      budgets.forEach((budget) {
        if (daysOfWeek.any(
            (day) => day.difference(budget.budgetDate.startDate).inDays == 0)) {
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
