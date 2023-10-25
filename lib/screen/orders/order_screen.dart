import 'package:clocare/backend/api/order_api.dart';
import 'package:clocare/backend/model/order_model.dart';
import 'package:clocare/screen/orders/order_cuntaner_box.dart';
import 'package:clocare/screen/widget/app_bar_widget.dart';
import 'package:clocare/screen/widget/size_box.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/screen/widget/whatsapp_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import '../../utiles/themes/ColorConstants.dart';
import '../basket/basket_garment_screen.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  OrderApi orderApi = OrderApi();

  @override
  Widget build(BuildContext context) {
    return CustomFold(
        appBar: 'Orders',
        isShowBack: false,
        leading: const WhatsappBtn(),
        bodys: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: FutureBuilder<OrderModel>(
                  future: orderApi.orderList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var allData = snapshot.data!.data;
                      print('all data ${allData!!}');
                      if (allData!.isNotEmpty) {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: allData!.length,
                            itemBuilder: (BuildContext context, int index) {
                              var data = allData[index];
                              String dateString = data.createdAt.toString();
                              DateTime date = DateTime.parse(dateString);
                              String formattedDate =DateFormat('dd-MMM-yyyy').format(date);
                             
                              return OrderCustomBox(
                                orderId: data.orderDisplayNo.toString(),
                                orderType: data.orderType.toString(),
                                serviceName: data.serviceName.toString(),
                                totalClothes: data.items.toString(),
                                paymentStatus: data.paymentStatus.toString(),
                                amount: data.amount.toString(),
                                date: formattedDate, 
                                paymentType: data.paymentType.toString(),
                              );
                            });
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Lottie.asset('asset/svg/orders.json', height: 300),
                            const Height(40),
                            SmallText(
                              text: 'Looks like no orders yet',
                              size: 14,
                              color: AppColor.appBarColor,
                              fontweights: FontWeight.w500,
                            ),
                            const Height(6),
                            SmallText(
                              text:
                                  "Start now to track your laundry with ease!",
                              color: AppColor.appBarColor,
                              fontweights: FontWeight.w500,
                              size: 14,
                            ),
                            const Height(35),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color:
                                      const Color.fromARGB(106, 239, 241, 254),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          39, 68, 137, 255))),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    minimumSize: Size.zero,
                                    padding: EdgeInsets.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  onPressed: () {
                                  Get.to(const BasketGarmentScreen(), transition: Transition.rightToLeft);
                                  },
                                  child: SmallText(
                                    text: 'Place Order',
                                    fontweights: FontWeight.w500,
                                    color: AppColor.primaryColor1,
                                  ),
                                ),
                              ),
                            ),
                            const Height(60),
                          ],
                        );
                      }
                    } else {
                      return LoadingAnimationWidget.fourRotatingDots(
                        color: AppColor.primaryColor2,
                        size: 20,
                      );
                    }
                  })),
        ));
  }
}
