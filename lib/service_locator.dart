import 'package:get_it/get_it.dart';
import 'package:money_watcher/service/local_storage_service.dart';

final getIt = GetIt.instance;

Future setup() async {
  var localStorageInstance = await LocalStorageService.getInstance();
  getIt.registerSingleton<LocalStorageService>(localStorageInstance!);
}
