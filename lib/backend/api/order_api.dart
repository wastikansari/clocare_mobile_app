import 'dart:convert';
import 'package:clocare/backend/model/status_model.dart';
import 'package:clocare/utiles/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as logDev;

class OrderApi {
  String url = AppConstants.BASE_URL;

  Future<StatusModel> serviceOrderCreate(
      orderType,
      serviceId,
      serviceName,
      items,
      paymentType,
      paymentStatus,
      pickupDate,
      pickupTime,
      deliveryDate,
      deliveryTime,
      pickupAddressId,
      ordStatus) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(AppConstants.TOKEN)!;
    final response = await http.post(
      Uri.parse(url + AppConstants.SERVICE_ORDER_PLACE_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'order_type': orderType,
        'service_id': serviceId,
        'service_name': serviceName,
        'items': items,
        'payment_type': paymentType,
        'payment_status': paymentStatus,
        'pickup_date': pickupDate,
        'pickup_time': pickupTime,
        'delivery_date': deliveryDate,
        'delivery_time': deliveryTime,
        'pickup_address_id': pickupAddressId,
        'delivery_address_id': pickupAddressId,
        'ord_status': ordStatus,
      }),
    );

    print('ddddddddddddddddd ${response.body}');
    if (response.statusCode == 200) {
      return StatusModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }

  Future<StatusModel> basketOrderCreate(
      orderType,
      noOfServic,
      serviceName,
      items,
      itemsList,
      paymentType,
      paymentStatus,
      amount,
      pickupDate,
      pickupTime,
      deliveryDate,
      deliveryTime,
      pickupAddressId,
      ordStatus) async {
    print('DDDDDDDDDDDDDDDDD $orderType and $noOfServic, $serviceName, $items, $paymentType, $paymentStatus, $amount, $pickupDate, $pickupTime, $deliveryDate, $deliveryTime, $pickupAddressId');
    print('itemsList $itemsList');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(AppConstants.TOKEN)!;
    final response = await http.post(
      Uri.parse(url + AppConstants.BASKET_ORDER_PLACE_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'order_type': orderType,
        'no_of_servic': noOfServic,
        'service_name': serviceName,
        'items': items,
        'items_list': itemsList,
        'payment_type': paymentType,
        'payment_status': paymentStatus,
        'amount': amount,
        'pickup_date': pickupDate,
        'pickup_time': pickupTime,
        'delivery_date': deliveryDate,
        'delivery_time': deliveryTime,
        'pickup_address_id': pickupAddressId,
        'delivery_address_id': pickupAddressId,
        'ord_status': ordStatus,
      }),
    );

    print('resulst ${response.body}');
    logDev.log('final dataaa ${response.body}');

    print('ddddddddddddddddd ${response.body}');
    if (response.statusCode == 200) {
      return StatusModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }
}
