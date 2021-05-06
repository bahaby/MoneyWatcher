import 'package:flutter/material.dart';
import 'package:money_watcher/page/add_budget_page.dart';
import 'package:money_watcher/page/detail_budget_page.dart';
import 'package:money_watcher/page/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (_) => HomePage(),
        DetailBudgetPage.routeName: (_) => DetailBudgetPage(),
        AddBudgetPage.routeName: (_) => AddBudgetPage(),
      },
    );
  }
}
