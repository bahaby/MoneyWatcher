import 'package:flutter/material.dart';
import 'package:money_watcher/model/user.dart';
import 'package:money_watcher/page/add_budget_page.dart';
import 'package:money_watcher/service/auth_service.dart';

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
        body: Stack(
          children: [
            Text("Test"),
            TabBarView(
              children: [
                Center(
                    child: Column(
                  children: [
                    Text("Günlük"),
                    ElevatedButton(
                        onPressed: () async {
                          final service = AuthService();
                          print(await service.login(
                              User(email: "baha@by.com", password: "1")));
                        },
                        child: Text("Login")),
                    ElevatedButton(
                        onPressed: () async {
                          final service = AuthService();
                          var response = await service.register(User(
                              fullName: "Baha",
                              email: "baha@by.com",
                              password: "1"));
                          print(response.password + " - " + response.fullName);
                        },
                        child: Text("Register")),
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
          onPressed: () {
            Navigator.of(context).pushNamed(AddBudgetPage.routeName);
          },
        ),
      ),
    );
  }
}
