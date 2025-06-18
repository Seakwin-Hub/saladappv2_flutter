import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saladappv2_flutter/util/dimensions.dart';
import 'package:saladappv2_flutter/util/style.dart';

class CustomButton extends StatelessWidget {
  final Function? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double radius;
  final IconData? icon;
  final IconData? iconRight;
  final Color? color;
  final Color? textColor;
  final bool isLoading;
  final bool isBold;
  final bool isRaduis;

  const CustomButton({
    super.key,
    this.onPressed,
    required this.buttonText,
    this.transparent = false,
    this.margin,
    this.width,
    this.height,
    this.fontSize,
    this.radius = 10,
    this.icon,
    this.iconRight,
    this.isRaduis = true,
    this.color,
    this.textColor,
    this.isLoading = false,
    this.isBold = true,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor:
          onPressed == null
              ? Theme.of(context).disabledColor
              : transparent
              ? Colors.transparent
              : color ?? Theme.of(context).primaryColor,
      minimumSize: Size(width ?? width!, height != null ? height! : 50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius:
            isRaduis
                ? BorderRadius.circular(radius)
                : BorderRadius.only(
                  bottomLeft: Radius.circular(radius),
                  bottomRight: Radius.circular(radius),
                ),
      ),
    );
    return Center(
      child: SizedBox(
        width: width!.w,
        child: Padding(
          padding: margin == null ? const EdgeInsets.all(0) : margin!,
          child: TextButton(
            onPressed: isLoading ? null : onPressed as void Function()?,
            style: flatButtonStyle,
            child:
                isLoading
                    ? Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                              strokeWidth: 2,
                            ),
                          ),
                          SizedBox(width: Dimensions.paddingSizeSmall.w),
                          Text(
                            'loading',
                            style: robotoMedium.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        icon != null
                            ? Padding(
                              padding: EdgeInsets.only(
                                right: Dimensions.paddingSizeExtraSmall.w,
                              ),
                              child: Icon(
                                icon,
                                color:
                                    transparent
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).cardColor,
                              ),
                            )
                            : const SizedBox(),
                        Text(
                          buttonText,
                          textAlign: TextAlign.center,
                          style:
                              isBold
                                  ? robotoBold.copyWith(
                                    color:
                                        textColor ??
                                        (transparent
                                            ? Theme.of(context).primaryColor
                                            : Colors.white),
                                    fontSize:
                                        fontSize ?? Dimensions.fontSizeLarge.sp,
                                  )
                                  : robotoRegular.copyWith(
                                    color:
                                        textColor ??
                                        (transparent
                                            ? Theme.of(context).primaryColor
                                            : Colors.white),
                                    fontSize:
                                        fontSize ?? Dimensions.fontSizeLarge.sp,
                                  ),
                        ),
                        iconRight != null
                            ? Padding(
                              padding: EdgeInsets.only(
                                left: Dimensions.paddingSizeDefault.w,
                              ),
                              child: Icon(
                                iconRight,
                                color:
                                    transparent
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).cardColor,
                              ),
                            )
                            : const SizedBox(),
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
