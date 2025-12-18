import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:saladappv2_flutter/common/controller/theme_controller.dart';
import 'package:saladappv2_flutter/common/widgets/custom_appbar.dart';
import 'package:saladappv2_flutter/domain/models/disease_list_model.dart';
import 'package:saladappv2_flutter/domain/models/salad_list_model.dart';
import 'package:saladappv2_flutter/helper/device_util.dart';
import 'package:saladappv2_flutter/presentation/controller/disease_controller.dart';
import 'package:saladappv2_flutter/presentation/controller/item_detail_controller.dart';
import 'package:saladappv2_flutter/presentation/controller/salad_controller.dart';
import 'package:saladappv2_flutter/util/dimensions.dart';
import 'package:saladappv2_flutter/util/style.dart';

class ItemDetailScreen extends StatefulWidget {
  const ItemDetailScreen({
    super.key,
    this.itemSalad,
    this.itemDisease,
    required this.isSalad,
  });
  final SaladModel? itemSalad;
  final DiseaseModel? itemDisease;
  final bool isSalad;

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ItemDetailController>().handleItemIndex(0);
    if (widget.isSalad) {
      Get.find<SaladController>().getSaladById(widget.itemSalad!);
    } else {
      Get.find<DiseaseController>().getDiseaseById(widget.itemDisease!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.find<ThemeController>().darkTheme
          ? AppColors.black
          : Colors.white,
      appBar: CustomAppBar(
        titleLocate: !widget.isSalad
            ? widget.itemDisease!.typeOfDisease == 'Viral' ||
                    widget.itemDisease!.typeOfDisease == 'Bacterial'
                ? 100.w
                : 50.w
            : 100.w,
        isItemDetail: true,
        isLogoLeft: false,
        color:
            Get.find<ThemeController>().darkTheme ? Colors.white : Colors.black,
        title: widget.isSalad
            ? widget.itemSalad!.saladName!
            : widget.itemDisease!.typeOfDisease == 'Viral' ||
                    widget.itemDisease!.typeOfDisease == 'Bacterial'
                ? widget.itemDisease!.diseaseName!
                : '${widget.itemDisease!.diseaseName!} (${widget.itemDisease!.typeOfDisease!})',
        backButton: true,
        checkTheme: Get.find<ThemeController>().darkTheme,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  width: DeviceUtils.getScreenWidth(context),
                  height: DeviceUtils.getScreenHeight() * 0.45,
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.r),
                        bottomRight: Radius.circular(15.r),
                      ),
                      child: GetBuilder<ItemDetailController>(
                        builder: (itemDetailController) {
                          return widget.isSalad
                              ? CachedNetworkImage(
                                  imageUrl: widget.itemSalad!.saladImage![
                                      itemDetailController.itemIndex],
                                  fit: BoxFit.cover,
                                )
                              : CachedNetworkImage(
                                  imageUrl: widget.itemDisease!.diseaseImage![
                                      itemDetailController.itemIndex],
                                  fit: BoxFit.cover,
                                );
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20.h,
                  left: 0.w,
                  right: 0.w,
                  child: Container(
                    width: DeviceUtils.getScreenWidth(context),
                    height: 70.h,
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black12),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.r)),
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.isSalad
                          ? widget.itemSalad!.saladImage!.length
                          : widget.itemDisease!.diseaseImage!.length,
                      itemBuilder: (context, index) {
                        int lengthItem = widget.isSalad
                            ? widget.itemSalad!.saladImage!.length - 1
                            : widget.itemDisease!.diseaseImage!.length - 1;
                        return InkWell(
                          onTap: () => Get.find<ItemDetailController>()
                              .handleItemIndex(index),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: index == 0 ? 10.w : 1.w,
                              right: index == lengthItem ? 10.w : 1.w,
                              top: 3.h,
                              bottom: 3.h,
                            ),
                            child: Container(
                              width: 70.w,
                              height: 70.h,
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.r),
                                child: CachedNetworkImage(
                                  imageUrl: widget.isSalad
                                      ? widget.itemSalad!.saladImage![index]
                                      : widget
                                          .itemDisease!.diseaseImage![index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
              child: Text(
                'about_des'.tr,
                style: battambangBold.copyWith(
                  fontSize: Dimensions.fontSizeLarge.sp,
                  color: Get.find<ThemeController>().darkTheme
                      ? AppColors.greenDark
                      : Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Text(
                widget.isSalad
                    ? widget.itemSalad!.saladDescription!
                    : widget.itemDisease!.diseaseMeaning!,
                style: battambangRegular.copyWith(
                  fontSize: Dimensions.fontSizeDefault.sp,
                  color: Get.find<ThemeController>().darkTheme
                      ? AppColors.greenDark
                      : Colors.black,
                ),
              ),
            ),
            !widget.isSalad
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 25.w,
                      vertical: 15.h,
                    ),
                    child: Text(
                      'treatment_des'.tr,
                      style: battambangBold.copyWith(
                        fontSize: Dimensions.fontSizeLarge.sp,
                        color: Get.find<ThemeController>().darkTheme
                            ? AppColors.greenDark
                            : Colors.black,
                      ),
                    ),
                  )
                : SizedBox(),
            !widget.isSalad
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Divider(),
                  )
                : SizedBox(),
            !widget.isSalad
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Text(
                      widget.itemDisease!.diseaseTreatment!,
                      style: battambangRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault.sp,
                        color: Get.find<ThemeController>().darkTheme
                            ? AppColors.greenDark
                            : Colors.black,
                      ),
                    ),
                  )
                : SizedBox(),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}

void openDialog(BuildContext context, String imageUrl) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault.r),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                child: PhotoView(
                  tightMode: true,
                  imageProvider: NetworkImage(imageUrl),
                  heroAttributes: PhotoViewHeroAttributes(tag: imageUrl),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  splashRadius: 5,
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.cancel, color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
    );
