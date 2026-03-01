import 'package:get/get.dart';
import 'package:saladappv2_flutter/domain/models/onboarding_model.dart';
import 'package:saladappv2_flutter/domain/repositories/onboarding_repository_interface.dart';
import 'package:saladappv2_flutter/util/app_constants.dart';
import 'package:saladappv2_flutter/util/images.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingRepository implements OnboardingRepositoryInterface {
  final SharedPreferences sharedPreferences;
  OnboardingRepository({required this.sharedPreferences});
  @override
  Future add(value) {
    throw UnimplementedError();
  }

  @override
  Future getData(String? id) {
    throw UnimplementedError();
  }

  @override
  Future getList({int? offSet}) async {
    try {
      List<OnboardingModel> onBoardingList = [
        OnboardingModel(
          'on_boarding_1_description'.tr,
          Images.showLettuce,
          'on_boarding_1_title'.tr,
        ),
        OnboardingModel(
          'on_boarding_2_description'.tr,
          Images.detectionSalad,
          'on_boarding_2_title'.tr,
        ),
        OnboardingModel(
          'on_boarding_3_description'.tr,
          Images.diseaseDetected,
          'on_boarding_3_title'.tr,
        ),
      ];
      Response response = Response(statusCode: 200, body: onBoardingList);
      return response;
    } catch (e) {
      return const Response(
        statusCode: 404,
        statusText: 'Onboarding Not Found',
      );
    }
  }

  @override
  Future<bool> saveOnboardingKey(bool isOnboard) async {
    return await sharedPreferences.setBool(AppConstants.onBoard, isOnboard);
  }

  @override
  bool getOnboardingKey() {
    return sharedPreferences.getBool(AppConstants.onBoard) ?? false;
  }
}
