import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saladappv2_flutter/common/controller/theme_controller.dart';
import 'package:saladappv2_flutter/common/widgets/custom_button.dart';
import 'package:saladappv2_flutter/common/widgets/custom_textfield.dart';
import 'package:saladappv2_flutter/features/auth/widgets/social_login_widget.dart';
import 'package:saladappv2_flutter/helper/device_util.dart';
import 'package:saladappv2_flutter/helper/router_helper.dart';
import 'package:saladappv2_flutter/util/dimensions.dart';
import 'package:saladappv2_flutter/util/images.dart';
import 'package:saladappv2_flutter/util/style.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _userFucus = FocusNode();
  final FocusNode _passFocus = FocusNode();
  final bool getTheme = Get.find<ThemeController>().darkTheme;

  GlobalKey<FormState>? _formKeySignUp;
  @override
  void initState() {
    _formKeySignUp = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.h,
        backgroundColor: getTheme ? AppColors.black : AppColors.greenDark,
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: ClampingScrollPhysics(),
        child: Container(
          color: getTheme ? AppColors.black : AppColors.greenDark,
          child: Column(
            children: [
              Container(
                color: getTheme ? AppColors.black : AppColors.greenDark,
                padding: EdgeInsets.symmetric(vertical: 70.h),
                child: Center(
                  child: Image.asset(
                    Images.logo,
                    width: 150.w,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault.w,
                ),
                decoration: BoxDecoration(
                  color: getTheme ? AppColors.darkerGrey : AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radiusLarge.r + 15.r),
                    topRight: Radius.circular(Dimensions.radiusLarge.r + 15.r),
                  ),
                ),
                child: Form(
                  key: _formKeySignUp,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 25.h),
                      Text(
                        "login".tr,
                        style: robotoBold.copyWith(
                          color: getTheme ? AppColors.white : AppColors.blue,
                          fontSize: Dimensions.fontSizeExtraLarge.sp + 5.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "welcome".tr,
                        style: robotoRegular.copyWith(
                          color: AppColors.darkGrey.withValues(alpha: 0.6),
                          fontSize: Dimensions.fontSizeSmall.sp,
                        ),
                      ),

                      SizedBox(height: 20.h),

                      CustomTextField(
                        labelText: "user_text".tr,
                        required: true,
                        focusNode: _userFucus,
                        nextFocus: _passFocus,
                        controller: _usernameController,
                        inputType: TextInputType.name,
                        capitalization: TextCapitalization.words,
                        labelTextSize: Dimensions.fontSizeDefault.sp,
                      ),
                      SizedBox(height: 20.h),
                      CustomTextField(
                        labelText: "pass_text".tr,
                        focusNode: _passFocus,
                        isPassword: true,
                        required: true,
                        controller: _passwordController,
                        inputType: TextInputType.name,
                        capitalization: TextCapitalization.words,
                      ),
                      SizedBox(height: 20.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "forget_pass".tr,
                          style: robotoRegular.copyWith(
                            color: AppColors.darkGrey.withValues(alpha: 0.6),
                            fontSize: Dimensions.fontSizeSmall.sp,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      CustomButton(
                        buttonText: "login".tr,
                        color: getTheme ? AppColors.black : AppColors.green,
                        onPressed: () {},
                        width: DeviceUtils.getScreenWidth(context),
                      ),
                      SizedBox(height: 20.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Divider()),
                          Text(
                            "or_sign_with".tr,
                            style: robotoRegular.copyWith(
                              color: AppColors.darkGrey.withValues(alpha: 0.8),
                              fontSize: Dimensions.fontSizeSmall.sp,
                            ),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),

                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialLoginWidget(Images.google, 35.w),
                          SizedBox(width: 20.w),
                          SocialLoginWidget(Images.facebook, 38.w),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "do_not_have_account".tr,
                            style: robotoRegular.copyWith(
                              color: AppColors.darkGrey.withValues(alpha: 0.6),
                              fontSize: Dimensions.fontSizeSmall.sp,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(RouterHelper.getSignUpScreen());
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeSmall.w,
                              ),
                              child: Text(
                                "sign_up".tr,
                                style: robotoBold.copyWith(
                                  color:
                                      getTheme
                                          ? AppColors.white
                                          : AppColors.black.withValues(
                                            alpha: 0.5,
                                          ),
                                  fontSize: Dimensions.fontSizeSmall.sp,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
