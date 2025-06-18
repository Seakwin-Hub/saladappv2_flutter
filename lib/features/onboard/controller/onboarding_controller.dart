import 'package:get/get.dart';
import 'package:saladappv2_flutter/features/onboard/domain/models/onboarding_model.dart';
import 'package:saladappv2_flutter/features/onboard/domain/services/onboarding_service_interface.dart';

class OnboardingController extends GetxController implements GetxService {
  final OnboardingServiceInterface onboardingServiceInterface;
  OnboardingController({required this.onboardingServiceInterface});

  List<OnboardingModel> _onboardingList = [];
  List<OnboardingModel> get onboardingList => _onboardingList;

  int _seletedIndex = 0;
  int get seletecIndex => _seletedIndex;

  void changeSeletedIndex(int index) {
    _seletedIndex = index;
    update();
  }

  void getOnboardingList() async {
    Response response = await onboardingServiceInterface.getOnboardingList();
    if (response.statusCode == 200) {
      _onboardingList = [];
      _onboardingList.addAll(response.body);
      _onboardingList.add(OnboardingModel('', '', ''));
    }
    update();
  }
}
