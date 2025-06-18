import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saladappv2_flutter/util/dimensions.dart';
import 'package:saladappv2_flutter/util/style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool backButton;
  final Function? onBackPressed;
  final Color? color;
  final bool isSignUp;
  final bool? checkTheme;
  const CustomAppBar({
    super.key,
    this.checkTheme,
    required this.title,
    this.color,
    this.backButton = true,
    this.isSignUp = false,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: robotoMedium.copyWith(
          fontSize: Dimensions.fontSizeLarge.sp,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).textTheme.bodyLarge!.color,
        ),
      ),
      centerTitle: true,
      leading:
          backButton
              ? IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: color,
                onPressed:
                    () => onBackPressed != null ? onBackPressed!() : Get.back(),
              )
              : const SizedBox(),

      backgroundColor: checkTheme! ? AppColors.black : AppColors.greenDark,

      surfaceTintColor:
          isSignUp ? AppColors.greenDark : Theme.of(context).cardColor,
      shadowColor:
          isSignUp
              ? Colors.transparent
              : Theme.of(context).disabledColor.withValues(alpha: 0.5),
      elevation: isSignUp ? 0 : 2,
      actions: [],
    );
  }

  @override
  Size get preferredSize => Size(Get.width, GetPlatform.isDesktop ? 100 : 50);
}
