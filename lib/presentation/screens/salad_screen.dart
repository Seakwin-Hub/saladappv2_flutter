import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saladappv2_flutter/common/controller/theme_controller.dart';
import 'package:saladappv2_flutter/common/widgets/connection_widgets.dart';
import 'package:saladappv2_flutter/common/widgets/custom_appbar.dart';
import 'package:saladappv2_flutter/helper/router_helper.dart';
import 'package:saladappv2_flutter/presentation/controller/salad_controller.dart';
import 'package:saladappv2_flutter/helper/device_util.dart';
import 'package:saladappv2_flutter/presentation/screens/item_detail_screen.dart';
import 'package:saladappv2_flutter/util/dimensions.dart';
import 'package:saladappv2_flutter/util/images.dart';
import 'package:saladappv2_flutter/util/style.dart';

class SaladScreen extends StatefulWidget {
  const SaladScreen({super.key});

  @override
  State<SaladScreen> createState() => _SaladScreenState();
}

class _SaladScreenState extends State<SaladScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<SaladController>().checkConnetion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.find<ThemeController>().darkTheme
          ? AppColors.black
          : Colors.transparent,
      appBar: CustomAppBar(
        sizeOfHead: 130,
        isLogoLeft: true,
        iconLeft: Images.saladBar,
        isSignUp: true,
        title: "salad_screen".tr,
        backButton: false,
        color: AppColors.white,
        checkTheme: Get.find<ThemeController>().darkTheme,
      ),
      body: GetBuilder<SaladController>(
        builder: (saladController) {
          if (saladController.hasConnection == null) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (!saladController.hasConnection!) {
            return LostConnectionWidget();
          } else if (saladController.isExceptionError) {
            return ServerLostConnection();
          } else if (saladController.isLoading ||
              saladController.saladItem == null ||
              saladController.saladItem!.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: CircularProgressIndicator(),
              ),
            );
          }
          return SizedBox(
            height: DeviceUtils.screenHeight(),
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: saladController.saladItem!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: 10.h,
                    left: 10.w,
                    bottom: saladController.saladItem!.length - 1 == index
                        ? 135.h
                        : 0,
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(
                        RouterHelper.getItemDetailsRoute(
                          saladController.saladItem![index].saladId,
                          true,
                        ),
                        arguments: ItemDetailScreen(
                          isSalad: true,
                          itemSalad: saladController.saladItem![index],
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: DeviceUtils.screenWidth(),
                          height: DeviceUtils.screenHeight() * 0.045,
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 32, 101, 136),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50.r),
                              bottomLeft: Radius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            saladController.saladItem![index].saladName!,
                            style: battambangBlack.copyWith(
                              fontSize: Dimensions.fontSizeLarge.sp,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: DeviceUtils.getScreenHeight() * 0.15,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: saladController
                                .saladItem![index].saladImage!.length,
                            itemBuilder: (context, indexImg) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: indexImg == 0 ? 0 : 2.w,
                                  right: indexImg ==
                                          saladController.saladItem![index]
                                                  .saladImage!.length -
                                              1
                                      ? 10.w
                                      : 2.w,
                                  top: 3.h,
                                  bottom: 10.h,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.red.withValues(alpha: 0.5),
                                      width: 1.w,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child: CachedNetworkImage(
                                        imageUrl: saladController
                                            .saladItem![index]
                                            .saladImage![indexImg],
                                        width: 120.w,
                                        height: 120.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
