import 'package:flutter/material.dart';
import 'package:saladappv2_flutter/util/style.dart';

class BottomNavWidget extends StatelessWidget {
  final IconData buttonIcon;
  final String title;
  final Function? onTap;
  final bool isSelected;
  final double? iconSize;
  final double? textSize;

  const BottomNavWidget({
    super.key,
    this.onTap,
    this.iconSize,
    this.textSize,
    this.isSelected = false,
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
            Icon(
              buttonIcon,
              size: iconSize,
              color: isSelected ? Colors.green : Colors.black,
            ),
            Text(
              title,
              style: robotoRegular.copyWith(
                fontSize: textSize,
                color: isSelected ? Colors.green : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
