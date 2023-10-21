import 'dart:convert';
import 'package:clocare/backend/model/profile_model.dart';
import 'package:clocare/utiles/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  String url = AppConstants.BASE_URL;
  var isLoading = true.obs;
  RxList<ProfileModel> profileModel = <ProfileModel>[].obs;

  final Rx<ProfileModel> profile = ProfileModel().obs;

  @override
  void onInit() {
    getProfileData();
    super.onInit();
  }

  Future<ProfileModel> getProfileData() async {
    // print('wastik getProfileData method call');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(AppConstants.TOKEN)!;

    var response = (await http.get(
      Uri.parse(url + AppConstants.PROFILE_DATA_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    ));

    print('wastik getProfileData method call data ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final ProfileModel profileModel = ProfileModel.fromJson(responseData);
      return profile.value = profileModel;
    } else {
      throw Exception('Failed to load user');
    }
  }

  void clearUsers() {
    print('data clean all');
    profileModel.clear();
  }
}
