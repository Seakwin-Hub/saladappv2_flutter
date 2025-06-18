import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saladappv2_flutter/common/controller/theme_controller.dart';
import 'package:saladappv2_flutter/common/widgets/custom_appbar.dart';
import 'package:saladappv2_flutter/common/widgets/custom_button.dart';
import 'package:saladappv2_flutter/common/widgets/custom_textfield.dart';
import 'package:saladappv2_flutter/features/auth/widgets/social_login_widget.dart';
import 'package:saladappv2_flutter/helper/device_util.dart';
import 'package:saladappv2_flutter/helper/router_helper.dart';
import 'package:saladappv2_flutter/util/dimensions.dart';
import 'package:saladappv2_flutter/util/images.dart';
import 'package:saladappv2_flutter/util/style.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _userFucus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();
  String? _countryDialCode;
  final bool getTheme = Get.find<ThemeController>().darkTheme;

  GlobalKey<FormState>? _formKeySignUp;
  @override
  void initState() {
    super.initState();
    _formKeySignUp = GlobalKey<FormState>();
    _countryDialCode = CountryCode.fromCountryCode("KH").dialCode!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        color: AppColors.white,
        title: "",
        backButton: true,
        checkTheme: getTheme,
        isSignUp: true,
      ),

      body: Container(
        decoration: BoxDecoration(
          color: getTheme ? AppColors.black : AppColors.greenDark,
        ),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: ClampingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(Images.logo, width: 105.w, fit: BoxFit.contain),
              SizedBox(height: 18.h),
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
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom,
                  ),
                  child: Form(
                    key: _formKeySignUp,
                    child: Column(
                      children: [
                        SizedBox(height: 25.h),
                        Text(
                          "sign_up".tr,
                          style: robotoBold.copyWith(
                            color: getTheme ? AppColors.white : AppColors.blue,
                            fontSize: Dimensions.fontSizeExtraLarge.sp + 5.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "create_new_info".tr,
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
                          nextFocus: _phoneFocus,
                          controller: _usernameController,
                          inputType: TextInputType.name,
                          capitalization: TextCapitalization.words,
                          labelTextSize: Dimensions.fontSizeDefault.sp,
                        ),
                        SizedBox(height: 20.h),
                        CustomTextField(
                          labelText: "phone".tr,
                          isPhone: true,
                          required: true,
                          focusNode: _phoneFocus,
                          nextFocus: _emailFocus,
                          controller: _phoneController,
                          inputType: TextInputType.phone,
                          labelTextSize: Dimensions.fontSizeDefault.sp,
                          onCountryChanged: (CountryCode countryCode) {
                            _countryDialCode = countryCode.dialCode!;
                          },
                          countryDialCode: _countryDialCode,
                        ),
                        SizedBox(height: 20.h),
                        CustomTextField(
                          labelText: "email".tr,
                          required: true,
                          focusNode: _emailFocus,
                          nextFocus: _passFocus,
                          controller: _emailController,
                          inputType: TextInputType.emailAddress,
                          labelTextSize: Dimensions.fontSizeDefault.sp,
                        ),
                        SizedBox(height: 20.h),
                        CustomTextField(
                          labelText: "pass_text".tr,
                          focusNode: _passFocus,
                          isPassword: true,
                          required: true,
                          controller: _passwordController,
                          inputType: TextInputType.visiblePassword,
                        ),
                        SizedBox(height: 20.h),

                        CustomButton(
                          buttonText: "sign_up".tr,
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
                                color: AppColors.darkGrey.withValues(
                                  alpha: 0.6,
                                ),
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
                              "already_have_account".tr,
                              style: robotoRegular.copyWith(
                                color: AppColors.darkGrey.withValues(
                                  alpha: 0.6,
                                ),
                                fontSize: Dimensions.fontSizeSmall.sp,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.offAndToNamed(
                                  RouterHelper.getSignInScreen(),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeSmall.w,
                                ),
                                child: Text(
                                  "login".tr,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
