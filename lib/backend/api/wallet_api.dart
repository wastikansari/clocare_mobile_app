import 'dart:convert';
import 'package:clocare/backend/model/transaction_model.dart';
import 'package:clocare/backend/model/wallet_model.dart';
import 'package:clocare/utiles/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WalletApi {
  String url = AppConstants.BASE_URL;

  Future<TransactionModel> transactionApi() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(AppConstants.TOKEN)!;
    final response = await http.get(
      Uri.parse(url + AppConstants.TRANSACTION_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    print("rrrrrrrrrrrrrrr p1 ${response.body}");
    if (response.statusCode == 200) {
      print("rrrrrrrrrrrrrrr  p2 ${response.body}");
      return TransactionModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }

  Future<WalletModel> walletAmountApi() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(AppConstants.TOKEN)!;
    final response = await http.get(
      Uri.parse(url + AppConstants.WALLET_AMOUNT_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    print("rrrrrrrrrrrrrrr p1 ${response.body}");
    if (response.statusCode == 200) {
      print("rrrrrrrrrrrrrrr  p2 ${response.body}");
      return WalletModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }
}
