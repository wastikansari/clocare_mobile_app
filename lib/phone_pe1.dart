// // import 'dart:convert';
// // import 'dart:io';
// // import 'package:http/http.dart' as http;
// // import 'package:flutter/material.dart';
// // import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
// // // import 'package:phonepe_payment_sdk_example/upi_app.dart';

// // class MerchantApp extends StatefulWidget {
// //   const MerchantApp({super.key});

// //   @override
// //   State<MerchantApp> createState() => MerchantScreen();
// // }

// // class MerchantScreen extends State<MerchantApp> {
// //   String body = "";
// //   String callback = "flutterDemoApp";
// //   String checksum =
// //       "47:93:F6:75:CA:CF:95:96:66:B7:F2:E1:F0:07:55:81:C1:90:85:70";

// //   Map<String, String> headers = {};
// //   Map<String, String> pgHeaders = {"Content-Type": "application/json"};
// //   List<String> apiList = <String>['Container', 'PG'];
// //   List<String> environmentList = <String>['UAT', 'UAT_SIM', 'PRODUCTION'];
// //   String apiEndPoint = "/pg/v1/pay";

// //   bool enableLogs = true;
// //   Object? result;
// //   String dropdownValue = 'PG';
// //   String environmentValue = 'UAT_SIM';
// //   String appId = "16062169-093c-4129-bc35-fb6019ec8963";
// //   String merchantId = "CLOCAREONLINE";
// //   String packageName = "com.phonepe.simulator";

// //   void startTransaction() {
// //     dropdownValue == 'Container'
// //         ? startContainerTransaction()
// //         : startPGTransaction();
// //   }

// //   void initPhonePeSdk() {
// //     PhonePePaymentSdk.init(environmentValue, appId, merchantId, enableLogs)
// //         .then((isInitialized) => {
// //               setState(() {
// //                 result = 'PhonePe SDK Initialized - $isInitialized';
// //               })
// //             })
// //         .catchError((error) {
// //       handleError(error);
// //       return <dynamic>{};
// //     });
// //   }

// //   void isPhonePeInstalled() {
// //     PhonePePaymentSdk.isPhonePeInstalled()
// //         .then((isPhonePeInstalled) => {
// //               setState(() {
// //                 result = 'PhonePe Installed - $isPhonePeInstalled';
// //               })
// //             })
// //         .catchError((error) {
// //       handleError(error);
// //       return <dynamic>{};
// //     });
// //   }

// //   void isGpayInstalled() {
// //     PhonePePaymentSdk.isGPayAppInstalled()
// //         .then((isGpayInstalled) => {
// //               setState(() {
// //                 result = 'GPay Installed - $isGpayInstalled';
// //               })
// //             })
// //         .catchError((error) {
// //       handleError(error);
// //       return <dynamic>{};
// //     });
// //   }

// //   void isPaytmInstalled() {
// //     PhonePePaymentSdk.isPaytmAppInstalled()
// //         .then((isPaytmInstalled) => {
// //               setState(() {
// //                 result = 'Paytm Installed - $isPaytmInstalled';
// //               })
// //             })
// //         .catchError((error) {
// //       handleError(error);
// //       return <dynamic>{};
// //     });
// //   }

// //   void getPackageSignatureForAndroid() {
// //     if (Platform.isAndroid) {
// //       PhonePePaymentSdk.getPackageSignatureForAndroid()
// //           .then((packageSignature) => {
// //                 setState(() {
// //                   result = 'getPackageSignatureForAndroid - $packageSignature';
// //                 })
// //               })
// //           .catchError((error) {
// //         handleError(error);
// //         return <dynamic>{};
// //       });
// //     }
// //   }

