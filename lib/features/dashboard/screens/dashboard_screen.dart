import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saladappv2_flutter/common/controller/theme_controller.dart';
import 'package:saladappv2_flutter/common/widgets/custom_asset_image_widget.dart';
import 'package:saladappv2_flutter/features/camera/screens/camera_screen.dart';
import 'package:saladappv2_flutter/features/dashboard/controller/dashboard_controller.dart';
import 'package:saladappv2_flutter/features/dashboard/widgets/bottom_navbar_widget.dart';
import 'package:saladappv2_flutter/features/disease/screens/disease_screen.dart';
import 'package:saladappv2_flutter/features/home/screens/home_screen.dart';
import 'package:saladappv2_flutter/features/profile/screens/profile_screen.dart';
import 'package:saladappv2_flutter/features/salad/screens/salad_screen.dart';
import 'package:saladappv2_flutter/helper/device_util.dart';
import 'package:saladappv2_flutter/util/dimensions.dart';
import 'package:saladappv2_flutter/util/images.dart';
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
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _screens.length,
            controller: _pageController,
            itemBuilder: (context, index) {
              return _screens[index];
            },
          ),

          keyboardVisible
              ? SizedBox()
              : GetBuilder<ThemeController>(
                builder: (themeController) {
                  return Container(
                    width: DeviceUtils.screenWidth().w,
                    padding: EdgeInsets.only(
                      left: 8.w,
                      right: 8.w,
                      bottom: 20.h,
                    ),
                    height: 100.h,
                    decoration: BoxDecoration(
                      color:
                          themeController.darkTheme
                              ? AppColors.darkGrey
                              : AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22.r),
                        topRight: Radius.circular(22.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withValues(alpha: 0.2),
                          blurRadius: 2,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: GetBuilder<DashboardController>(
                      builder: (dashboardController) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            BottomNavWidget(
                              isDark:
                                  themeController.darkTheme
                                      ? AppColors.white
                                      : AppColors.green,
                              title: "home_bar".tr,
                              isSelected: dashboardController.pageIndex == 0,
                              buttonIcon: Images.homeBar,
                              textSize: Dimensions.fontSizeDefault.sp,
                              iconSize: 30.w,
                              onTap: () {
                                dashboardController.getPage(0);
                                _pageController!.jumpToPage(0);
                              },
                            ),
                            BottomNavWidget(
                              isDark:
                                  themeController.darkTheme
                                      ? AppColors.white
                                      : AppColors.green,
                              title: "salad_bar".tr,
                              isSelected: dashboardController.pageIndex == 1,
                              buttonIcon: Images.saladBar,
                              textSize: Dimensions.fontSizeDefault.sp,
                              iconSize: 30.w,
                              onTap: () {
                                dashboardController.getPage(1);
                                _pageController!.jumpToPage(
                                  dashboardController.pageIndex,
                                );
                              },
                            ),
                            Container(width: DeviceUtils.screenWidth() * 0.2),
                            BottomNavWidget(
                              isDark:
                                  themeController.darkTheme
                                      ? AppColors.white
                                      : AppColors.green,
                              title: "disease_bar".tr,
                              isSelected: dashboardController.pageIndex == 3,
                              buttonIcon: Images.diseaseBar,
                              textSize: Dimensions.fontSizeDefault.sp,
                              iconSize: 30.w,
                              onTap: () {
                                dashboardController.getPage(3);
                                _pageController!.jumpToPage(
                                  dashboardController.pageIndex,
                                );
                              },
                            ),
                            BottomNavWidget(
                              isDark:
                                  themeController.darkTheme
                                      ? AppColors.white
                                      : AppColors.green,
                              title: "profile_bar".tr,
                              isSelected: dashboardController.pageIndex == 4,
                              buttonIcon: Images.profileBar,
                              textSize: Dimensions.fontSizeDefault.sp,
                              iconSize: 30.w,
                              onTap: () {
                                dashboardController.getPage(4);
                                _pageController!.jumpToPage(
                                  dashboardController.pageIndex,
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
          keyboardVisible
              ? SizedBox()
              : GetBuilder<ThemeController>(
                builder: (themeController) {
                  return Positioned(
                    bottom: 50.h,
                    child: Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 5,
                          color:
                              themeController.darkTheme
                                  ? AppColors.darkGrey
                                  : AppColors.white,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                        shape: BoxShape.circle,
                      ),

                      child: GetBuilder<DashboardController>(
                        builder: (dashboardController) {
                          return FloatingActionButton(
                            backgroundColor:
                                themeController.darkTheme
                                    ? AppColors.dark
                                    : AppColors.primary,
                            shape: CircleBorder(),
                            onPressed: () {
                              dashboardController.getPage(2);
                              _pageController!.jumpToPage(
                                dashboardController.pageIndex,
                              );
                            },
                            elevation: 0,
                            child: CustomAssetImageWidget(
                              Images.cameraBar,
                              width: 40.w,
                              color:
                                  dashboardController.pageIndex == 2
                                      ? AppColors.green
                                      : themeController.darkTheme
                                      ? AppColors.darkGrey
                                      : AppColors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
        ],
      ),
    );
  }
}
