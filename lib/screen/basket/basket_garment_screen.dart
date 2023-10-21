import 'dart:convert';

import 'package:clocare/backend/controller/garment_controller.dart';
import 'package:clocare/backend/model/ui_model/garment_collect_model.dart';
import 'package:clocare/database/basket_datatbase.dart';
import 'package:clocare/screen/bottom_navigation/bottom_navigation.dart';
import 'package:clocare/screen/widget/basket_bottom_sheet.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/utiles/app_constants.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:developer' as logDev;

class BasketGarmentScreen extends StatefulWidget {
  const BasketGarmentScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BasketGarmentScreenState createState() => _BasketGarmentScreenState();
}

class _BasketGarmentScreenState extends State<BasketGarmentScreen> {
  GarmentController garmentController = Get.put(GarmentController());

  // reference the hive box
  final basketBox = Hive.box('basketBox');
  BasketDataBase db = BasketDataBase();

  int selectBox = 0;
  List<List<List<int>>> quantitiesNew = [];
  var q1 = [];
  var q2 = [];
  double totalPrice = 0.0;
  int totalQuantities = 0;
  var addGarment = [];
  var garmmentAddList = [];
  int qtn1 = 0;
  List qtn = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.appBarColor,
        body: Obx(() {
          if (garmentController.garmentModel.value.success == null) {
            return const CircularProgressIndicator();
          } else {
            var serviceList = garmentController.garmentModel.value.data;
            qtn = List<int>.filled(serviceList!.length, 0);
            for (int i = 0; i < serviceList.length; i++) {
              List<List<int>> row = [];
              List datas = [];
              var itemsList = serviceList[i].itemsList!;
              for (int j = 0; j < itemsList.length; j++) {
                List<int> innerList =
                    List<int>.filled(itemsList[j].items!.length, 0);
                List itemsListGarment = [];
                row.add(innerList);
                var items = itemsList[j].items;
                for (int k = 0; k < items!.length; k++) {
                  Map<String, dynamic> item = {
                    'service_id': serviceList[i].id,
                    'service_name': serviceList[i].text,
                    'service_icon': serviceList[i].image,
                    'gtype_id': itemsList[j].gtypeId,
                    'gtype_name': itemsList[j].name,
                    'gtype_icon': itemsList[j].icon,
                    'item_price': items[k].price.toString(),
                    'item_name': items[k].name.toString(),
                    'item_icon': items[k].icon.toString(),
                    "item_qty": 0,
                  };
                  itemsListGarment.add(item);
                  Item myItem = Item.fromJson(item);
                  garmmentAddList.add(myItem);
                }
                datas.add(itemsListGarment);
              }
              addGarment.add(datas);
              quantitiesNew.add(row);
              // print('loooooooooop 1 $addGarment');
              // print('loooooooooop 2 $quantitiesNew');
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  padding: const EdgeInsets.only(
                      left: 10, right: 0, top: 40, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              padding: const EdgeInsets.all(6),
                              constraints: const BoxConstraints(),
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: AppColor.backgroundColor,
                                size: 25,
                              )),
                          const Widths(10),
                          SmallText(
                            text: 'My Basket',
                            size: 20,
                            fontweights: FontWeight.w500,
                            color: AppColor.backgroundColor,
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.refresh,
                          color: AppColor.backgroundColor,
                        ),
                        onPressed: () {
                          resetQuantities();
                        },
                      ),
                    ],
                  ),
                ),
                const Height(10),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: serviceList.length,
                    itemBuilder: (context, index) {
                      // print('dddddddddddddddddddddddddddddd ${qtn} $index');
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                          right: 5,
                          top: 8,
                        ),
                        child: BoxType(
                          image: serviceList[index].image.toString(),
                          backgroundColor: selectBox == index
                              ? AppColor.primaryColor2
                              : AppColor.backgroundColor,
                          title: serviceList[index].text.toString(),
                          onTap: () {
                            setState(() {
                              selectBox = index;
                            });
                          },
                          textColor:
                              selectBox == index ? Colors.white : Colors.black,
                          qtns: qtn[index],
                        ),
                      );
                    },
                  ),
                ),
                const Height(10),
                Expanded(
                    child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    //AppColor.backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  child: DefaultTabController(
                    length: serviceList[0].itemsList!.length,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TabBar(
                            padding: EdgeInsets.zero,
                            indicatorPadding: EdgeInsets.zero,
                            indicatorWeight: 1,
                            unselectedLabelColor: Colors.black45,
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: AppColor.primaryColor1,
                            labelStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            isScrollable: true,
                            indicator: BoxDecoration(
                              border: Border.all(
                                  color: AppColor.primaryColor1, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            tabs: [
                              for (int i = 0;i < serviceList[0].itemsList!.length;i++)
                                Tab(text: serviceList[0].itemsList![i].name, ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              for (int i = 0; i < serviceList[selectBox].itemsList!.length;i++)
                                ListView.builder(
                                  itemCount: serviceList[selectBox].itemsList![i].items!.length,
                                  itemBuilder: (context, index) {
                                    var datas = serviceList[selectBox].itemsList![i].items![index];
                                    String garmentName = datas.name.toString();
                                    String price = datas.price.toString();
                                    String image = datas.icon.toString();
                                    String url ='${AppConstants.BASE_URL1}/uploads/$image';
                                    int b = serviceList[selectBox].itemsList!.indexOf(serviceList[selectBox].itemsList![i]);
                                    int serviceIndex = serviceList.indexOf(serviceList[selectBox]);                                 
                                    int quantity =quantitiesNew[serviceIndex][b][index];                               
                                    return Column(
                                      children: [
                                        Card(
                                          elevation: 0,
                                          color: quantity > 0
                                              ? const Color.fromARGB(
                                                  43, 98, 158, 247)
                                              : Colors.white,
                                          //AppColor.backgroundColor,
                                          child: ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 10),
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
                                                SmallText(text: 'Per price:'),
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
                                                  icon: const CircleAvatar(
                                                    radius: 14,
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            214, 201, 201, 201),
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    if (quantity > 0) {
                                                      setState(() {
                                                        addGarment[serviceIndex]
                                                                [b][index]
                                                            ['item_qty']--;
                                                        quantity = quantitiesNew[
                                                                serviceIndex][b]
                                                            [index]--;
                                                        // print('increment $quantity and ${quantitiesNew[serviceIndex][b][index]} and a=$serviceIndex and b=$b and c=$index');
                                                        qtn[serviceIndex]--;
                                                        decrementTotalPrice(
                                                            price);
                                                      });
                                                    }
                                                  },
                                                ),
                                                // const Widths(5),
                                                SmallText(
                                                  text: '$quantity',
                                                  fontweights: FontWeight.w400,
                                                ),
                                                // const Widths(5),
                                                IconButton(
                                                  icon: const CircleAvatar(
                                                    radius: 14,
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            214, 201, 201, 201),
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  // icon: const Icon(Icons.add),
                                                  onPressed: () {
                                                    setState(() {
                                                      addGarment[serviceIndex]
                                                              [b][index]
                                                          ['item_qty']++;
                                                      quantity = quantitiesNew[
                                                              serviceIndex][b]
                                                          [index]++;
                                                      // print(
                                                      // 'dddddddddddddddddddddd $quantity');
                                                      // logDev.log(
                                                      // 'deeeeeeee $addGarment');
                                                      updateTotalPrice(
                                                          price,
                                                          serviceIndex,
                                                          b,
                                                          index);
                                                      qtn[serviceIndex]++;
                                                      // print('increment $quantity and ${quantitiesNew[serviceIndex][b][index]} and a=$serviceIndex and b=$b and c=$index');
                                                      //  var d = List<int>.filled(data[i].itemsList![j].items!.length, 0);
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
                          BasketBottomSheet(
                            totalItems: totalQuantities.toString(),
                            totalPrice: totalPrice.toString(),
                            btnTap: () {
                              orderSave();
                            },
                          )
                      ],
                    ),
                  ),
                ))
              ],
            );
          }
        }));
  }

  orderSave() {
    if (totalPrice < 50) {
      conformationDialogBox();
    } else {
      List selectGarment = [];
      Map data = {
        'items': totalQuantities.toString(),
        'price': totalPrice,
      };

      for (int i = 0; i < addGarment.length; i++) {
        for (int j = 0; j < addGarment[i].length; j++) {
          for (int k = 0; k < addGarment[i][j].length; k++) {
            if (addGarment[i][j][k]["item_qty"] > 0) {
              Map<String, dynamic> item = {
                'service_id': addGarment[i][j][k]["service_id"],
                'service_name': addGarment[i][j][k]["service_name"],
                'service_icon': addGarment[i][j][k]["service_icon"],
                'gtype_id': addGarment[i][j][k]["gtype_id"],
                'gtype_name': addGarment[i][j][k]["gtype_name"],
                'gtype_icon': addGarment[i][j][k]["gtype_icon"],
                'item_price': addGarment[i][j][k]["item_price"],
                'item_name': addGarment[i][j][k]["item_name"],
                'item_icon': addGarment[i][j][k]["item_icon"],
                "item_qty": addGarment[i][j][k]["item_qty"],
              };
              print('index value $i and $j and $k');
              selectGarment.add(item);
            }
          }
        }
      }
      logDev.log('final dataaa $selectGarment');

      final formattedData = <Map<String, dynamic>>[];
      final groupedData = <dynamic, Map<String, dynamic>>{};

      for (final item in selectGarment) {
        final serviceId = item['service_id'];
        int gtypeId = item["gtype_id"];

        if (!groupedData.containsKey(serviceId)) {
          groupedData[serviceId] = {
            'service_id': serviceId,
            'service_name': item['service_name'],
            'service_icon': item['service_icon'],
            'gtype': [],
          };
        }

        var gtype = groupedData[serviceId]!["gtype"].firstWhere(
          (element) => element["gtype_id"] == gtypeId,
          orElse: () {
            var newGType = {
              "gtype_id": gtypeId,
              "gtype_name": item["gtype_name"],
              "gtype_icon": item["gtype_icon"],
              "items": [],
            };
            groupedData[serviceId]!["gtype"].add(newGType);
            return newGType;
          },
        );

        gtype["items"].add({
          "item_price": item["item_price"],
          "item_name": item["item_name"],
          "item_icon": item["item_icon"],
          "item_qty": item["item_qty"],
        });
      }

      // groupedData.forEach((serviceId, serviceData) {
      //   serviceData["gtype"].forEach((gtype) {
      //     double totalPrice = gtype["items"]
      //         .map((item) => item["item_price"] * item["item_qty"])
      //         .fold(0.0, (a, b) => a + b);
      //     gtype["total_price"] = totalPrice;
      //   });

      //   formattedData.add(serviceData);
      // });

      print(formattedData);

      // final gtype = {
      //   'gtype_id': item['gtype_id'],
      //   'gtype_name': item['gtype_name'],
      //   'gtype_icon': item['gtype_icon'],
      //   'items': [
      //     {
      //       'item_price': item['item_price'],
      //       'item_name': item['item_name'],
      //       'item_icon': item['item_icon'],
      //       'item_qty': item['item_qty'],
      //     }
      //   ],
      // };

      // groupedData[serviceId]!['gtype'].add(gtype);
      // }

      // Convert the grouped data map to a list
      formattedData.addAll(groupedData.values);

      // // Print the formatted data as JSON
      // logDev.log("vvvvvvvvvvvvvvvvvvvvvvvvv ${json.encode(formattedData)}");
      logDev.log("vvvvvvvvvvvvvvvvvvvvvvvvv ${formattedData}");

      setState(() {
        List basketList = [formattedData, data];
        db.updateDataBase(basketList);
      });
      Get.to(const BottomNavigation(
        indexset: 2,
      ));
    }
  }

  conformationDialogBox() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Alert'),
        content: const Text('Minimum order amount should be : ₹50'),
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

  void updateTotalPrice(price, int serviceIndex, int b, int index) {
    double p = double.parse(price);
    setState(() {
      totalPrice += p;
      totalQuantities = totalQuantities + 1;
    });

    if (serviceIndex >= 0 && serviceIndex < qtn.length) {
      setState(() {
        qtn[serviceIndex] = totalQuantities;
      });

      // print("Updated value at index $indexToUpdate: ${numbers[indexToUpdate]}");
    } else {
      print("Index out of bounds");
    }
  }

  void resetQuantities() {
    setState(() {
      // quantities = [];
      quantitiesNew = [];
      totalPrice = 0;
      totalQuantities = 0;
      // for (int i = 0; i < garments.length; i++) {
      //   quantities.add(List<int>.filled(garments[i].length, 0));
      // }
    });
  }

  void decrementTotalPrice(price) {
    double p = double.parse(price);
    setState(() {
      totalPrice -= p;
      totalQuantities = totalQuantities - 1;
    });
    print('updateTotalPrice $totalPrice and $price and $totalQuantities');
  }
}

