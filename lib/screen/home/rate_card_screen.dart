import 'package:clocare/screen/home/rate_card_detail_screen.dart';
import 'package:clocare/screen/widget/app_bar_widget.dart';
import 'package:clocare/screen/widget/small_text.dart';
import 'package:clocare/utiles/themes/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RateCardScreen extends StatefulWidget {
  const RateCardScreen({super.key});

  @override
  State<RateCardScreen> createState() => _RateCardScreenState();
}

class _RateCardScreenState extends State<RateCardScreen> {
  List rate = [
    {
      'id': '0',
      'name': 'Regular Ironing',
      'img_url':
          'https://cc.vcantech.biz/uploads/1605185910_service_banner.jpg',
    },
    {
      'id': '1',
      'name': 'Premium-Ironing',
      'img_url':
          'https://cc.vcantech.biz/uploads/1605185952_service_banner.jpg',
    },
    {
      'id': '2',
      'name': 'Wash',
      'img_url':
          'https://cc.vcantech.biz/uploads/1615037586_service_banner.jpg',
    },
    {
      'id': '3',
      'name': 'Wash+Ironing',
      'img_url':
          'https://cc.vcantech.biz/uploads/1615037226_service_banner.jpg',
    },
    {
      'id': '4',
      'name': 'Dry-Cleaning',
      'img_url':
          'https://cc.vcantech.biz/uploads/1605185954_service_banner.jpg',
    },
    {
      'id': '5',
      'name': 'Tailoring',
      'img_url':
          'https://cc.vcantech.biz/uploads/1605185910_service_banner.jpg',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return CustomFold(
      appBar: 'Rate Card',
      isShowBack: true,
      bodys: GridView.builder(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 15.0, mainAxisSpacing: 25.0),
        scrollDirection: Axis.vertical,
        itemCount: rate.length,
        itemBuilder: (context, index) {
          String id = rate[index]['id'];
          String title = rate[index]['name'];
          String url = rate[index]['img_url'];
          return CardBox(
            title: title,
            url: url,
            onTap: () {
              Get.to(
                  RateCardDetailsScreen(
                    title: title,
                    id: id,
                  ),
                  transition: Transition.rightToLeft);
            },
          );
        },
      ),
    );
  }
}

class CardBox extends StatelessWidget {
  final String title;
  final String url;
  final Function onTap;
  const CardBox({
    super.key,
    required this.title,
    required this.url,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: AppColor.boxColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColor.boxShadowColor,
                  blurRadius: 4.0,
                  spreadRadius: 2.0,
                  offset: const Offset(0.0, 0.0),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColor.primaryColor1,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColor.boxShadowColor,
                  blurRadius: 4.0,
                  spreadRadius: 2.0,
                  offset: const Offset(0.0, 0.0),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                  child: SmallText(
                text: title,
                color: Colors.white,
                fontweights: FontWeight.w400,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
