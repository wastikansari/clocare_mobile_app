import 'dart:convert';
import 'package:clocare/backend/model/login_model.dart';
import 'package:clocare/backend/model/number_check_model.dart';
import 'package:clocare/backend/model/otp_model.dart';
import 'package:clocare/backend/model/registration_model.dart';
import 'package:clocare/utiles/app_constants.dart';
import 'package:http/http.dart' as http;

class AuthendicationApi {
  String url = AppConstants.BASE_URL;

  Future<RegistrationModel> registerUser(name, mobile) async {
    print('registerUser');
    final response = await http.post(
      Uri.parse(url + AppConstants.REGISTRATION_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'mobile': mobile,
      }),
    );

    print("rrrrrrrrrrrrrrr p1 ${response.body}");
    if (response.statusCode == 200) {
      print("rrrrrrrrrrrrrrr  p2 ${response.body}");
      return RegistrationModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }

  Future<LoginModel> login(int number) async {
    final response = await http.post(
      Uri.parse(url + AppConstants.LOGIN_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'mobile': number,
      }),
    );
    print('re wastikkkkkkkkkkkkk ${response.body}');

    if (response.statusCode == 200) {
      return LoginModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }

  Future<NumberCheckModel> numberCheck(
    int number,
  ) async {
    print('re $number');
    final response = await http.post(
      Uri.parse(url + AppConstants.NUMBER_CHECK_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'mobile': number,
      }),
    );
    print('re ${response.body}');
    if (response.statusCode == 200) {
      print('st 1');
      return NumberCheckModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }

  Future<OtpModel> otpVerification(int number) async {
    final response = await http.post(
      Uri.parse(url + AppConstants.OTP_VERIFICATION_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'phone': number,
      }),
    );
    print('dddddddddddddd ${response.body}');
    if (response.statusCode == 200) {
      return OtpModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }
}
