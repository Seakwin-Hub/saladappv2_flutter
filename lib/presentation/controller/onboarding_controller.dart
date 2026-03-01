import 'package:get/get.dart';
import 'package:saladappv2_flutter/domain/models/onboarding_model.dart';
import 'package:saladappv2_flutter/domain/repositories/onboarding_repository_interface.dart';

class OnboardingController extends GetxController implements GetxService {
  final OnboardingRepositoryInterface onboardingRepositoryInterface;
  OnboardingController({required this.onboardingRepositoryInterface});

  List<OnboardingModel> _onboardingList = [];
  List<OnboardingModel> get onboardingList => _onboardingList;

  int _seletedIndex = 0;
  int get seletecIndex => _seletedIndex;

  void changeSeletedIndex(int index) {
    _seletedIndex = index;
    update();
  }

  void getOnboardingList() async {
    Response response = await onboardingRepositoryInterface.getList();
    if (response.statusCode == 200) {
      _onboardingList = [];
      _onboardingList.addAll(response.body);
      _onboardingList.add(OnboardingModel('', '', ''));
    }
    update();
  }

  Future<bool> saveOnboardingKey(bool isOnboard) async {
    return await onboardingRepositoryInterface.saveOnboardingKey(isOnboard);
  }

  bool getOnboardingKey() {
    return onboardingRepositoryInterface.getOnboardingKey();
  }
}
