import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saladappv2_flutter/domain/models/disease_list_model.dart';
import 'package:saladappv2_flutter/domain/models/salad_list_model.dart';
import 'package:saladappv2_flutter/helper/device_util.dart';
import 'package:saladappv2_flutter/helper/router_helper.dart';
import 'package:saladappv2_flutter/presentation/controller/dashboard_controller.dart';
import 'package:saladappv2_flutter/presentation/screens/item_detail_screen.dart';
import 'package:saladappv2_flutter/util/dimensions.dart';
import 'package:saladappv2_flutter/util/style.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    this.saladList,
    this.diseaseList,
    required this.themeController,
    required this.isSalad,
  });
  final List<SaladModel>? saladList;
  final List<DiseaseModel>? diseaseList;
  final bool themeController;
  final bool isSalad;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isSalad ? "salad_type".tr : "disease_type".tr,
              style: battambangBlack.copyWith(
                fontSize: Dimensions.fontSizeLarge.sp,
                color: themeController ? AppColors.white : AppColors.dark,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
              ),

              onPressed: () {
                Get.find<DashboardController>().getPage(isSalad ? 1 : 3);
                Get.find<DashboardController>().naviageToPageIndex();
              },

              isSemanticButton: false,
              child: Text(
                "see_all".tr,
                style: battambangRegular.copyWith(
                  fontSize: Dimensions.fontSizeSmall.sp,
                  color: AppColors.darkGrey,
                ),
              ),
            ),
          ],
        ),

        SizedBox(
          width: DeviceUtils.getScreenWidth(context),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 5.w,
              crossAxisCount: 3,
              mainAxisSpacing: 10.h,
              childAspectRatio: (1 / 1.5),
            ),
            itemCount: isSalad ? saladList!.length + 1 : diseaseList!.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (isSalad) {
                    Get.toNamed(
                      RouterHelper.getItemDetailsRoute(
                        index > saladList!.length - 1
                            ? saladList![1].saladId
                            : saladList![index].saladId,
                        true,
                      ),
                      arguments: ItemDetailScreen(
                        isSalad: true,
                        itemSalad:
                            index > saladList!.length - 1
                                ? saladList![1]
                                : saladList![index],
                      ),
                    );
                  } else {
                    Get.toNamed(
                      RouterHelper.getItemDetailsRoute(
                        diseaseList![index].diseaseId,
                        false,
                      ),
                      arguments: ItemDetailScreen(
                        isSalad: false,
                        itemDisease: diseaseList![index],
                      ),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        themeController
                            ? AppColors.buttonSecondary
                            : Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white30,
                        blurRadius: 2,
                        spreadRadius: 1,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      width: 1,
                      style: BorderStyle.solid,
                      color: AppColors.softGrey,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(3.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.r),
                          child: CachedNetworkImage(
                            imageUrl:
                                isSalad
                                    ? index > saladList!.length - 1
                                        ? saladList![1].saladImage![7]
                                        : saladList![index]
                                            .saladImage![index == 0 ? 0 : 8]
                                    : diseaseList![index].diseaseImage![4],
                            width: 120.w,
                            height: 120.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      isSalad
                          ? Text(
                            index > saladList!.length - 1
                                ? saladList![1].saladName!
                                : saladList![index].saladName!,
                            style: battambangRegular.copyWith(
                              fontSize: Dimensions.fontSizeDefault.sp,
                            ),
                          )
                          : ListTile(
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            minTileHeight: 0,
                            minVerticalPadding: 0,
                            title: Text(
                              textAlign: TextAlign.center,
                              diseaseList![index].diseaseName!,
                              style: battambangRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault.sp,
                              ),
                            ),
                            subtitle: Text(
                              textAlign: TextAlign.center,
                              index == 0 || index == diseaseList!.length - 1
                                  ? ''
                                  : '(${diseaseList![index].typeOfDisease!})',
                              style: battambangBlack.copyWith(fontSize: 9.sp),
                            ),
                          ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
