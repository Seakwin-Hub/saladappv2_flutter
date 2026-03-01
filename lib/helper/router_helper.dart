import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saladappv2_flutter/common/widgets/web_error_screen.dart';
import 'package:saladappv2_flutter/domain/models/disease_list_model.dart';
import 'package:saladappv2_flutter/domain/models/salad_list_model.dart';
import 'package:saladappv2_flutter/helper/responsive_helper.dart';
import 'package:saladappv2_flutter/presentation/controller/onboarding_controller.dart';
import 'package:saladappv2_flutter/presentation/screens/camera_screen.dart';
import 'package:saladappv2_flutter/presentation/screens/dashboard_screen.dart';
import 'package:saladappv2_flutter/presentation/screens/disease_screen.dart';
import 'package:saladappv2_flutter/presentation/screens/home_screen.dart';
import 'package:saladappv2_flutter/presentation/screens/item_detail_screen.dart';
import 'package:saladappv2_flutter/presentation/screens/onboarding_screen.dart';
import 'package:saladappv2_flutter/presentation/screens/profile_screen.dart';
import 'package:saladappv2_flutter/presentation/screens/salad_screen.dart';

class RouterHelper {
  static const initial = "/";
  static const String language = '/language';
  static const String onboard = '/onboard';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String dashboard = '/dashboard';
  static const String homeScreen = '/home';
  static const String diseaseScreen = '/disease';
  static const String saladScreen = '/salad';
  static const String profile = '/profile';
  static const String cameraScreen = '/camera';
  static const String main = '/main';
  static const String itemDetail = '/item-detail';

  static String getInitialRoute({bool fromOnBoard = false}) =>
      '$initial?from-onboard=$fromOnBoard';
  // static String getLanguageRoute(String page) => '$language?page=$page';

  static String getOnboardingScreen() => onboard;
  static String getMainRoute(String page) => '$main?page=$page';
  static String getItemDetailsRoute(int? itemID, bool isSalad) =>
      '$itemDetail?id=$itemID&check=$isSalad';
  static String getSignInScreen() => signIn;
  static String getSignUpScreen() => signUp;
  static String getHomeScreen() => homeScreen;
  static String getDiseaseScreen() => diseaseScreen;
  static String getSaladScreen() => saladScreen;
  static String getProfileScreen() => profile;
  static String getCameraScreen() => cameraScreen;

  static List<GetPage> routes = [
    GetPage(
      name: initial,
      page: () => getRoute(
        DashboardScreen(
          pageIndex: 0,
          fromOnBoard: Get.parameters['from-onboard'] == 'true',
        ),
      ),
    ),
    GetPage(
      name: itemDetail,
      page: () => getRoute(
        Get.arguments ??
            ItemDetailScreen(
              isSalad: Get.parameters['check'] == 'true',
              itemDisease: DiseaseModel(
                diseaseId: int.parse(Get.parameters['id']!),
              ),
              itemSalad: SaladModel(
                saladId: int.parse(Get.parameters['id']!),
              ),
            ),
      ),
    ),
    GetPage(name: onboard, page: () => OnboardingScreen()),
    GetPage(name: homeScreen, page: () => HomeScreen()),
    GetPage(name: diseaseScreen, page: () => DiseaseScreen()),
    GetPage(name: saladScreen, page: () => SaladScreen()),
    GetPage(name: profile, page: () => ProfileScreen()),
    GetPage(name: cameraScreen, page: () => CameraScreen()),
    GetPage(
      name: main,
      page: () => getRoute(
        DashboardScreen(
          pageIndex: Get.parameters['page'] == 'home'
              ? 0
              : Get.parameters['page'] == 'salad'
                  ? 1
                  : Get.parameters['page'] == 'camera'
                      ? 2
                      : Get.parameters['page'] == 'disease'
                          ? 3
                          : Get.parameters['page'] == 'profile'
                              ? 4
                              : 0,
        ),
      ),
    ),
  ];

  ///It will check when the app first runiing did it show go to onboarding(first time) or other screen
  static Widget getRoute(Widget navigateTo) {
    return ResponsiveHelper.isWeb()
        ? WebErrorScreen()
        : Get.find<OnboardingController>().getOnboardingKey() == false
            ? OnboardingScreen()
            : navigateTo;
  }
}
