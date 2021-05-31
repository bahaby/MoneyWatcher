import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:money_watcher/bloc/app/app_bloc.dart';
import 'package:money_watcher/bloc/auth/login/login_bloc.dart';
import 'package:money_watcher/bloc/auth/register/register_bloc.dart';
import 'package:money_watcher/bloc/budget/budget_bloc.dart';
import 'package:money_watcher/bloc/budget/budget_form/budget_form_bloc.dart';
import 'package:money_watcher/page/add_update_budget_page.dart';
import 'package:money_watcher/page/home_page.dart';
import 'package:money_watcher/page/login_page.dart';
import 'package:money_watcher/page/register_page.dart';
import 'package:money_watcher/service/local_storage_service.dart';
import 'package:money_watcher/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'tr_TR';
  initializeDateFormatting();
  await setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  final storageService = getIt<LocalStorageService>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => BudgetFormBloc(_navigatorKey),
        ),
        BlocProvider(
          create: (context) => BudgetBloc(_navigatorKey),
        )
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xff3F51B5),
          backgroundColor: Color(0xff3F51B5),
          scaffoldBackgroundColor: Color(0xff3F51B5),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xffFF5252))),
          ),
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: Color(0xffFF5252)),
          tabBarTheme: TabBarTheme(
            indicator: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)),
              ),
              color: Color(0xffFF5252),
            ),
          ),
        ),
        navigatorKey: _navigatorKey,
        title: 'Material App',
        initialRoute: (storageService.isJwtTokenValid())
            ? HomePage.routeName
            : LoginPage.routeName,
        routes: {
          HomePage.routeName: (_) => HomePage(),
          LoginPage.routeName: (_) => LoginPage(),
          RegisterPage.routeName: (_) => RegisterPage(),
          AddUpdateBudgetPage.routeName: (_) => AddUpdateBudgetPage(),
        },
      ),
    );
  }
}