// //   void getInstalledUpiAppsForAndroid() {
// //     // if (Platform.isAndroid) {
// //     //   PhonePePaymentSdk.getInstalledUpiAppsForAndroid()
// //     //       .then((apps) => {
// //     //             setState(() {
// //     //               if (apps != null) {
// //     //                 Iterable l = json.decode(apps);
// //     //                 List<UPIApp> upiApps = List<UPIApp>.from(
// //     //                     l.map((model) => UPIApp.fromJson(model)));
// //     //                 String appString = '';
// //     //                 for (var element in upiApps) {
// //     //                   appString +=
// //     //                       "${element.applicationName} ${element.version} ${element.packageName}";
// //     //                 }
// //     //                 result = 'Installed Upi Apps - $appString';
// //     //               } else {
// //     //                 result = 'Installed Upi Apps - 0';
// //     //               }
// //     //             })
// //     //           })
// //     //       .catchError((error) {
// //     //     handleError(error);
// //     //     return <dynamic>{};
// //     //   });
// //     // }
// //   }

// //   void startPGTransaction() async {
// //     try {
// //       PhonePePaymentSdk.startPGTransaction(
// //               body, callback, checksum, pgHeaders, apiEndPoint, packageName)
// //           .then((response) => {
// //                 setState(() {
// //                   if (response != null) {
// //                     String status = response['status'].toString();
// //                     String error = response['error'].toString();
// //                     if (status == 'SUCCESS') {
// //                       result = "Flow Completed - Status: Success!";
// //                     } else {
// //                       result =
// //                           "Flow Completed - Status: $status and Error: $error";
// //                     }
// //                   } else {
// //                     result = "Flow Incomplete";
// //                   }
// //                 })
// //               })
// //           .catchError((error) {
// //         handleError(error);
// //         return <dynamic>{};
// //       });
// //     } catch (error) {
// //       handleError(error);
// //     }
// //   }

// //   void handleError(error) {
// //     setState(() {
// //       if (error is Exception) {
// //         result = error.toString();
// //       } else {
// //         result = {"error": error};
// //       }
// //     });
// //   }

// //   void startContainerTransaction() async {
// //     try {
// //       PhonePePaymentSdk.startContainerTransaction(
// //               body, callback, checksum, headers, apiEndPoint)
// //           .then((response) => {
// //                 setState(() {
// //                   if (response != null) {
// //                     String status = response['status'].toString();
// //                     String error = response['error'].toString();
// //                     if (status == 'SUCCESS') {
// //                       result = "Flow Completed - Status: Success!";
// //                     } else {
// //                       result =
// //                           "Flow Completed - Status: $status and Error: $error";
// //                     }
// //                   } else {
// //                     result = "Flow Incomplete";
// //                   }
// //                 })
// //               })
// //           .catchError((error) {
// //         handleError(error);
// //         return <dynamic>{};
// //       });
// //     } catch (error) {
// //       result = {"error": error};
// //     }
// //   }

// //   Future<void> makePostRequest() async {
// //     final Uri uri =
// //         Uri.parse("https://api-preprod.phonepe.com/apis/pg-sandbox/pg/v1/pay");

// //     // Create headers for the request
// //     Map<String, String> headers = {
// //       "accept": "application/json",
// //       "Content-Type": "application/json",
// //     };

// //     // Make the POST request
// //     http.Response response = await http.post(
// //       uri,
// //       headers: headers,
// //       body: null, // Set your request body here if needed
// //     );

