import 'dart:convert';
import 'package:clocare/backend/model/package_model.dart';
import 'package:clocare/backend/model/status_model.dart';
import 'package:clocare/utiles/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PackageApi {
  String url = AppConstants.BASE_URL;

  Future<PackageModel> packageList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(AppConstants.TOKEN)!;
    final response = await http.get(
      Uri.parse(url + AppConstants.PACKAGE_LIST_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return PackageModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }

  Future<StatusModel> packageBuy(
      packageId,
      addressId,
      pickupAddress,
      email,
      packageValid,
      packagePrices,
      pickupDay,
      pickupSlot,
      delivery,
      amountPay,
      paymentStatus,
      paymentType,
      transactionId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(AppConstants.TOKEN)!;
    final response = await http.post(
      Uri.parse(url + AppConstants.PACKAGE_BUY_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'package_id': packageId,
        'address_id': addressId,
        'pickup_address': pickupAddress,
        'email': email,
        'package_valid': packageValid,
        'package_prices': packagePrices,
        'pickup_day': pickupDay,
        'pickup_slot': pickupSlot,
        'delivery_type': delivery,
        'amount_pay': amountPay,
        'payment_status': paymentStatus,
        'payment_type': paymentType,
        'transaction_id': transactionId,
      }),
    );

    print('ddddddddddddddddd ${response.body}');
    if (response.statusCode == 200) {
      return StatusModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }
}