class BoxType extends StatelessWidget {
  Color backgroundColor;
  Color textColor;
  final String title;
  final String image;
  final int qtns;
  Function onTap;
  BoxType(
      {super.key,
      required this.textColor,
      required this.backgroundColor,
      required this.title,
      required this.image,
      required this.onTap,
      required this.qtns});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      // child: badges.Badge(
      // badgeContent: Text(
      //   qtns.toString(),
      //   style: TextStyle(color: AppColor.primaryColor1),
      // ),
      // badgeStyle: badges.BadgeStyle(
      //   padding: const EdgeInsets.all(3),
      //   badgeColor: AppColor.backgroundColor,
      // ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Container(
          height: 60,
          width: 88,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(6),
            // gradient: const LinearGradient(
            //   stops: [0.2, 3],
            //   begin: Alignment.centerRight,
            //   end: Alignment.centerLeft,
            //   colors: [
            //     Color.fromARGB(129, 180, 225, 250),
            //     Color.fromARGB(131, 186, 252, 243),
            //   ],
            // ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SvgPicture.network(
                  'https://cc.vcantech.biz/uploads/$image',
                  height: 18,
                  color: AppColor.primaryColor1,
                ),
                const Height(6),
                SmallText(
                  text: title,
                  color: textColor,
                  fontweights: FontWeight.w500,
                  size: 9,
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // );
  }
}
