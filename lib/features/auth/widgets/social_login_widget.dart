import 'package:flutter/material.dart';
import 'package:saladappv2_flutter/util/style.dart';

class SocialLoginWidget extends StatelessWidget {
  final String socialLogo;
  final double sizeImage;
  const SocialLoginWidget(this.socialLogo, this.sizeImage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.buttonPrimary.withValues(alpha: 0),
        border: Border.all(width: 0.03, style: BorderStyle.solid),
      ),
      child: InkWell(
        onTap: () {},
        child: Image.asset(socialLogo, width: sizeImage),
      ),
    );
  }
}
