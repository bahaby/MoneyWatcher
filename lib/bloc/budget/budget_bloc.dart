import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:money_watcher/model/budget.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  BudgetBloc() : super(BudgetInitial());

  @override
  Stream<BudgetState> mapEventToState(
    BudgetEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
