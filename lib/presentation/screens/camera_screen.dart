import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:saladappv2_flutter/common/controller/theme_controller.dart';
import 'package:saladappv2_flutter/common/widgets/custom_appbar.dart';
import 'package:saladappv2_flutter/common/widgets/custom_asset_image_widget.dart';
import 'package:saladappv2_flutter/common/widgets/custom_box_widget.dart';
import 'package:saladappv2_flutter/common/widgets/custom_button.dart';
import 'package:saladappv2_flutter/helper/device_util.dart';
import 'package:saladappv2_flutter/presentation/controller/camera_controller.dart';
import 'package:saladappv2_flutter/util/dimensions.dart';
import 'package:saladappv2_flutter/util/images.dart';
import 'package:saladappv2_flutter/util/style.dart';
import 'package:dotted_border/dotted_border.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  void initState() {
    Get.find<CameraController>().initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.find<ThemeController>().darkTheme
          ? AppColors.black
          : Colors.transparent,
      appBar: CustomAppBar(
        isLogoLeft: true,
        iconLeft: Images.cameraBar,
        isSignUp: true,
        title: "camera_screen".tr,
        backButton: false,
        color: AppColors.white,
        sizeOfHead: 130,
        checkTheme: Get.find<ThemeController>().darkTheme,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(18.w),
              child: GetBuilder<CameraController>(
                builder: (cameraController) {
                  return Text(
                    cameraController.isNotDetectCall
                        ? "upload_disease".tr
                        : "result_of_disease".tr,
                    style: battambangBlack.copyWith(
                      color: Get.find<ThemeController>().darkTheme
                          ? Colors.white
                          : Colors.black,
                      fontSize: Dimensions.fontSizeDefault.sp,
                    ),
                  );
                },
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GetBuilder<CameraController>(
                  builder: (cameraController) {
                    return cameraController.isNotDetectCall
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              cameraController.rawFile != null
                                  ? Image.memory(
                                      cameraController.rawFile!,
                                      width: 160.w,
                                      height: 160.h,
                                      fit: BoxFit.fill,
                                    )
                                  : Icon(
                                      Iconsax.gallery,
                                      size: 52.w,
                                      color:
                                          Get.find<ThemeController>().darkTheme
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                              CustomBoxWidget(
                                sizeOfSpace: 35,
                                color: Get.find<ThemeController>().darkTheme
                                    ? Colors.white
                                    : Colors.black12,
                              ),
                            ],
                          )
                        : Container(
                            width: DeviceUtils.getScreenWidth(context) * .9,
                            height: DeviceUtils.getScreenHeight() * 0.35,
                            padding: EdgeInsets.only(
                                bottom: 5.h, top: 5.h, left: 8.w, right: 8.w),
                            decoration: BoxDecoration(
                              color: AppColors.darkGrey.withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.r),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                    cameraController.imageData!.imageDetected!,
                                width: DeviceUtils.getScreenWidth(context) * .9,
                              ),
                            ),
                          );
                  },
                ),
                SizedBox(width: 10.w),
                GetBuilder<CameraController>(
                  builder: (cameraController) {
                    return cameraController.isNotDetectCall
                        ? DottedBorder(
                            options: RoundedRectDottedBorderOptions(
                              color: Get.find<ThemeController>().darkTheme
                                  ? Colors.white60
                                  : Colors.black26,
                              dashPattern: [12, 4],
                              padding: EdgeInsets.all(4.w),
                              radius: Radius.circular(12.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () => Get.find<CameraController>()
                                      .pickImage(true),
                                  child: Container(
                                    width: 100.w,
                                    height: 80.h,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: AppColors.borderPrimary,
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          CustomAssetImageWidget(
                                            Images.cameraBar,
                                            width: 28.w,
                                          ),
                                          Text(
                                            "take_photo".tr,
                                            style: battambangRegular.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeSmall.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                InkWell(
                                  onTap: () => Get.find<CameraController>()
                                      .pickImage(false),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    width: 100.w,
                                    height: 80.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.borderPrimary,
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(Iconsax.gallery_add5,
                                              color: Colors.black),
                                          Text(
                                            "choose_image".tr,
                                            style: battambangRegular.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeSmall.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox();
                  },
                ),
              ],
            ),
            GetBuilder<CameraController>(
              builder: (cameraController) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cameraController.isNotDetectCall
                        ? CustomButton(
                            buttonText: "dectect_disease".tr,
                            width: DeviceUtils.getScreenWidth(context) * 0.45,
                            radius: 5.r,
                            height: 35.h,
                            fontSize: Dimensions.fontSizeDefault.sp,
                            onPressed: () =>
                                Get.find<CameraController>().detectionImage(),
                          )
                        : SizedBox(),
                    SizedBox(
                      width: cameraController.isNotDetectCall ? 10.w : 0,
                    ),
                    CustomButton(
                        buttonText: "cancel".tr,
                        width: cameraController.isNotDetectCall
                            ? DeviceUtils.getScreenWidth(context) * 0.28
                            : DeviceUtils.getScreenWidth(context) * 0.9,
                        radius: 5.r,
                        height: cameraController.isNotDetectCall ? 35.h : 40.h,
                        fontSize: Dimensions.fontSizeDefault.sp,
                        onPressed: () =>
                            Get.find<CameraController>().initData())
                  ],
                );
              },
            ),
            GetBuilder<CameraController>(
              builder: (cameraController) {
                return cameraController.isNotDetectCall
                    ? SizedBox()
                    : Column(
                        children: [
                          Divider(
                              height: 20.h,
                              thickness: 8.h,
                              color: Colors.black12),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "disease_founded".tr,
                                  style: battambangBold.copyWith(
                                    fontSize: Dimensions.fontSizeDefault.sp,
                                    color: Get.find<ThemeController>().darkTheme
                                        ? AppColors.green
                                        : Colors.red,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      " ${cameraController.diseaseData!.diseaseName} (${cameraController.diseaseData!.typeOfDisease})",
                                  style: battambangBold.copyWith(
                                    fontSize: Dimensions.fontSizeDefault.sp,
                                    color: Get.find<ThemeController>().darkTheme
                                        ? AppColors.green
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                              height: 20.h,
                              thickness: 8.h,
                              color: Colors.black12),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10.w, right: 10.w, top: 25.h),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'disease_bar'.tr +
                                    cameraController.diseaseData!.diseaseName!,
                                style: battambangBlack.copyWith(
                                  fontSize: Dimensions.fontSizeExtraLarge.sp,
                                  color: Get.find<ThemeController>().darkTheme
                                      ? AppColors.green
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                '\n${cameraController.diseaseData!.diseaseMeaning!}\n\n${cameraController.diseaseData!.causeOfDisease!}',
                                style: battambangRegular.copyWith(
                                  fontSize: Dimensions.fontSizeLarge.sp,
                                  color: Get.find<ThemeController>().darkTheme
                                      ? AppColors.white
                                      : AppColors.darkGrey,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10.w, right: 10.w, top: 25.h),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'treatment_des'.tr,
                                style: battambangBlack.copyWith(
                                  fontSize: Dimensions.fontSizeExtraLarge.sp,
                                  color: Get.find<ThemeController>().darkTheme
                                      ? AppColors.green
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                '\n${cameraController.diseaseData!.diseaseMeaning!}\n\n${cameraController.diseaseData!.causeOfDisease!}\n\n',
                                style: battambangRegular.copyWith(
                                  fontSize: Dimensions.fontSizeLarge.sp,
                                  color: Get.find<ThemeController>().darkTheme
                                      ? AppColors.white
                                      : AppColors.darkGrey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
              },
            ),
            SizedBox(
              height: 130.h,
            )
          ],
        ),
      ),
    );
  }
}
