import 'package:get/get.dart';

class DashboardController extends GetxController implements GetxService {
  int _pageIndex = 0;
  int get pageIndex => _pageIndex;

  void getPage(int pageIndex) {
    _pageIndex = pageIndex;
    update();
  }
}
