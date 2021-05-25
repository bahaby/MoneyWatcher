import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:money_watcher/bloc/auth/login/login_bloc.dart';
import 'package:money_watcher/bloc/auth/register/register_bloc.dart';
import 'package:money_watcher/bloc/budget/add_budget/add_budget_bloc.dart';
import 'package:money_watcher/page/add_budget_page.dart';
import 'package:money_watcher/page/detail_budget_page.dart';
import 'package:money_watcher/page/home_page.dart';
import 'package:money_watcher/page/login_page.dart';
import 'package:money_watcher/page/register_page.dart';
import 'package:money_watcher/service/auth_service.dart';
import 'package:money_watcher/service/local_storage_service.dart';
import 'package:money_watcher/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final storageService = getIt<LocalStorageService>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => AddBudgetBloc(),
        )
      ],
      child: MaterialApp(
        title: 'Material App',
        initialRoute: (storageService.isJwtTokenValid())
            ? HomePage.routeName
            : LoginPage.routeName,
        routes: {
          HomePage.routeName: (_) => HomePage(),
          LoginPage.routeName: (_) => LoginPage(),
          RegisterPage.routeName: (_) => RegisterPage(),
          DetailBudgetPage.routeName: (_) => DetailBudgetPage(),
          AddBudgetPage.routeName: (_) => AddBudgetPage(),
        },
      ),
    );
  }
}
