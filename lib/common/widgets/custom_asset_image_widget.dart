import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAssetImageWidget extends StatelessWidget {
  const CustomAssetImageWidget(
    this.image, {
    super.key,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.color,
  });
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final isSvg = image.contains('.svg', image.length - ".svg".length);
    return isSvg
        ? SvgPicture.asset(
          image,
          width: height,
          height: width,
          fit: fit!,
          colorFilter:
              color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        )
        : Image.asset(
          image,
          width: width,
          height: height,
          fit: fit,
          color: color,
        );
  }
}
