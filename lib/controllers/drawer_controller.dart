import 'package:get/get.dart';

class DrawerControllerX extends GetxController {
  var selectedIndex = 0.obs;

  void changePage(int index) {
    selectedIndex.value = index;
  }
}
