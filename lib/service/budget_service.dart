import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:money_watcher/model/budget.dart';
import 'package:money_watcher/model/category.dart';
import 'package:money_watcher/service_locator.dart';
import '../ngrok_id.dart';
import 'local_storage_service.dart';

class BudgetService {
  final String budgetUrl = "https://$NGROK_ID.ngrok.io/api/budget/";
  final String categoryUrl = "https://$NGROK_ID.ngrok.io/api/category/";

  var storageService = getIt<LocalStorageService>();

  Future<Budget> addBudget(Budget budget) async {
    final token = storageService.getJwtToken();
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + token,
    };
    final data = jsonEncode(budget.toJson());
    http.Response response = await http.post(
      Uri.parse(budgetUrl),
      headers: headers,
      body: data,
    );
    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Budget.fromJson(responseData['data']);
    } else {
      throw Exception("add budget error");
    }
  }

  Future<Budget> updateBudget(Budget budget) async {
    final token = storageService.getJwtToken();
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + token,
    };
    final data = jsonEncode(budget.toJson());
    http.Response response = await http.put(
      Uri.parse(budgetUrl),
      headers: headers,
      body: data,
    );
    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Budget.fromJson(responseData['data']);
    } else {
      throw Exception("add budget error");
    }
  }

  Future<bool> deleteBudget(String budgetId) async {
    final token = storageService.getJwtToken();
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + token,
    };
    final data = jsonEncode({"id": budgetId});
    http.Response response = await http.delete(
      Uri.parse(budgetUrl),
      headers: headers,
      body: data,
    );
    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(responseData.toString());
      return responseData['status'];
    } else {
      throw Exception("add budget error");
    }
  }

  Future<Budget> getBudget(String budgetId) async {
    final token = storageService.getJwtToken();
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + token,
    };
    var queryParameters = {"id": "$budgetId"};
    http.Response response = await http.get(
      Uri.parse(budgetUrl + 'getBudget').replace(
        queryParameters: queryParameters,
      ),
      headers: headers,
    );
    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(responseData.toString());
      return Budget.fromJson(responseData['data']);
    } else {
      throw Exception("add budget error");
    }
  }

  Future<List<Budget>> getMonthBudgets(
      {required int year, required int month}) async {
    final token = storageService.getJwtToken();
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + token,
    };
    var queryParameters = {
      "monthNum": '$month',
      "yearNum": '$year',
    };
    var url = Uri.parse(budgetUrl + 'getbudgetswithdate')
        .replace(queryParameters: queryParameters);
    http.Response response = await http.get(url, headers: headers);
    final responseData = jsonDecode(response.body);
    List<Budget> budgets = [];
    if (response.statusCode == 200) {
      budgets = responseData['data'].map<Budget>((budget) {
        return Budget.fromJson(budget);
      }).toList();
      _notificationWorker(budgets, year, month);
      return budgets;
    } else {
      throw Exception("budgets error");
    }
  }

  Future<List<Category>> getCategories() async {
    http.Response response = await http.get(Uri.parse(categoryUrl));
    final responseData = jsonDecode(response.body);
    List<Category> categories = [];
    if (response.statusCode == 200) {
      categories = responseData['data']
          .map<Category>((category) => Category.fromJson(category))
          .toList();
      return categories;
    } else {
      throw Exception("categories error");
    }
  }

  _notificationWorker(List<Budget> budgets, int year, int month) {
    if (budgets.isEmpty) {
      return;
    }
    var activityCount = 0;
    var now = DateTime.now();
    budgets.forEach((budget) {
      var now = DateTime.now();
      var startDate = budget.budgetDate.startDate;
      if (startDate.day == now.day + 1) {
        activityCount++;
      }
    });
    if (activityCount >= 1 && now.month == month && now.year == year) {
      storageService.saveToDisk(
          "notification", "$activityCount adet aktiviteniz var.");
    } else {
      storageService.removeFromDisk('notification');
    }
  }
}
