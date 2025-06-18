import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saladappv2_flutter/features/camera/screens/camera_screen.dart';
import 'package:saladappv2_flutter/features/dashboard/controller/dashboard_controller.dart';
import 'package:saladappv2_flutter/features/dashboard/widgets/bottom_navbar_widget.dart';
import 'package:saladappv2_flutter/features/disease/screens/disease_screen.dart';
import 'package:saladappv2_flutter/features/home/screens/home_screen.dart';
import 'package:saladappv2_flutter/features/profile/screens/profile_screen.dart';
import 'package:saladappv2_flutter/features/salad/screens/salad_screen.dart';
import 'package:saladappv2_flutter/helper/device_util.dart';
import 'package:saladappv2_flutter/util/dimensions.dart';
import 'package:saladappv2_flutter/util/style.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  final bool fromSplash;
  const DashboardScreen({
    super.key,
    required this.pageIndex,
    this.fromSplash = false,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PageController? _pageController;
  late List<Widget> _screens;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.pageIndex);

    _screens = [
      const HomeScreen(),
      const SaladScreen(),
      const CameraScreen(),
      const DiseaseScreen(),
      const ProfileScreen(),
    ];

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _screens.length,
            controller: _pageController,
            itemBuilder: (context, index) {
              return _screens[index];
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: DeviceUtils.screenWidth().w,
        padding: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 20.h),
        height: 100.h,
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.9),
        ),
        child: GetBuilder<DashboardController>(
          builder: (dashboardController) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BottomNavWidget(
                  title: "home_bar".tr,
                  isSelected: dashboardController.pageIndex == 0,
                  buttonIcon: Icons.home,
                  textSize: Dimensions.fontSizeDefault.sp,
                  iconSize: 30.w,
                  onTap: () {
                    dashboardController.getPage(0);
                    _pageController!.jumpToPage(dashboardController.pageIndex);
                  },
                ),
                BottomNavWidget(
                  title: "salad_bar".tr,
                  isSelected: dashboardController.pageIndex == 1,
                  buttonIcon: Icons.cloud_circle,
                  textSize: Dimensions.fontSizeDefault.sp,
                  iconSize: 30.w,
                  onTap: () {
                    dashboardController.getPage(1);
                    _pageController!.jumpToPage(dashboardController.pageIndex);
                  },
                ),
                BottomNavWidget(
                  title: "camera_bar".tr,
                  isSelected: dashboardController.pageIndex == 2,
                  buttonIcon: Icons.donut_large,
                  iconSize: 30.w,
                  textSize: Dimensions.fontSizeDefault.sp,
                  onTap: () {
                    dashboardController.getPage(2);
                    _pageController!.jumpToPage(dashboardController.pageIndex);
                  },
                ),
                BottomNavWidget(
                  title: "disease_bar".tr,
                  isSelected: dashboardController.pageIndex == 3,
                  buttonIcon: Icons.disabled_by_default,
                  textSize: Dimensions.fontSizeDefault.sp,
                  iconSize: 30.w,
                  onTap: () {
                    dashboardController.getPage(3);
                    _pageController!.jumpToPage(dashboardController.pageIndex);
                  },
                ),
                BottomNavWidget(
                  title: "profile_bar".tr,
                  isSelected: dashboardController.pageIndex == 4,
                  buttonIcon: Icons.energy_savings_leaf,
                  textSize: Dimensions.fontSizeDefault.sp,
                  iconSize: 30.w,
                  onTap: () {
                    dashboardController.getPage(4);
                    _pageController!.jumpToPage(dashboardController.pageIndex);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
