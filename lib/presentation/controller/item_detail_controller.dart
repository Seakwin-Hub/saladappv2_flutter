import 'package:get/get.dart';

class ItemDetailController extends GetxController implements GetxService {
  int _itemIndex = 0;
  int get itemIndex => _itemIndex;

  void handleItemIndex(int index) {
    _itemIndex = index;
    update();
  }
}
