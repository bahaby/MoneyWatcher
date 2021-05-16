import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_watcher/bloc/auth/login/login_bloc.dart';
import 'package:money_watcher/bloc/auth/register/register_bloc.dart';
import 'package:money_watcher/page/add_budget_page.dart';
import 'package:money_watcher/page/detail_budget_page.dart';
import 'package:money_watcher/page/home_page.dart';
import 'package:money_watcher/page/login_page.dart';
import 'package:money_watcher/page/register_page.dart';
import 'package:money_watcher/service/auth_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthService()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(context.read<AuthService>()),
          ),
          BlocProvider(
            create: (context) => RegisterBloc(context.read<AuthService>()),
          )
        ],
        child: MaterialApp(
          title: 'Material App',
          initialRoute: LoginPage.routeName,
          routes: {
            HomePage.routeName: (_) => HomePage(),
            LoginPage.routeName: (_) => LoginPage(),
            RegisterPage.routeName: (_) => RegisterPage(),
            DetailBudgetPage.routeName: (_) => DetailBudgetPage(),
            AddBudgetPage.routeName: (_) => AddBudgetPage(),
          },
        ),
      ),
    );
  }
}
