import 'package:get_it/get_it.dart';
import 'package:money_watcher/service/auth_service.dart';
import 'package:money_watcher/service/budget_service.dart';
import 'package:money_watcher/service/local_storage_service.dart';

final getIt = GetIt.instance;

Future setup() async {
  var localStorageInstance = await LocalStorageService.getInstance();
  getIt.registerSingleton<LocalStorageService>(localStorageInstance!);

  var authServiceInstance = AuthService();
  getIt.registerSingleton<AuthService>(authServiceInstance);

  var budgetServiceInstance = BudgetService();
  getIt.registerSingleton<BudgetService>(budgetServiceInstance);
}
