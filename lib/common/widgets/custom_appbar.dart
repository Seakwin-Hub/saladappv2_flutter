import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saladappv2_flutter/common/widgets/custom_asset_image_widget.dart';
import 'package:saladappv2_flutter/util/dimensions.dart';
import 'package:saladappv2_flutter/util/style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool backButton;
  final Function? onBackPressed;
  final Color? color;
  final bool isSignUp;
  final double sizeOfHead;
  final bool isLogoLeft;
  final String? iconLeft;
  final bool? checkTheme;
  final bool isItemDetail;
  final double titleLocate;
  const CustomAppBar({
    super.key,
    this.checkTheme,
    this.isItemDetail = false,
    required this.title,
    this.color,
    this.backButton = true,
    this.isSignUp = false,
    this.isLogoLeft = true,
    this.iconLeft,
    this.titleLocate = 80,
    this.sizeOfHead = 100,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: isLogoLeft ? 0 : 56.w,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          isLogoLeft
              ? Container(
                  padding: EdgeInsets.all(3.w),
                  width: 38.w,
                  height: 38.h,
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.4),
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    child: CustomAssetImageWidget(iconLeft!, width: 25.w),
                  ),
                )
              : SizedBox(),
          SizedBox(width: isLogoLeft ? sizeOfHead.w : titleLocate.w),
          Text(
            title,
            style: battambangRegular.copyWith(
              fontSize: Dimensions.fontSizeLarge.sp,
              fontWeight: FontWeight.w600,
              color:
                  isItemDetail ? AppColors.greenDark : AppColors.buttonPrimary,
            ),
          ),
        ],
      ),
      centerTitle: isLogoLeft ? false : true,
      leading: backButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: color,
              onPressed: () =>
                  onBackPressed != null ? onBackPressed!() : Get.back(),
            )
          : const SizedBox(),
      backgroundColor: checkTheme!
          ? AppColors.darkerGrey
          : isItemDetail
              ? AppColors.white
              : AppColors.greenDark,
      surfaceTintColor:
          isSignUp ? AppColors.greenDark : Theme.of(context).cardColor,
      shadowColor: isSignUp
          ? Colors.transparent
          : Theme.of(context).disabledColor.withValues(alpha: 0.5),
      elevation: isSignUp ? 0 : 2,
      actions: [],
    );
  }

  @override
  Size get preferredSize => Size(Get.width, GetPlatform.isDesktop ? 100 : 50);
}
