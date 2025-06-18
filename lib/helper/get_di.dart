import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saladappv2_flutter/common/controller/theme_controller.dart';
import 'package:saladappv2_flutter/features/localization/domain/models/language_model.dart';
import 'package:saladappv2_flutter/features/onboard/controller/onboarding_controller.dart';
import 'package:saladappv2_flutter/features/onboard/domain/repositories/onboarding_repository.dart';
import 'package:saladappv2_flutter/features/onboard/domain/repositories/onboarding_repository_interface.dart';
import 'package:saladappv2_flutter/features/onboard/domain/services/onboarding_service.dart';
import 'package:saladappv2_flutter/features/onboard/domain/services/onboarding_service_interface.dart';
import 'package:saladappv2_flutter/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, Map<String, String>>> init() async {
  ///Core
  final sharedPreference = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreference);

  ///Repository Interface
  OnboardingRepositoryInterface onboardingRepositoryInterface =
      OnboardingRepository();
  Get.lazyPut(() => onboardingRepositoryInterface);

  ///Service Interface
  OnboardingServiceInterface onboardingServiceInterface = OnboardingService(
    onboardingRepositoryInterface: Get.find(),
  );
  Get.lazyPut(() => onboardingServiceInterface);

  ///Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(
    () => OnboardingController(onboardingServiceInterface: Get.find()),
  );

  /// Retrieving localized data
  Map<String, Map<String, String>> languages = {};
  for (LanguageModel languageModel in AppConstants.language) {
    String jsonStringValue = await rootBundle.loadString(
      "assets/language/${languageModel.languageCode}.json",
    );
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValue);
    Map<String, String> json = {};
    mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        json;
  }
  return languages;
}
