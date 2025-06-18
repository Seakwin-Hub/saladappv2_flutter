import 'package:get/get_connect/http/src/response/response.dart';
import 'package:saladappv2_flutter/features/onboard/domain/repositories/onboarding_repository_interface.dart';
import 'package:saladappv2_flutter/features/onboard/domain/services/onboarding_service_interface.dart';

class OnboardingService implements OnboardingServiceInterface {
  final OnboardingRepositoryInterface onboardingRepositoryInterface;
  OnboardingService({required this.onboardingRepositoryInterface});
  @override
  Future<Response> getOnboardingList() async {
    return await onboardingRepositoryInterface.getList();
  }
}
