import 'dart:convert';
import 'package:clocare/backend/model/profile_model.dart';
import 'package:clocare/backend/model/status_model.dart';
import 'package:clocare/utiles/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileApi {
  String url = AppConstants.BASE_URL;

  Future<ProfileModel> profileData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(AppConstants.TOKEN)!;
    final response = await http.get(
      Uri.parse(url + AppConstants.PROFILE_DATA_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    print("rrrrrrrrrrrrrrr p1 ${response.body}");
    if (response.statusCode == 200) {
      print("rrrrrrrrrrrrrrr  p2 ${response.body}");
      return ProfileModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }

  Future<StatusModel> profileUpdate(
    name,
    email,
    gender,
    dob,
  ) async {
    print('profileUpdate');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(AppConstants.TOKEN)!;
    final response = await http.post(
      Uri.parse(url + AppConstants.PROFILE_UPDATE_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'email_id': email,
        'gender': gender,
        'dob': dob,
      }),
    );

    print("rrrrrrrrrrrrrrr p1 ${response.body}");
    if (response.statusCode == 200) {
      print("rrrrrrrrrrrrrrr  p2 ${response.body}");
      return StatusModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }

  Future<StatusModel> emailUpdate( email,) async {
    print('profileUpdate');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(AppConstants.TOKEN)!;
    final response = await http.post(
      Uri.parse(url + AppConstants.EMAIL_UPDATE_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'email_id': email,
      }),
    );

    print("rrrrrrrrrrrrrrr p1 ${response.body}");
    if (response.statusCode == 200) {
      print("rrrrrrrrrrrrrrr  p2 ${response.body}");
      return StatusModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }
}
