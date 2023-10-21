import 'dart:convert';

import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

class PhonePePaymentGateway {
  void phonePeGateway() async {
    String environmentValue = 'UAT';
    String appId = '';
    String merchantId = 'MhHuWvZuxVrbSt';
    bool enableLogging = true;
    try {
      await PhonePePaymentSdk.init(
              environmentValue, appId, merchantId, enableLogging)
          .then((val) => {
                if (val == true)
                  {
                    print('PhonePe SDK Initialized - $val'),
                    initiateTransactioncall(),
                  }
                else
                  {
                    print('PhonePe SDK Initialized - $val'),
                  }
              });
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  void initiateTransactioncall() async {
    var data = {
      "merchantId": "MhHuWvZuxVrbSt",
      "merchantTransactionId": "MT7850590068188104",
      "merchantUserId": "MUID123",
      "amount": 10,
      "redirectUrl": "https://webhook.site/redirect-url",
      "redirectMode": "REDIRECT",
      "callbackUrl": "https://webhook.site/callback-url",
      "mobileNumber": "8327724967",
      "paymentInstrument": {"type": "PAY_PAGE"}
    };

    String base64Data = base64Encode(utf8.encode(data.toString()));
    print('Base64 Encoded Data: $base64Data');

    print('initiat call ');
    String body = base64Data;
    String callBackURL = '';
    String checksum ='sha256(base64Body + apiEndPoint + salt) + ### + saltIndex';
    var pgHeaders;
    String apiEndPoint = '/pg/v1/pay';
    String packageName = 'com.clocare';

    try {
      var response = await PhonePePaymentSdk.startPGTransaction(body, callBackURL, checksum, pgHeaders, apiEndPoint, packageName);

      var result = response;
      print('result $result');
    } catch (error) {
      Exception(error);
    }
  }

  void handleError(error) {
    // Handle the error here
  }
}
