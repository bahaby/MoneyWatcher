import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:money_watcher/bloc/app/app_bloc.dart';
import 'package:money_watcher/bloc/budget/budget_detail/budget_detail_bloc.dart';
import 'package:money_watcher/bloc/budget/budget_form/budget_form_bloc.dart';
import 'package:money_watcher/model/category.dart';

class DetailBudgetPage extends StatefulWidget {
  static const routeName = '/detail_budget_page';
  DetailBudgetPage({Key? key}) : super(key: key);

  @override
  _DetailBudgetPageState createState() => _DetailBudgetPageState();
}

class _DetailBudgetPageState extends State<DetailBudgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: BlocBuilder<BudgetDetailBloc, BudgetDetailState>(
        builder: (context, state) {
          return (state is BudgetDetailLoaded)
              ? Container(
                  padding: EdgeInsets.all(50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          createBudgetDetailsItem("İsim : ", state.budget.name),
                          createBudgetDetailsItem("Fiyat : ",
                              state.budget.price.toStringAsFixed(2)),
                          createBudgetDetailsItem("Bütçe Türü : ",
                              state.budget.budgetType ? "Gelir" : "Gider"),
                          createBudgetDetailsItem("Kategori",
                              _idToCategory(state.budget.categoryId)),
                          createBudgetDetailsItem(
                              "Başlangıç Tarihi : ",
                              DateFormat('d.MM.yy')
                                  .format(state.budget.budgetDate.startDate)),
                          state.budget.budgetDate.isMonthly
                              ? createBudgetDetailsItem(
                                  "Bitiş Tarihi : ",
                                  DateFormat('d.MM.yy').format(
                                      state.budget.budgetDate.finishDate!))
                              : Container(),
                          createBudgetDetailsItem("isim", state.budget.name),
                          createBudgetDetailsItem("isim", state.budget.name),
                          createDetailsItem("Detay : ", state.budget.detail),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          createButton(
                              onClick: () {
                                context.read<BudgetDetailBloc>().add(
                                    DeleteBudget(budgetId: state.budget.id!));
                              },
                              buttonName: "Sil",
                              buttonColor: Colors.red),
                          createButton(
                              onClick: () {
                                context.read<BudgetFormBloc>().add(
                                    BudgetFormLoading(
                                        budgetToUpdate: state.budget));
                              },
                              buttonName: "Güncelle",
                              buttonColor: Colors.blue)
                        ],
                      )
                    ],
                  ),
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget createBudgetDetailsItem(String itemName, String itemValue) {
    return Container(
      padding: EdgeInsets.all(2),
      child: Row(
        children: [
          SizedBox(
            child: Text(itemName, style: TextStyle(fontSize: 20)),
            width: 150,
          ),
          Text(itemValue, style: TextStyle(fontSize: 15))
        ],
      ),
    );
  }

  Widget createButton(
      {required Function() onClick,
      required String buttonName,
      required Color buttonColor}) {
    return Container(
      padding: EdgeInsets.all(2),
      child: ElevatedButton(
        child: Text(buttonName),
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
            primary: buttonColor, fixedSize: Size(120, 50)),
      ),
    );
  }

  Widget createDetailsItem(String itemName, String itemValue) {
    return Container(
      padding: EdgeInsets.all(2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(itemName, style: TextStyle(fontSize: 20)),
          SizedBox(height: 5),
          Text(itemValue, style: TextStyle(fontSize: 15)),
        ],
      ),
    );
  }

  String _idToCategory(int categoryId) {
    var categories = (context.read<AppBloc>().state as AppLoaded).categories;
    return categories.firstWhere((category) => category.id == categoryId).name;
  }
}
