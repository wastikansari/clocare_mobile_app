import 'package:clocare/backend/api/wallet_api.dart';
import 'package:clocare/backend/model/transaction_model.dart';
import 'package:clocare/screen/widget/app_bar_widget.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  WalletApi walletApi = WalletApi();
  @override
  Widget build(BuildContext context) {
    return CustomFold(
      appBar: 'Transactions',
      isShowBack: true,
      leading: IconButton(
          padding: const EdgeInsets.all(6),
          constraints: const BoxConstraints(),
          onPressed: () {},
          icon: Icon(
            Icons.more_vert,
            color: AppColor.backgroundColor,
            size: 25,
          )),
      bodys: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: AppColor.primaryColor1,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: const [
                  Tab(
                    text: 'All',
                  ),
                  Tab(
                    text: 'Credit',
                  ),
                  Tab(
                    text: 'Debit',
                  ),
                ],
              ),
            ),
            // tab bar view here
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Tabbar1
                  SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 20,
                        ),
                        child: FutureBuilder<TransactionModel>(
                            future: walletApi.transactionApi(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var allData = snapshot.data!.data!.customer;
                                print('ddddddddddddddd ${allData!.length}');
                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: allData.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      String input =
                                          allData[index].createdAt!.toString();
                                      DateTime dateTime = DateTime.parse(input);
                                      String formattedDate =
                                          DateFormat('dd MMM yyyy')
                                              .format(dateTime);
                                      String formattedTime =
                                          DateFormat('HH:mm aa')
                                              .format(dateTime);
                                      return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Container(
                                            // height: 90,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: AppColor.boxColor,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                border: Border.all(
                                                    color: Colors.white)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SmallText(
                                                        text: formattedDate,
                                                        color: AppColor
                                                            .appBarColor,
                                                        fontweights:
                                                            FontWeight.w400,
                                                        size: 14,
                                                      ),
                                                      Row(
                                                        children: [
                                                          SmallText(
                                                            text:
                                                                '₹${allData[index].amount!.toString()}.00',
                                                            // size: 15,
                                                            color: Colors.green,
                                                          ),
                                                          // const Icon(Icons.arrow_outward, size: 15, color: Colors.redAccent,)
                                                          const Icon(
                                                            Icons
                                                                .arrow_downward,
                                                            size: 17,
                                                            color: Colors.green,
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const Height(6),
                                                  Row(
                                                    children: [
                                                      SmallText(
                                                          text: 'Status : '),
                                                      SmallText(
                                                          text: allData[index]
                                                              .transactionType
                                                              .toString()),
                                                    ],
                                                  ),
                                                  const Height(3),
                                                  Row(
                                                    children: [
                                                      SmallText(
                                                          text:
                                                              'Transactions id : '),
                                                      SmallText(
                                                          text: allData[index]
                                                              .transactionId
                                                              .toString()),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      SmallText(text: ''),
                                                      SmallText(
                                                        text: formattedTime,
                                                        size: 10,
                                                        color: Colors.grey,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ));
                                    });
                              } else {
                                return Center(
                                  child:
                                      LoadingAnimationWidget.fourRotatingDots(
                                    color: AppColor.primaryColor2,
                                    size: 20,
                                  ),
                                );
                              }
                            })),
                  ),
                  // Tabbar2

                  Container(
                    // color: Colors.amber,
                    child: const Center(
                      child: Text(
                        'Amount credit',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  // Tabbar3

                  Container(
                    // color: Colors.amber,
                    child: const Center(
                      child: Text(
                        'Amount debit',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class TraBox extends StatelessWidget {
//   TraBox({
//     super.key,
//   });

//   WalletApi walletApi = WalletApi();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         // color: Colors.amber,
//         child: SingleChildScrollView(
//       child: Padding(
//           padding: const EdgeInsets.only(
//             left: 20,
//             right: 20,
//             bottom: 20,
//           ),
//           child: FutureBuilder<TransactionModel>(
//               future: walletApi.transactionApi(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   var allData = snapshot.data!.data;
//                   return ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: allData!.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Padding(
//                           padding: const EdgeInsets.only(bottom: 15),
//                           child: AddressBoxWidget(
//                             addressType: 'addressType',
//                             address: 'formatAddress',
//                             status: false,
//                             deleteOnTap: () {
//                               // Get.back();
//                             },
//                             editOnTap: () {
//                               // Get.back();
//                               print('edit');
//                             },
//                           ),
//                         );
//                       });
//                 } else {
//                   return LoadingAnimationWidget.fourRotatingDots(
//                     color: AppColor.primaryColor2,
//                     size: 20,
//                   );
//                 }
//               })),
//     ));
//   }
// }

// class TransactionsScreen extends StatefulWidget {
//   const TransactionsScreen({super.key});

//   @override
//   State<TransactionsScreen> createState() => _TransactionsScreenState();
// }

// class _TransactionsScreenState extends State<TransactionsScreen> {
//   WalletApi walletApi = WalletApi();

//   @override
//   Widget build(BuildContext context) {

//     return CustomFold(
//         appBar: 'Transactions',
//         isShowBack: true,
//         bodys: SingleChildScrollView(
//           child: Padding(
//               padding: const EdgeInsets.only(
//                 left: 20,
//                 right: 20,
//                 bottom: 20,
//               ),
//               child: FutureBuilder<TransactionModel>(
//                   future: walletApi.transactionApi(),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       var allData = snapshot.data!.data!.customer;
//                       print('ddddddddddddddd ${allData!.length}');
//                       return ListView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: allData.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             String input = allData[index].createdAt!.toString();
//                             DateTime dateTime = DateTime.parse(input);
//                             String formattedDate =
//                                 DateFormat('dd MMM yyyy').format(dateTime);
//                             String formattedTime =
//                                 DateFormat('HH:mm aa').format(dateTime);
//                             return Padding(
//                                 padding: const EdgeInsets.only(bottom: 8),
//                                 child: Container(
//                                   // height: 90,
//                                   width: double.infinity,
//                                   decoration: BoxDecoration(
//                                       color: AppColor.boxColor,
//                                       borderRadius: const BorderRadius.all(
//                                         Radius.circular(10),
//                                       ),
//                                       border: Border.all(color: Colors.white)),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(12),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             SmallText(
//                                               text: formattedDate,
//                                               color: AppColor.appBarColor,
//                                               fontweights: FontWeight.w400,
//                                               size: 14,
//                                             ),
//                                             Row(
//                                               children: [
//                                                 SmallText(
//                                                   text:
//                                                       '₹${allData[index].amount!.toString()}.00',
//                                                   // size: 15,
//                                                   color: Colors.green,
//                                                 ),
//                                                 // const Icon(Icons.arrow_outward, size: 15, color: Colors.redAccent,)
//                                                 const Icon(
//                                                   Icons.arrow_outward,
//                                                   size: 17,
//                                                   color: Colors.redAccent,
//                                                 )
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                         const Height(6),
//                                         Row(
//                                           children: [
//                                             SmallText(text: 'Status : '),
//                                             SmallText(
//                                                 text: allData[index]
//                                                     .transactionType
//                                                     .toString()),
//                                           ],
//                                         ),
//                                         const Height(3),
//                                         Row(
//                                           children: [
//                                             SmallText(
//                                                 text: 'Transactions id : '),
//                                             SmallText(
//                                                 text: allData[index]
//                                                     .transactionId
//                                                     .toString()),
//                                           ],
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.end,
//                                           children: [
//                                             SmallText(text: ''),
//                                             SmallText(
//                                               text: formattedTime,
//                                               size: 10,
//                                               color: Colors.grey,
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ));
//                           });
//                     } else {
//                       return LoadingAnimationWidget.fourRotatingDots(
//                         color: AppColor.primaryColor2,
//                         size: 20,
//                       );
//                     }
//                   })),
//         ));
//   }
// }
