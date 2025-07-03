import 'package:flutter/material.dart';
import 'package:saladappv2_flutter/common/widgets/custom_asset_image_widget.dart';
import 'package:saladappv2_flutter/util/style.dart';

class BottomNavWidget extends StatelessWidget {
  final String buttonIcon;
  final String title;
  final Function? onTap;
  final bool isSelected;
  final double? iconSize;
  final double? textSize;
  final bool isCamera;
  final Color? isDark;

  const BottomNavWidget({
    super.key,
    this.onTap,
    this.iconSize,
    this.isCamera = false,
    this.textSize,
    this.isSelected = false,
    this.isDark,
    required this.title,
    required this.buttonIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap as void Function()?,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomAssetImageWidget(
              buttonIcon,
              width: iconSize,
              height: iconSize,
              fit: BoxFit.contain,
              color: isSelected ? isDark : Colors.black.withValues(alpha: 0.75),
            ),
            SizedBox(height: isCamera ? 0 : 6),
            Text(
              title,
              style: robotoRegular.copyWith(
                fontSize: textSize,
                color:
                    isSelected ? isDark : Colors.black.withValues(alpha: 0.75),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
