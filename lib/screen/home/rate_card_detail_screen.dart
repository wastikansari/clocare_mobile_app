import 'package:clocare/backend/controller/garment_controller.dart';
import 'package:clocare/screen/widget/app_bar_widget.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/utiles/app_constants.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

class RateCardDetailsScreen extends StatefulWidget {
  final String title;
  final String id;
  const RateCardDetailsScreen(
      {super.key, required this.title, required this.id});

  @override
  State<RateCardDetailsScreen> createState() => _RateCardScreenState();
}

class _RateCardScreenState extends State<RateCardDetailsScreen> {
  GarmentController garmentController = Get.put(GarmentController());
  List<List<int>> quantities = [];
  double miniOrderValue = 0.0;
  double totalPrice = 0.0;
  int totalQuantities = 0;

  var addGarment = [];

  void updateTotalPrice(price) {
    double p = double.parse(price);
    setState(() {
      totalPrice += p;
      totalQuantities = totalQuantities + 1;
    });
    print('updateTotalPrice $totalPrice and $price and $totalQuantities');
  }

  void decrementTotalPrice(price) {
    double p = double.parse(price);
    setState(() {
      totalPrice -= p;
      totalQuantities = totalQuantities - 1;
    });
    print('updateTotalPrice $totalPrice and $price and $totalQuantities');
  }

  @override
  Widget build(BuildContext context) {
    return CustomFold(
        appBar: widget.title,
        isShowBack: true,
        bodys: Scaffold(
          backgroundColor: AppColor.backgroundColor,

          body: Obx(() {
            if (garmentController.garmentModel.value.success == null) {
              return const CircularProgressIndicator();
            } else {
              var data = garmentController.garmentModel.value.data;

              int serviceId = int.parse(widget.id);

              var allGarmentList = data![serviceId];
              for (int i = 0; i < allGarmentList.itemsList!.length; i++) {
                quantities.add(List<int>.filled(
                    allGarmentList.itemsList![i].items!.length, 0));
              }
              return DefaultTabController(
                length: allGarmentList.itemsList!.length,
                child: Column(
                  children: [
                    TabBar(
                      unselectedLabelColor: Colors.black45,
                      labelColor: AppColor.primaryColor1,
                      labelStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      isScrollable: true,
                      tabs: [
                        for (int i = 0;
                            i < allGarmentList.itemsList!.length;
                            i++)
                          Tab(text: allGarmentList.itemsList![i].name),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          for (int i = 0;
                              i < allGarmentList.itemsList!.length;
                              i++)
                            ListView.builder(
                              itemCount:
                                  allGarmentList.itemsList![i].items!.length,
                              itemBuilder: (context, index) {
                                String garmentName = allGarmentList
                                    .itemsList![i].items![index].name
                                    .toString();
                                String price = allGarmentList
                                    .itemsList![i].items![index].price
                                    .toString();
                                String image = allGarmentList
                                    .itemsList![i].items![index].icon
                                    .toString();
                                String url =
                                    '${AppConstants.BASE_URL1}/uploads/$image';
                                int indexOfItemsList = allGarmentList.itemsList!
                                    .indexOf(allGarmentList.itemsList![i]);
                                int quantity =
                                    quantities[indexOfItemsList][index];

                                return Column(
                                  children: [
                                    Card(
                                      elevation: 0,
                                      color: quantity > 0
                                          ? const Color.fromARGB(
                                              43, 23, 79, 162)
                                          : AppColor.backgroundColor,
                                      child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 15.0, horizontal: 10),
                                        leading: SizedBox(
                                          width: 70,
                                          height: 70,
                                          child: Image.network(url),
                                        ),
                                        title: Text(
                                          garmentName,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        subtitle: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Height(5),
                                            SmallText(
                                              text: 'Per price:',
                                              size: 12,
                                            ),
                                            const Height(5),
                                            SmallText(
                                              text: '₹$price',
                                              size: 16,
                                              color: Colors.green[700],
                                              fontweights: FontWeight.w500,
                                            )
                                          ],
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: CircleAvatar(
                                                radius: 14,
                                                backgroundColor:
                                                    Colors.grey[400],
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              onPressed: () {
                                                if (quantity > 0) {
                                                  setState(() {
                                                    quantity = quantities[indexOfItemsList][index]--;
                                                    decrementTotalPrice(price);
                                                  });
                                                }
                                              },
                                            ),
                                            SmallText(
                                              text: '$quantity',
                                              fontweights: FontWeight.w400,
                                            ),
                                            IconButton(
                                              icon: CircleAvatar(
                                                radius: 14,
                                                backgroundColor:
                                                    Colors.grey[400],
                                                child: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  quantity = quantity + 1;
                                                  quantity = quantities[
                                                          indexOfItemsList]
                                                      [index]++;
                                                  updateTotalPrice(price);
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Divider()
                                  ],
                                );
                              },
                            )
                        ],
                      ),
                    ),
                    if (totalQuantities > 0)
                      Container(
                        color: AppColor.backgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              badges.Badge(
                                  badgeContent: Text(
                                    '$totalQuantities',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  badgeStyle: const badges.BadgeStyle(
                                    padding: EdgeInsets.all(7),
                                    badgeColor: Colors.redAccent,
                                  ),
                                  child: const Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 28,
                                  )),
                              SmallText(
                                text: '₹$totalPrice',
                                size: 18,
                                color: Colors.green[700],
                                fontweights: FontWeight.w500,
                              ),
                              IconButton(
                                  onPressed: () {
                                    resetQuantities();
                                  },
                                  icon: const Icon(Icons.refresh))
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }
          }),
          // bottomNavigationBar: Container(
          //   width: double.infinity,
          //   height: 80,
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     boxShadow: const [
          //       BoxShadow(
          //         color: Color.fromARGB(255, 244, 244, 244),
          //         blurRadius: 1.0,
          //         spreadRadius: 1.0,
          //         offset: Offset(
          //           1.0,
          //           1.0,
          //         ),
          //       ),
          //     ],
          //     border:
          //         Border.all(color: const Color.fromARGB(255, 221, 221, 221)),
          //     borderRadius: const BorderRadius.only(
          //         topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 30, right: 30),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             badges.Badge(
          //                 badgeContent: Text(
          //                   '$totalQuantities',
          //                   style: const TextStyle(color: Colors.white),
          //                 ),
          //                 badgeStyle: const badges.BadgeStyle(
          //                   padding: EdgeInsets.all(7),
          //                   badgeColor: Colors.redAccent,
          //                 ),
          //                 child: const Icon(
          //                   Icons.shopping_cart_outlined,
          //                   size: 28,
          //                 )),
          //             const SizedBox(
          //               width: 25,
          //             ),
          //             SmallText(
          //               text: '\₹$totalPrice',
          //               size: 18,
          //               color: Colors.green[700],
          //               fontweights: FontWeight.w500,
          //             ),
          //           ],
          //         ),
          //         ElevatedButton(
          //           style: ElevatedButton.styleFrom(
          //               backgroundColor: AppColor.primaryColor1,
          //               textStyle: const TextStyle(
          //                   fontSize: 16, fontWeight: FontWeight.w500)),
          //           onPressed: () {
          //             orderContinue();
          //           },
          //           child: const Padding(
          //             padding: EdgeInsets.all(12),
          //             child: Text('Continue'),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ));
  }

  void resetQuantities() {
    setState(() {
      quantities = [];
      addGarment = [];
      totalPrice = 0;
      totalQuantities = 0;
    });
  }

  conformationDialogBox(miniOrderValue) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Alert'),
        content: Text('Minimum order amount should be : ₹$miniOrderValue'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
