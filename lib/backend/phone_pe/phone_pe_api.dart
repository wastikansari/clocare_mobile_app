import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> checkStatusApi() async {
  const apiUrl =
      'https://api.phonepe.com/v1/yourEndpoint'; // Replace with the actual endpoint URL
  const apiKey =
      '16062169-093c-4129-bc35-fb6019ec8963'; // Replace with your API key

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };

  final requestBody = {
    'merchantId': 'merchantId',
    'merchantTransactionId': 'merchantTransactionId',
  };

  try {
    final response = await http.post(Uri.parse(apiUrl),
        headers: headers, body: jsonEncode(requestBody));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
    } else {
      throw Exception('Failed to fetch data');
    }
  } catch (error) {
    print(error);
  }
}
