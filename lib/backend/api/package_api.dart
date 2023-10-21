import 'dart:convert';

import 'package:clocare/backend/model/package_model.dart';
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
    print('DDDDDDDDDDD ${response.body}');
    if (response.statusCode == 200) {
      return PackageModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }
}
