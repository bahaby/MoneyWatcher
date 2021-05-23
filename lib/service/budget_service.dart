import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:money_watcher/model/budget.dart';
import 'package:money_watcher/service_locator.dart';
import 'local_storage_service.dart';

class BudgetService {
  final String budgetUrl = "https://$NGROK_ID.ngrok.io/api/budget/";
  var storageService = getIt<LocalStorageService>();

  Future<Budget> addBudget(Budget budget) async {
    final token = storageService.getFromDisk('token');
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
}
