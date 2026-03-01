import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBoxWidget extends StatelessWidget {
  const CustomBoxWidget({super.key, this.sizeOfSpace = 15, this.color});
  final double sizeOfSpace;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: sizeOfSpace.h,
                right: sizeOfSpace.w,
              ),
              child: sideBoxWidget(index: 0),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: sizeOfSpace.h,
                left: sizeOfSpace.w,
              ),
              child: sideBoxWidget(index: 2),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: sizeOfSpace.h,
                right: sizeOfSpace.w,
              ),
              child: sideBoxWidget(index: 1),
            ),
            Padding(
              padding: EdgeInsets.only(top: sizeOfSpace.h, left: sizeOfSpace.w),
              child: sideBoxWidget(index: 3),
            ),
          ],
        ),
      ],
    );
  }

  Widget sideBoxWidget({int index = 0}) {
    return Container(
      width: 50.w,
      height: 50.h,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: color!,
            width: index == 0 || index == 2 ? 1 : 0,
            style:
                index == 1 || index == 3 ? BorderStyle.none : BorderStyle.solid,
          ),
          left: BorderSide(
            color: color!,
            width: index == 0 || index == 1 ? 1 : 0,
            style:
                index == 2 || index == 3 ? BorderStyle.none : BorderStyle.solid,
          ),
          right: BorderSide(
            color: color!,
            width: index == 2 || index == 3 ? 1 : 0,
            style:
                index == 0 || index == 1 ? BorderStyle.none : BorderStyle.solid,
          ),
          bottom: BorderSide(
            color: color!,
            width: index == 1 || index == 3 ? 1 : 0,
            style:
                index == 0 || index == 2 ? BorderStyle.none : BorderStyle.solid,
          ),
        ),
      ),
    );
  }
}
