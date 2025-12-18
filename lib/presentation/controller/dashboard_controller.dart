import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController implements GetxService {
  int _pageIndex = 0;
  int get pageIndex => _pageIndex;

  PageController? _pageController;
  PageController? get pageController => _pageController;

  void getPage(int pageIndex) {
    _pageIndex = pageIndex;
    update();
  }

  void initialialPage() {
    _pageController = PageController(initialPage: _pageIndex);
    update();
  }

  void naviageToPageIndex() {
    _pageController!.jumpToPage(_pageIndex);
    update();
  }

  @override
  void onClose() {
    _pageController!.dispose();
    super.onClose();
  }
}
