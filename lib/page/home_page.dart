import 'package:flutter/material.dart';
import 'package:money_watcher/page/add_budget_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

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
        body: TabBarView(
          children: [
            Center(child: Text("Günlük")),
            Center(child: Text("Haftalık")),
            Center(child: Text("Aylık")),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(AddBudgetPage.routeName);
          },
        ),
      ),
    );
  }
}
