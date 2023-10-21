import 'dart:convert';
import 'package:clocare/backend/model/garment_model.dart';
import 'package:clocare/utiles/app_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GarmentController extends GetxController {
  String url = AppConstants.BASE_URL1;
  RxBool isLoading = false.obs;
  Rx<GarmentModel> garmentModel = GarmentModel().obs;

  Future<void> getGarmentList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String tsoken = sharedPreferences.getString(AppConstants.TOKEN) ?? '';
    isLoading(true);
    var response = (await http.post(
      Uri.parse(url + AppConstants.GARMENT_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'at': AppConstants.HEADER_TOKEN,
      },
      body: jsonEncode(<String, int>{"state_id": 6, "city_id": 9}),
    ));
    if (response.statusCode == 200) {
      final model = GarmentModel.fromJson(jsonDecode(response.body));
      garmentModel.value = model;
      isLoading(false);
    } else {
      isLoading(false);
      throw Exception('Failed to load data');
    }
  }
}
