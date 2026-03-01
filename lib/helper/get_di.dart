import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saladappv2_flutter/api/api_client.dart';
import 'package:saladappv2_flutter/common/controller/theme_controller.dart';
import 'package:saladappv2_flutter/domain/repositories/camera_repository.dart';
import 'package:saladappv2_flutter/domain/repositories/camera_repository_interface.dart';
import 'package:saladappv2_flutter/presentation/controller/camera_controller.dart';
import 'package:saladappv2_flutter/presentation/controller/dashboard_controller.dart';
import 'package:saladappv2_flutter/domain/repositories/disease_repository.dart';
import 'package:saladappv2_flutter/domain/repositories/disease_repository_interface.dart';
import 'package:saladappv2_flutter/domain/models/language_model.dart';
import 'package:saladappv2_flutter/presentation/controller/disease_controller.dart';
import 'package:saladappv2_flutter/presentation/controller/home_controller.dart';
import 'package:saladappv2_flutter/presentation/controller/item_detail_controller.dart';
import 'package:saladappv2_flutter/presentation/controller/onboarding_controller.dart';
import 'package:saladappv2_flutter/domain/repositories/onboarding_repository.dart';
import 'package:saladappv2_flutter/domain/repositories/onboarding_repository_interface.dart';
import 'package:saladappv2_flutter/presentation/controller/salad_controller.dart';
import 'package:saladappv2_flutter/domain/repositories/salad_repository.dart';
import 'package:saladappv2_flutter/domain/repositories/salad_repository_interface.dart';
import 'package:saladappv2_flutter/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, Map<String, String>>> init() async {
  ///Core
  final sharedPreference = await SharedPreferences.getInstance();
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl));
  Get.lazyPut(() => sharedPreference);

  ///Repository Interface
  OnboardingRepositoryInterface onboardingRepositoryInterface =
      OnboardingRepository(sharedPreferences: Get.find());
  Get.lazyPut(() => onboardingRepositoryInterface);
  SaladRepositoryInterface saladRepositoryInterface = SaladRepository(
    apiClient: Get.find(),
  );
  Get.lazyPut(() => saladRepositoryInterface);
  DiseaseRepositoryInterface diseaseRepositoryInterface = DiseaseRepository(
    apiClient: Get.find(),
  );
  Get.lazyPut(() => diseaseRepositoryInterface);
  CameraRepositoryInterface cameraRepositoryInterface =
      CameraRepository(apiClient: Get.find());
  Get.lazyPut(() => cameraRepositoryInterface);

  ///Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(
    () => OnboardingController(onboardingRepositoryInterface: Get.find()),
  );
  Get.lazyPut(() => SaladController(saladRepositoryInterface: Get.find()));
  Get.lazyPut(() => DiseaseController(diseaseRepositoryInterface: Get.find()));
  Get.lazyPut(() => CameraController(cameraRepositoryInterface: Get.find()));
  Get.lazyPut(() => DashboardController());
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => ItemDetailController());

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
