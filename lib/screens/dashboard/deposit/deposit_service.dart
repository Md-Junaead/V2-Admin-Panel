import 'dart:convert';
import 'package:admin_panel/screens/dashboard/deposit/deposit_model.dart';
import 'package:http/http.dart' as http;

class BalanceService {
  final String apiUrl = "http://84.247.161.200:9090/api/Balance/get";

  Future<List<BalanceModel>> fetchBalances() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => BalanceModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load balances");
    }
  }
}
