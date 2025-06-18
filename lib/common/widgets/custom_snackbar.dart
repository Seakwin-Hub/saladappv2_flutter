import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saladappv2_flutter/common/widgets/custom_toast.dart';
import 'package:saladappv2_flutter/util/dimensions.dart';

void showCustomSnackBar(
  String? message, {
  bool isError = true,
  bool getXSnackBar = false,
}) {
  if (message != null && message.isNotEmpty) {
    if (getXSnackBar) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: isError ? Colors.red : Colors.green,
          message: message,
          maxWidth: 500.w,
          duration: Duration(seconds: 2),
          snackStyle: SnackStyle.FLOATING,
          margin: EdgeInsets.only(
            left: Dimensions.paddingSizeSmall.w,
            right: Dimensions.paddingSizeSmall.w,
            bottom: 100.h,
          ),
          borderRadius: Dimensions.radiusSmall.r,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
        ),
      );
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: CustomToast(text: message, isError: isError),
          elevation: 0,
          padding: EdgeInsets.zero,
          dismissDirection: DismissDirection.endToStart,
          backgroundColor: Colors.transparent,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