// //     // Check the response status code
// //     print('rrrrrrrrrrrrrrrrrrrrrrrr ${response.body}');
// //     if (response.statusCode == 200) {
// //       // Request was successful, you can access the response data with response.body
// //       print("Response data: ${response.body}");
// //     } else {
// //       // Request failed
// //       print("Request failed with status code: ${response.statusCode}");
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //           appBar: AppBar(
// //             title: const Text('PhonePe'),
// //           ),
// //           body: SingleChildScrollView(
// //             child: Container(
// //               margin: const EdgeInsets.all(7),
// //               child: Column(
// //                 children: <Widget>[
// //                   ElevatedButton(
// //                       onPressed: makePostRequest,
// //                       child: const Text('ffffff SDK')),
// //                   ElevatedButton(
// //                       onPressed: initPhonePeSdk, child: const Text('INIT SDK')),
// //                   const SizedBox(height: 10),
// //                   const SizedBox(height: 10),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                     children: <Widget>[
// //                       const Text('Select the transaction type'),
// //                       DropdownButton<String>(
// //                         value: dropdownValue,
// //                         icon: const Icon(Icons.arrow_downward),
// //                         elevation: 16,
// //                         underline: Container(
// //                           height: 2,
// //                           color: Colors.black,
// //                         ),
// //                         onChanged: (String? value) {
// //                           // This is called when the user selects an item.
// //                           setState(() {
// //                             dropdownValue = value!;
// //                             if (dropdownValue == 'PG') {
// //                               apiEndPoint = "/pg/v1/pay";
// //                             } else {
// //                               apiEndPoint = "/v4/debit";
// //                             }
// //                           });
// //                         },
// //                         items: apiList
// //                             .map<DropdownMenuItem<String>>((String value) {
// //                           return DropdownMenuItem<String>(
// //                             value: value,
// //                             child: Text(value),
// //                           );
// //                         }).toList(),
// //                       )
// //                     ],
// //                   ),
// //                   ElevatedButton(
// //                       onPressed: startTransaction,
// //                       child: const Text('Start Transaction')),
// //                   Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: <Widget>[
// //                         Expanded(
// //                             child: ElevatedButton(
// //                                 onPressed: isPhonePeInstalled,
// //                                 child: const Text('PhonePe App'))),
// //                         const SizedBox(width: 5.0),
// //                         Expanded(
// //                             child: ElevatedButton(
// //                                 onPressed: isGpayInstalled,
// //                                 child: const Text('Gpay App'))),
// //                         const SizedBox(width: 5.0),
// //                         Expanded(
// //                             child: ElevatedButton(
// //                                 onPressed: isPaytmInstalled,
// //                                 child: const Text('Paytm App'))),
// //                       ]),
// //                   Visibility(
// //                       maintainSize: false,
// //                       maintainAnimation: false,
// //                       maintainState: false,
// //                       visible: Platform.isAndroid,
// //                       child: Row(
// //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                           children: <Widget>[
// //                             Expanded(
// //                                 child: ElevatedButton(
// //                                     onPressed: getPackageSignatureForAndroid,
// //                                     child:
// //                                         const Text('Get Package Signature'))),
// //                             const SizedBox(width: 5.0),
// //                             Expanded(
// //                                 child: ElevatedButton(
// //                                     onPressed: getInstalledUpiAppsForAndroid,
// //                                     child: const Text('Get UPI Apps'))),
// //                             const SizedBox(width: 5.0),
// //                           ])),
// //                   Text("Result: \n $result")
// //                 ],
// //               ),
// //             ),
// //           )),
// //     );
// //   }
// // }







// import 'dart:async';
// import 'dart:html';
// import 'dart:io';
// import 'dart:math';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:phone_pe_pg/phone_pe_pg.dart';
// import 'package:phone_pe_pg_example/keys.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initPlatformState() async {
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     // We also handle the message potentially returning null.

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//   }

//   PhonePePg pePg = PhonePePg(
//     isUAT: true,
//     saltKey: Secrets.saltKey,
//     saltIndex: Secrets.saltIndex,
//   );

//   PaymentRequest _paymentRequest({String? merchantCallBackScheme}) {
//     String generateRandomString(int len) {
//       const chars ='AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
//       Random rnd = Random();
//       var s = String.fromCharCodes(Iterable.generate(
//           len, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
//       return s;
//     }

//     PaymentRequest paymentRequest = PaymentRequest(
//       amount: 100,
//       callbackUrl: Secrets.callbackUrl,
//       deviceContext: DeviceContext.getDefaultDeviceContext(
//       merchantCallBackScheme: merchantCallBackScheme),
//       merchantId: Secrets.merchantId,
//       merchantTransactionId: generateRandomString(10).toUpperCase(),
//       merchantUserId: generateRandomString(8).toUpperCase(),
//       mobileNumber: Secrets.userMobileNumber,
//     );
//     return paymentRequest;
//   }

//   PaymentRequest upipaymentRequest(UpiAppInfo e,
//           {String? merchantCallBackScheme}) =>
//       _paymentRequest(merchantCallBackScheme: merchantCallBackScheme).copyWith(
//           paymentInstrument: UpiIntentPaymentInstrument(
//         targetApp: Platform.isAndroid ? e.packageName! : e.iOSAppName!,
//       ));

