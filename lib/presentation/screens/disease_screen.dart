import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saladappv2_flutter/common/controller/theme_controller.dart';
import 'package:saladappv2_flutter/common/widgets/connection_widgets.dart';
import 'package:saladappv2_flutter/common/widgets/custom_appbar.dart';
import 'package:saladappv2_flutter/helper/device_util.dart';
import 'package:saladappv2_flutter/helper/router_helper.dart';
import 'package:saladappv2_flutter/presentation/controller/disease_controller.dart';
import 'package:saladappv2_flutter/presentation/controller/salad_controller.dart';
import 'package:saladappv2_flutter/presentation/screens/item_detail_screen.dart';
import 'package:saladappv2_flutter/util/dimensions.dart';
import 'package:saladappv2_flutter/util/images.dart';
import 'package:saladappv2_flutter/util/style.dart';

class DiseaseScreen extends StatefulWidget {
  const DiseaseScreen({super.key});

  @override
  State<DiseaseScreen> createState() => _DiseaseScreenState();
}

class _DiseaseScreenState extends State<DiseaseScreen> {
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
        isLogoLeft: true,
        iconLeft: Images.diseaseBar,
        isSignUp: true,
        sizeOfHead: 130,
        title: "disease_screen".tr,
        backButton: false,
        color: AppColors.white,
        checkTheme: Get.find<ThemeController>().darkTheme,
      ),
      body: GetBuilder<DiseaseController>(
        builder: (diseaesController) {
          Future.delayed(
            const Duration(seconds: 1),
            () => diseaesController.handleConnection(),
          );

          if (diseaesController.hasConnection == null) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (!diseaesController.hasConnection!) {
            return LostConnectionWidget();
          } else if (diseaesController.isExceptionError) {
            return ServerLostConnection();
          } else if (diseaesController.isLoading ||
              diseaesController.diseaseItem == null ||
              diseaesController.diseaseItem!.isEmpty) {
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
              itemCount: diseaesController.diseaseItem!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: 10.h,
                    left: 10.w,
                    bottom: diseaesController.diseaseItem!.length - 1 == index
                        ? 135.h
                        : 0,
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(
                        RouterHelper.getItemDetailsRoute(
                          diseaesController.diseaseItem![index].diseaseId,
                          false,
                        ),
                        arguments: ItemDetailScreen(
                          isSalad: false,
                          itemDisease: diseaesController.diseaseItem![index],
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
                            color: const Color.fromARGB(255, 116, 115, 116),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50.r),
                              bottomLeft: Radius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            index == 0 ||
                                    index ==
                                        diseaesController.diseaseItem!.length -
                                            1
                                ? diseaesController
                                    .diseaseItem![index].diseaseName!
                                : '${diseaesController.diseaseItem![index].diseaseName!} (${diseaesController.diseaseItem![index].typeOfDisease})',
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
                            itemCount: diseaesController
                                .diseaseItem![index].diseaseImage!.length,
                            itemBuilder: (context, indexImg) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: indexImg == 0 ? 0 : 2.w,
                                  right: indexImg ==
                                          diseaesController.diseaseItem![index]
                                                  .diseaseImage!.length -
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
                                        imageUrl: diseaesController
                                            .diseaseItem![index]
                                            .diseaseImage![indexImg],
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
