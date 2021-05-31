import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:money_watcher/bloc/form_submission_status.dart';
import 'package:money_watcher/model/budget.dart';
import 'package:money_watcher/model/budget_date.dart';
import 'package:money_watcher/page/add_update_budget_page.dart';
import 'package:money_watcher/page/home_page.dart';
import 'package:money_watcher/page/login_page.dart';
import 'package:money_watcher/service/budget_service.dart';
import 'package:money_watcher/service/local_storage_service.dart';
import 'package:money_watcher/service_locator.dart';

part 'budget_form_event.dart';
part 'budget_form_state.dart';

class BudgetFormBloc extends Bloc<BudgetFormEvent, BudgetFormState> {
  final budgetService = getIt<BudgetService>();
  final storageService = getIt<LocalStorageService>();
  final GlobalKey<NavigatorState> navigatorKey;
  BudgetFormBloc(
    this.navigatorKey,
  ) : super(BudgetFormState());

  @override
  Stream<BudgetFormState> mapEventToState(
    BudgetFormEvent event,
  ) async* {
    if (event is BudgetFormLoading) {
      navigatorKey.currentState!.pushNamed(AddUpdateBudgetPage.routeName);
      var stateData = BudgetFormState().copyWith(
        isUpdate: false,
      );
      if (event.budgetId != null) {
        yield stateData.copyWith(formStatus: FormLoading());
        final budget = await budgetService.getBudget(event.budgetId!);
        stateData = stateData.copyWith(
          id: budget.id,
          budgetType: budget.budgetType,
          categoryId: budget.categoryId,
          detail: budget.detail,
          isMonthly: budget.budgetDate.isMonthly,
          finishDate: budget.budgetDate.finishDate,
          startDate: budget.budgetDate.startDate,
          name: budget.name,
          price: budget.price.toString(),
          isUpdate: true,
          formStatus: InitialFormStatus(),
        );
      }
      yield stateData;
    } else if (event is BudgetFormNameChanged) {
      yield state.copyWith(name: event.name);
    } else if (event is BudgetFormPriceChanged) {
      yield state.copyWith(price: event.price);
    } else if (event is BudgetFormDetailChanged) {
      yield state.copyWith(detail: event.detail);
    } else if (event is BudgetFormBudgetTypeChanged) {
      yield state.copyWith(budgetType: event.budgetType);
    } else if (event is BudgetFormCategoryChanged) {
      yield state.copyWith(categoryId: event.categoryId);
    } else if (event is BudgetFormStartDateChanged) {
      yield state.copyWith(startDate: event.startDate);
    } else if (event is BudgetFormFinishDateChanged) {
      yield state.copyWith(finishDate: event.finishDate);
    } else if (event is BudgetFormIsMonthlyChanged) {
      yield state.copyWith(isMonthly: event.isMonthly);
    } else if (event is BudgetFormSubmitted) {
      if (!storageService.isJwtTokenValid()) {
        navigatorKey.currentState!.pushReplacementNamed(LoginPage.routeName);
      } else {
        yield state.copyWith(formStatus: FormLoading());
        var budgetToSubmit = Budget(
          id: state.id,
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
        );
        try {
          if (state.isUpdate) {
            print(1);
            await budgetService.updateBudget(budgetToSubmit);
          } else {
            await budgetService.addBudget(budgetToSubmit);
          }
          yield state.copyWith(formStatus: SubmissionSuccess());
          yield BudgetFormState();
          navigatorKey.currentState!
              .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
        } on Exception catch (e) {
          yield state.copyWith(formStatus: SubmissionFailed(e));
        }
      }
    } else if (event is DeleteBudget) {
      yield state.copyWith(formStatus: FormLoading());
      await budgetService.deleteBudget(event.budgetId);
      navigatorKey.currentState!
          .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
    }
  }
}
