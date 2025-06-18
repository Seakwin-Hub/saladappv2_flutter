import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:saladappv2_flutter/common/controller/theme_controller.dart';
import 'package:saladappv2_flutter/features/onboard/controller/onboarding_controller.dart';
import 'package:saladappv2_flutter/helper/device_util.dart';
import 'package:saladappv2_flutter/helper/router_helper.dart';
import 'package:saladappv2_flutter/util/dimensions.dart';
import 'package:saladappv2_flutter/util/style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  @override
  void initState() {
    super.initState();
    Get.find<OnboardingController>().getOnboardingList();
  }

  @override
  Widget build(BuildContext context) {
    bool getTheme = Get.find<ThemeController>().darkTheme;
    return Scaffold(
      backgroundColor: getTheme ? AppColors.black : Colors.white,
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<OnboardingController>(
              builder: (onboardingController) {
                bool getOnboardingSize =
                    onboardingController.seletecIndex <
                    onboardingController.onboardingList.length - 1;
                return onboardingController.onboardingList.isNotEmpty
                    ? Stack(
                      children: [
                        PageView.builder(
                          itemCount: onboardingController.onboardingList.length,
                          controller: _controller,
                          onPageChanged: (index) {
                            onboardingController.changeSeletedIndex(index);
                            if (onboardingController.seletecIndex == 3) {
                              Get.offNamed(RouterHelper.getDashboardScreen());
                            }
                          },
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(
                                Dimensions.fontSizeOverLarge.w,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  getOnboardingSize &&
                                          onboardingController
                                                  .onboardingList[index]
                                                  .imageUrl !=
                                              ''
                                      ? Lottie.asset(
                                        onboardingController
                                            .onboardingList[index]
                                            .imageUrl,
                                        width: index == 2 ? 200.w : 350.w,
                                        fit: BoxFit.fill,
                                      )
                                      : SizedBox(),
                                  SizedBox(height: index == 1 ? 50.h : 0.h),
                                  Text(
                                    onboardingController
                                        .onboardingList[index]
                                        .title,
                                    style: robotoBold.copyWith(
                                      fontSize:
                                          Dimensions.fontSizeExtraLarge.sp,
                                      color:
                                          getTheme
                                              ? AppColors.green
                                              : AppColors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 20.h),
                                  Text(
                                    onboardingController
                                        .onboardingList[index]
                                        .description,
                                    style: robotoMedium.copyWith(
                                      color:
                                          getTheme
                                              ? AppColors.white
                                              : AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Positioned(
                          right: Dimensions.paddingSizeDefault.w,
                          top: DeviceUtils.getAppBarHeight(),
                          child: TextButton(
                            onPressed: () {
                              _controller.jumpToPage(2);
                            },
                            child:
                                onboardingController.seletecIndex >= 2
                                    ? SizedBox()
                                    : Text(
                                      'skip'.tr,
                                      style: robotoRegular.copyWith(
                                        fontSize: Dimensions.fontSizeLarge.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.green,
                                      ),
                                    ),
                          ),
                        ),

                        Positioned(
                          bottom:
                              DeviceUtils.getBottomNavigationBarHeight() + 25.w,
                          left: Dimensions.paddingSizeDefault.w,
                          child: SmoothPageIndicator(
                            controller: _controller,
                            count:
                                onboardingController.onboardingList.length - 1,
                            effect: ExpandingDotsEffect(
                              activeDotColor:
                                  getTheme ? AppColors.light : AppColors.dark,
                              dotHeight: 8,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom:
                              DeviceUtils.getBottomNavigationBarHeight() + 10.w,
                          right: Dimensions.paddingSizeDefault.w,
                          child: ElevatedButton(
                            onPressed: () {
                              if (onboardingController.seletecIndex != 2) {
                                _controller.nextPage(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.ease,
                                );
                              } else {
                                Get.offNamed(RouterHelper.getDashboardScreen());
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              side: BorderSide(color: Colors.transparent),
                              backgroundColor: AppColors.green,
                            ),
                            child: Icon(Iconsax.arrow_right_3),
                          ),
                        ),
                      ],
                    )
                    : SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
