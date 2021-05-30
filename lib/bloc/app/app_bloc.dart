import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:money_watcher/model/category.dart';
import 'package:money_watcher/service/budget_service.dart';

import '../../service_locator.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final budgetService = getIt<BudgetService>();
  AppBloc() : super(AppInitial()) {
    add(GetData());
  }

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is GetData) {
      yield AppLoading();
      final categories = await budgetService.getCategories();
      yield AppLoaded(categories: categories);
    }
  }
}
