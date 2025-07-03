import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saladappv2_flutter/common/widgets/custom_assets_image_widget.dart';
import 'package:saladappv2_flutter/util/images.dart';
import 'package:saladappv2_flutter/util/style.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    super.key,
    this.controller,
    required this.title,
    this.fillColor,
    this.titleStyle,
    this.iconColor,
    this.onChanged,
    this.onSubmit,
  });

  final TextEditingController? controller;
  final String? title;
  final Color? fillColor;
  final TextStyle? titleStyle;
  final Color? iconColor;
  final Function? onSubmit;
  final Function? onChanged;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      textInputAction: TextInputAction.search,
      inputFormatters: [
        FilteringTextInputFormatter.deny(
          RegExp(r'[!@#$%^&*(),.?":{}|<>_+-/~`•√π÷×§∆£¢€¥°=©®™✓;]'),
        ),
      ],
      decoration: InputDecoration(
        hintText: widget.title,
        hintStyle: widget.titleStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: widget.fillColor,
        isDense: true,
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 5.w),
          child: Padding(
            padding: EdgeInsets.all(5.w),
            child: Transform.scale(
              scaleX: -1,
              child: CustomAssetImageWidget(
                Images.search,
                fit: BoxFit.contain,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
      onSubmitted: widget.onSubmit as void Function(String)?,
      onChanged: widget.onChanged as void Function(String)?,
    );
  }
}
