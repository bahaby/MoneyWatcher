import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_watcher/model/budget.dart';
import 'package:money_watcher/model/budget_date.dart';
import 'package:money_watcher/model/category.dart';

class DetailBudgetPage extends StatelessWidget {
  static const routeName = '/detail_budget_page';
  final Budget budget = Budget(
      name: "budget1",
      budgetDate: BudgetDate(
          startDate: DateTime.now(),
          finishDate: DateTime.now(),
          isMonthly: true),
      category: Category(name: "asdasd", id: 1),
      price: 5124,
      detail:
          "sdfgsdfgsdfgsdfgfghmkdlfgjhkfghilkdfgihdjfhjdfgşlhjdfghjdfghdfghjldfgjhlşdfgjhlşdfgjhşldfgjhşldfjhlsfjhsilgjhsfdlghjdflgjhdşflgjhldfjhfjhjfghjdfghjdfgkhjdflgjhldfjh",
      budgetType: true,
      categoryId: 1);
  DetailBudgetPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Container(
        padding: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                createBudgetDetailsItem("İsim : ", budget.name),
                createBudgetDetailsItem(
                    "Fiyat : ", budget.price.toStringAsFixed(2)),
                createBudgetDetailsItem(
                    "Bütçe Türü : ", budget.budgetType ? "Gelir" : "Gider"),
                createBudgetDetailsItem("Kategori", budget.category!.name),
                createBudgetDetailsItem("Başlangıç Tarihi : ",
                    DateFormat('d.MM.yy').format(budget.budgetDate.startDate)),
                budget.budgetDate.isMonthly
                    ? createBudgetDetailsItem(
                        "Bitiş Tarihi : ",
                        DateFormat('d.MM.yy')
                            .format(budget.budgetDate.finishDate!))
                    : Container(),
                createBudgetDetailsItem("isim", budget.name),
                createBudgetDetailsItem("isim", budget.name),
                createDetailsItem("Detay : ", budget.detail),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                createButton(
                    onClick: () {}, buttonName: "Sil", buttonColor: Colors.red),
                createButton(
                    onClick: () {},
                    buttonName: "Güncelle",
                    buttonColor: Colors.blue)
              ],
            )
          ],
        ),
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
      {required Function onClick,
      required String buttonName,
      required Color buttonColor}) {
    return Container(
      padding: EdgeInsets.all(2),
      child: ElevatedButton(
        child: Text(buttonName),
        onPressed: () => onClick,
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
}
