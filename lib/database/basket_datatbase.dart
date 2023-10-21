import 'package:hive_flutter/hive_flutter.dart';

class BasketDataBase {
  final basketBox = Hive.box('basketBox');

  // update the database
  void updateDataBase(basketList) {
    basketBox.put("BASKETLIST", basketList);
  }
}