//   PaymentRequest paypageRequestModel({String? merchantCallBackScheme}) =>
//       _paymentRequest(merchantCallBackScheme: merchantCallBackScheme).copyWith(
//           redirectUrl: Secrets.redirectUrl,
//           redirectMode: 'GET',
//           paymentInstrument: PayPagePaymentInstrument());

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//           appBar: AppBar(
//             title: const Text('Plugin example app'),
//           ),
//           body: FutureBuilder<List<UpiAppInfo>?>(
//             future: PhonePePg.getUpiApps(iOSUpiApps: [
//               UpiAppInfo(
//                 appName: "PhonePe",
//                 packageName: "ppe",
//                 appIcon: Uint8List(0),
//                 iOSAppName: "PHONEPE",
//                 iOSAppScheme: 'ppe',
//               ),
//               UpiAppInfo(
//                 appName: "Google Pay",
//                 packageName: "gpay",
//                 appIcon: Uint8List(0),
//                 iOSAppName: "GPAY",
//                 iOSAppScheme: 'gpay',
//               ),
//               UpiAppInfo(
//                 appName: "Paytm",
//                 packageName: "paytmmp",
//                 appIcon: Uint8List(0),
//                 iOSAppName: "PAYTM",
//                 iOSAppScheme: 'paytmmp',
//               ),
//               UpiAppInfo(
//                   appName: "PhonePe Simulator",
//                   packageName: "ppemerchantsdkv1",
//                   appIcon: Uint8List(0),
//                   iOSAppScheme: 'ppemerchantsdkv1',
//                   iOSAppName: "PHONEPE"),
//               UpiAppInfo(
//                 appName: "PhonePe Simulator",
//                 packageName: "ppemerchantsdkv2",
//                 appIcon: Uint8List(0),
//                 iOSAppScheme: 'ppemerchantsdkv2',
//                 iOSAppName: "PHONEPE",
//               ),
//               UpiAppInfo(
//                 appName: "PhonePe Simulator",
//                 packageName: "ppemerchantsdkv3",
//                 iOSAppScheme: 'ppemerchantsdkv3',
//                 appIcon: Uint8List(0),
//                 iOSAppName: "PHONEPE",
//               ),
//             ]),
//             builder: (context, snapshot) {
//               if (snapshot.hasData && snapshot.data != null) {
//                 return ListView(children: [
//                   ...snapshot.data!
//                       .map(
//                         (e) => ListTile(
//                           onTap: () async {
//                             pePg
//                                 .startUpiTransaction(
//                                     paymentRequest: upipaymentRequest(e))
//                                 .then((response) {
//                               if (response.status == UpiPaymentStatus.success) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                         content:
//                                             Text("Transaction Successful")));
//                               } else if (response.status ==
//                                   UpiPaymentStatus.pending) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                         content: Text("Transaction Pending")));
//                               } else {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                         content: Text("Transaction Failed")));
//                               }
//                             }).catchError((e) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                       content: Text("Transaction Failed")));
//                             });
//                           },
//                           leading: Image.memory(
//                             e.appIcon,
//                             errorBuilder: (context, error, stackTrace) {
//                               return const Icon(Icons.error);
//                             },
//                           ),
//                           title: Text(e.appName),
//                           subtitle: Text(e.packageName ?? e.iOSAppName!),
//                         ),
//                       )
//                       .toList(),
//                   ListTile(
//                     title: const Text("Card/Net Banking"),
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (_) => pePg.startPayPageTransaction(
//                                     onPaymentComplete:
//                                         (paymentResponse, paymentError) {
//                                       Navigator.pop(context);
//                                       if (paymentResponse != null &&
//                                           paymentResponse.code ==
//                                               PaymentStatus.success) {
//                                         ScaffoldMessenger.of(context)
//                                             .showSnackBar(const SnackBar(
//                                                 content: Text(
//                                                     "Transaction Successful")));
//                                       } else {
//                                         ScaffoldMessenger.of(context)
//                                             .showSnackBar(const SnackBar(
//                                                 content: Text(
//                                                     "Transaction Failed")));
//                                       }
//                                     },
//                                     paymentRequest: paypageRequestModel(),
//                                   )));
//                     },
//                   )
//                 ]);
//               }
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             },
//           )),
//     );
//   }
// }
