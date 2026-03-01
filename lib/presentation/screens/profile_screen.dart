import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saladappv2_flutter/common/controller/theme_controller.dart';
import 'package:saladappv2_flutter/common/widgets/custom_appbar.dart';
import 'package:saladappv2_flutter/common/widgets/custom_asset_image_widget.dart';
import 'package:saladappv2_flutter/helper/device_util.dart';
import 'package:saladappv2_flutter/util/dimensions.dart';
import 'package:saladappv2_flutter/util/images.dart';
import 'package:saladappv2_flutter/util/style.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Get.find<ThemeController>().darkTheme
              ? AppColors.black
              : Colors.transparent,
      appBar: CustomAppBar(
        isLogoLeft: false,
        isSignUp: true,
        title: "",
        backButton: false,
        color: AppColors.white,
        checkTheme: Get.find<ThemeController>().darkTheme,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(width: DeviceUtils.screenWidth(), height: 220.h),
                Positioned.fill(
                  bottom: 55.h,
                  child: Container(
                    height: DeviceUtils.screenHeight() * 0.2,

                    decoration: BoxDecoration(
                      color:
                          Get.find<ThemeController>().darkTheme
                              ? AppColors.darkerGrey
                              : AppColors.greenDark,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(14.r),
                        bottomRight: Radius.circular(14.r),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  top: 3.h,
                  child: ListTile(
                    minVerticalPadding: 5.h,
                    title: Text(
                      textAlign: TextAlign.center,
                      "name".tr,
                      style: battambangBlack.copyWith(
                        fontSize: Dimensions.fontSizeOverLarge.sp,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      textAlign: TextAlign.center,
                      "role".tr,
                      style: battambangRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall.sp,
                        color: Colors.greenAccent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8.h,
                  child: Container(
                    padding: EdgeInsets.all(5.w),
                    width: 120.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                      color: AppColors.textSecondary,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: CustomAssetImageWidget(
                        Images.profileRonaldo,
                        width: 125.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            InfoWidget(
              title: "contact_title".tr,
              subtitle: "email_value".tr,
              icon: Images.emailIcon,
            ),
            Divider(),
            InfoWidget(
              title: "phone_title".tr,
              subtitle: "phone_num".tr,
              icon: Images.telephone,
            ),
            Divider(),
            InfoWidget(
              title: "owner_dev".tr,
              subtitle: "name".tr,
              icon: Images.developerIcon,
            ),
            Divider(),
            InfoWidget(
              title: "release".tr,
              subtitle: "release_date".tr,
              icon: Images.defenseDate,
            ),
            SizedBox(height: 130.h),
          ],
        ),
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key, this.title, this.subtitle, this.icon});

  final String? title;
  final String? subtitle;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5.w, bottom: 8.h),
      child: Container(
        width: DeviceUtils.getScreenWidth(context) * 0.90,
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(32.r),
            bottomRight: Radius.circular(32.r),
          ),
        ),
        child: ListTile(
          minVerticalPadding: 5.h,
          leading: CustomAssetImageWidget(icon!, width: 36.w),
          title: Text(
            title!,
            style: battambangBlack.copyWith(
              fontSize: Dimensions.fontSizeLarge.sp,
              color:
                  Get.find<ThemeController>().darkTheme
                      ? AppColors.greenDark
                      : Colors.black,
            ),
          ),
          subtitle: Text(
            subtitle!,
            style: battambangRegular.copyWith(
              fontSize: Dimensions.fontSizeSmall.sp,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
