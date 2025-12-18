import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saladappv2_flutter/common/controller/theme_controller.dart';
import 'package:saladappv2_flutter/common/widgets/connection_widgets.dart';
import 'package:saladappv2_flutter/common/widgets/custom_asset_image_widget.dart';
import 'package:saladappv2_flutter/common/widgets/home_widget.dart';
import 'package:saladappv2_flutter/presentation/controller/disease_controller.dart';
import 'package:saladappv2_flutter/presentation/controller/salad_controller.dart';
import 'package:saladappv2_flutter/helper/device_util.dart';
import 'package:saladappv2_flutter/util/dimensions.dart';
import 'package:saladappv2_flutter/util/images.dart';
import 'package:saladappv2_flutter/util/style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<SaladController>().checkConnetion();

    if (Get.find<SaladController>().saladItem == null ||
        Get.find<SaladController>().saladItem!.isEmpty) {
      Get.find<SaladController>().getSaladList();
    }
    if (Get.find<DiseaseController>().diseaseItem == null ||
        Get.find<DiseaseController>().diseaseItem!.isEmpty) {
      Get.find<DiseaseController>().getDiseaseList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return Scaffold(
          backgroundColor:
              themeController.darkTheme ? AppColors.black : Colors.transparent,
          appBar: AppBar(
            toolbarHeight: 30.h,
            backgroundColor: themeController.darkTheme
                ? AppColors.darkerGrey
                : AppColors.green,
          ),
          body: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverAppBar(
                backgroundColor: themeController.darkTheme
                    ? AppColors.darkerGrey
                    : AppColors.green,
                floating: true,
                automaticallyImplyLeading: false,
                toolbarHeight: 60.h,
                elevation: 0,
                pinned: true,
                snap: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(3.w),
                          width: 60.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                            color: AppColors.white.withValues(alpha: 0.4),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            child: Image.asset(Images.logo, width: 35.w),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeSmall.w,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "welcome_back".tr,
                                style: battambangRegular.copyWith(
                                  color: AppColors.textWhite.withValues(
                                    alpha: 0.8,
                                  ),
                                  fontSize: Dimensions.fontSizeDefault.sp,
                                ),
                              ),
                              Text(
                                "salad_app".tr,
                                style: battambangRegular.copyWith(
                                  color: AppColors.textWhite,
                                  fontSize: Dimensions.fontSizeLarge.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Get.find<ThemeController>().toggleTheme();
                      },
                      child: Container(
                        padding: EdgeInsets.all(7.w),
                        width: 40.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: CustomAssetImageWidget(
                          Images.modeOption,
                          fit: BoxFit.contain,
                          color: themeController.darkTheme
                              ? AppColors.black
                              : AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Search Box
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverDelegate(
                  height: 15.h,
                  callback: (val) {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: themeController.darkTheme
                          ? AppColors.darkerGrey
                          : AppColors.green,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12.r),
                        bottomRight: Radius.circular(12.r),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                    width: DeviceUtils.screenWidth(),
                    height: 15.h,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: GetBuilder<SaladController>(
                    builder: (saladController) {
                      return GetBuilder<DiseaseController>(
                        builder: (diseaseController) {
                          if (saladController.hasConnection == null) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.all(10.w),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          if (!saladController.hasConnection!) {
                            return LostConnectionWidget(isHomeScreen: true);
                          } else if (saladController.isExceptionError ||
                              diseaseController.isExceptionError) {
                            return ServerLostConnection(isHomeScreen: true);
                          } else if ((saladController.isLoading ||
                                  saladController.saladItem == null ||
                                  saladController.saladItem!.isEmpty) ||
                              (diseaseController.isLoading ||
                                  diseaseController.diseaseItem == null ||
                                  diseaseController.diseaseItem!.isEmpty)) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.all(10.w),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HomeWidget(
                                isSalad: true,
                                diseaseList: [],
                                saladList: saladController.saladItem,
                                themeController: themeController.darkTheme,
                              ),
                              HomeWidget(
                                isSalad: false,
                                saladList: [],
                                diseaseList: diseaseController.diseaseItem,
                                themeController: themeController.darkTheme,
                              ),
                              SizedBox(height: 140.h),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  double height;
  Function(bool isPinned)? callback;
  bool isPinned = false;

  SliverDelegate({required this.child, this.height = 50, this.callback});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    isPinned = shrinkOffset == maxExtent /*|| shrinkOffset < maxExtent*/;
    callback!(isPinned);
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != height ||
        oldDelegate.minExtent != height ||
        child != oldDelegate.child;
  }
}
