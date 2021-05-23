import 'package:flutter/material.dart';
import 'package:money_watcher/model/budget.dart';
import 'package:money_watcher/model/budget_date.dart';
import 'package:money_watcher/page/add_budget_page.dart';
import 'package:money_watcher/service/budget_service.dart';
import 'package:money_watcher/service/local_storage_service.dart';
import 'package:money_watcher/service_locator.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';
  final storageService = getIt<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Text("Günlük"),
              Text("Haftalık"),
              Text("Aylık"),
            ],
          ),
          title: Text('Home'),
        ),
        body: Stack(
          children: [
            Text("Test"),
            TabBarView(
              children: [
                Center(
                    child: Column(
                  children: [
                    Text("Günlük"),
                  ],
                )),
                Center(child: Text("Haftalık")),
                Center(child: Text("Aylık")),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            BudgetService budgetService = BudgetService();
            var response = await budgetService.addBudget(Budget(
                name: "name",
                price: 10,
                detail: "test",
                budgetType: true,
                userId: "e30af091-bfb3-4455-4b66-08d91e1840e8",
                categoryId: 2,
                budgetDate: BudgetDate(
                    finishDate: DateTime.now().add(Duration(days: 5)),
                    startDate: DateTime.now(),
                    isMonthly: true)));
            print(response.toString());
            //Navigator.of(context).pushNamed(AddBudgetPage.routeName);
          },
        ),
      ),
    );
  }
}
