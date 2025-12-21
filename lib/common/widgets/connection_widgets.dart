import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:saladappv2_flutter/common/controller/theme_controller.dart';
import 'package:saladappv2_flutter/common/widgets/custom_asset_image_widget.dart';
import 'package:saladappv2_flutter/common/widgets/custom_button.dart';
import 'package:saladappv2_flutter/helper/device_util.dart';
import 'package:saladappv2_flutter/presentation/controller/salad_controller.dart';
import 'package:saladappv2_flutter/util/images.dart';
import 'package:saladappv2_flutter/util/style.dart';

class LostConnectionWidget extends StatelessWidget {
  final bool isHomeScreen;
  const LostConnectionWidget({super.key, this.isHomeScreen = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          width: DeviceUtils.screenWidth(),
          height: isHomeScreen
              ? DeviceUtils.screenHeight() * 0.54
              : DeviceUtils.screenHeight() * 0.64,
        ),
        Positioned(
          top: isHomeScreen ? 0 : 50,
          child: Lottie.asset(
            Images.lostConnection,
            fit: BoxFit.fill,
            width: 400.w,
          ),
        ),
        Positioned(
          child: ListTile(
            title: Text(
              textAlign: TextAlign.center,
              "lost_connection".tr,
              style: battambangBold.copyWith(
                color: Get.find<ThemeController>().darkTheme
                    ? Colors.redAccent
                    : Colors.black,
                fontSize: 18.sp,
              ),
            ),
            dense: true,
            subtitle: Text(
              textAlign: TextAlign.center,
              "lost_connection_msg".tr,
              style: battambangRegular.copyWith(
                color: Get.find<ThemeController>().darkTheme
                    ? Colors.white
                    : Colors.black45,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ServerLostConnection extends StatelessWidget {
  const ServerLostConnection({super.key, this.isHomeScreen = false});
  final bool isHomeScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: isHomeScreen ? 30.h : 100.h),
        CustomAssetImageWidget(
          Images.serverError,
          width: isHomeScreen ? 250.w : 300.w,
          fit: BoxFit.cover,
        ),
        ListTile(
          title: Text(
            textAlign: TextAlign.center,
            "server_maintenance".tr,
            style: battambangBold.copyWith(color: Colors.red, fontSize: 18.sp),
          ),
          dense: true,
          subtitle: Text(
            textAlign: TextAlign.center,
            "server_maintenance_msg".tr,
            style: battambangRegular.copyWith(
              color: Get.find<ThemeController>().darkTheme
                  ? Colors.white
                  : Colors.black45,
              fontSize: 14.sp,
            ),
          ),
        ),
        CustomButton(
          margin: EdgeInsets.only(top: 20.h),
          color: AppColors.green,
          width: 120.w,
          fontSize: 14.sp,
          height: 34.h,
          buttonText: "retry".tr,
          onPressed: () {
            if (Get.find<SaladController>().isExceptionError &&
                !Get.find<SaladController>().isLoading) {
              Get.find<SaladController>().handleLoading(false);
              Future.delayed(const Duration(seconds: 1), () {
                Get.find<SaladController>().handleLoading(true);
                Get.find<SaladController>().getSaladList();
              });
            }
          },
          isLoading: Get.find<SaladController>().isLoading,
        ),
      ],
    );
  }
}
