import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:money_watcher/bloc/form_submission_status.dart';
import 'package:money_watcher/model/budget.dart';
import 'package:money_watcher/model/budget_date.dart';
import 'package:money_watcher/model/category.dart';
import 'package:money_watcher/page/login_page.dart';
import 'package:money_watcher/service/budget_service.dart';
import 'package:money_watcher/service/local_storage_service.dart';
import 'package:money_watcher/service_locator.dart';

part 'add_budget_event.dart';
part 'add_budget_state.dart';

class AddBudgetBloc extends Bloc<AddBudgetEvent, AddBudgetState> {
  final budgetService = getIt<BudgetService>();
  final storageService = getIt<LocalStorageService>();
  final GlobalKey<NavigatorState> navigatorKey;
  AddBudgetBloc(
    this.navigatorKey,
  ) : super(AddBudgetState()) {
    add(AddBudgetLoading());
  }

  @override
  Stream<AddBudgetState> mapEventToState(
    AddBudgetEvent event,
  ) async* {
    if (event is AddBudgetLoading) {
      final categories = await budgetService.getCategories();
      yield state.copyWith(
        formStatus: InitialFormStatus(),
        categories: categories,
      );
    } else if (event is AddBudgetNameChanged) {
      yield state.copyWith(name: event.name);
    } else if (event is AddBudgetPriceChanged) {
      yield state.copyWith(price: event.price);
    } else if (event is AddBudgetDetailChanged) {
      yield state.copyWith(detail: event.detail);
    } else if (event is AddBudgetBudgetTypeChanged) {
      yield state.copyWith(budgetType: event.budgetType);
    } else if (event is AddBudgetCategoryChanged) {
      yield state.copyWith(categoryId: event.categoryId);
    } else if (event is AddBudgetStartDateChanged) {
      yield state.copyWith(startDate: event.startDate);
    } else if (event is AddBudgetFinishDateChanged) {
      yield state.copyWith(finishDate: event.finishDate);
    } else if (event is AddBudgetIsMonthlyChanged) {
      yield state.copyWith(isMonthly: event.isMonthly);
    } else if (event is AddBudgetSubmitted) {
      if (!storageService.isJwtTokenValid()) {
        navigatorKey.currentState!.pushNamed(LoginPage.routeName);
      } else {
        yield state.copyWith(formStatus: FormSubmitting());
        try {
          await budgetService.addBudget(Budget(
            budgetDate: BudgetDate(
              finishDate: (state.isMonthly) ? state.finishDate : null,
              startDate: state.startDate,
              isMonthly: state.isMonthly,
            ),
            budgetType: state.budgetType!,
            categoryId: state.categoryId!,
            detail: state.detail,
            name: state.name,
            price: double.parse(state.price),
          ));
          yield state.copyWith(formStatus: SubmissionSuccess());
          yield AddBudgetState().copyWith(
            formStatus: InitialFormStatus(),
            categories: state.categories,
          );
        } on Exception catch (e) {
          yield state.copyWith(formStatus: SubmissionFailed(e));
        }
      }
    }
  }
}
