import 'package:flutter/material.dart';
import 'package:money_watcher/page/add_budget_page.dart';
import 'package:money_watcher/service/local_storage_service.dart';
import 'package:money_watcher/service_locator.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';
  final storageService = getIt<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    print(storageService.getFromDisk('token'));
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
            Navigator.of(context).pushNamed(AddBudgetPage.routeName);
          },
        ),
      ),
    );
  }
}
