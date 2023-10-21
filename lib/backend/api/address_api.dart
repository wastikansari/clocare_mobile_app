import 'dart:convert';
import 'package:clocare/backend/model/address_model.dart';
import 'package:clocare/backend/model/status_model.dart';
import 'package:clocare/utiles/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddressApi {
  String url = AppConstants.BASE_URL;

  Future<AddressModel> addressList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(AppConstants.TOKEN)!;
    final response = await http.get(
      Uri.parse(url + AppConstants.ADDRESS_LIST_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return AddressModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }

  Future<StatusModel> addressCreate(
    flatNo,
    street,
    landMark,
    stateId,
    stateName,
    cityId,
    cityName,
    pincodeId,
    pincodeNo,
    addressType,
    addressLabel,
    status,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(AppConstants.TOKEN)!;
    final response = await http.post(
      Uri.parse(url + AppConstants.ADDRESS_CREATE_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'flat_no': flatNo,
        'street': street,
        'landmark': landMark,
        'state_id': stateId,
        'state_name': stateName,
        'city_id': cityId,
        'city_name': cityName,
        'pincode_id': pincodeId,
        'pincode_no': pincodeNo,
        'address_type': addressType,
        'address_label': addressLabel,
        'status': status,
      }),
    );

    print('ddddddddddddddddd ${response.body}');
    if (response.statusCode == 200) {
      return StatusModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }

  Future<StatusModel> addressUpdate(
    addresId,
    flatNo,
    street,
    landMark,
    stateId,
    stateName,
    cityId,
    cityName,
    pincodeId,
    pincodeNo,
    addressType,
    addressLabel,
    status,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(AppConstants.TOKEN)!;
    final response = await http.post(
      Uri.parse('$url${AppConstants.ADDRESS_UPDATE_URL}/$addresId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'flat_no': flatNo,
        'street': street,
        'landmark': landMark,
        'state_id': stateId,
        'state_name': stateName,
        'city_id': cityId,
        'city_name': cityName,
        'pincode_id': pincodeId,
        'pincode_no': pincodeNo,
        'address_type': addressType,
        'address_label': addressLabel,
        'status': status,
      }),
    );

    print('ddddddddddddddddd ${response.body}');
    if (response.statusCode == 200) {
      return StatusModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }

  Future<StatusModel> addressDelete(
    addressId,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(AppConstants.TOKEN)!;
    print('addressDelete ${url}${AppConstants.ADDRESS_DELETE_URL}/$addressId}');
    final response = await http.delete(
      Uri.parse("$url${AppConstants.ADDRESS_DELETE_URL}/$addressId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    print('rrrrrrrrrrrrrrrrrrrr ${response.body}');
    if (response.statusCode == 200) {
      return StatusModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }
}
