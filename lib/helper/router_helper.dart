import 'package:get/get.dart';
import 'package:saladappv2_flutter/features/auth/screens/sign_in_screen.dart';
import 'package:saladappv2_flutter/features/auth/screens/sign_up_screen.dart';
import 'package:saladappv2_flutter/features/camera/screens/camera_screen.dart';
import 'package:saladappv2_flutter/features/dashboard/screens/dashboard_screen.dart';
import 'package:saladappv2_flutter/features/disease/screens/disease_screen.dart';
import 'package:saladappv2_flutter/features/home/screens/home_screen.dart';
import 'package:saladappv2_flutter/features/onboard/screens/onboarding_screen.dart';
import 'package:saladappv2_flutter/features/profile/screens/profile_screen.dart';
import 'package:saladappv2_flutter/features/salad/screens/salad_screen.dart';

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

  // static String getInitialRoute => InitialScreen();
  // static String getLanguageRoute(String page) => '$language?page=$page';

  static String getOnboardingScreen() => onboard;
  static String getMainRoute(String page) => '$main?page=$page';
  static String getSignInScreen() => signIn;
  static String getSignUpScreen() => signUp;
  static String getHomeScreen() => homeScreen;
  static String getDiseaseScreen() => diseaseScreen;
  static String getSaladScreen() => saladScreen;
  static String getProfileScreen() => profile;
  static String getCameraScreen() => cameraScreen;

  static String getDashboardScreen({bool fromSplash = true}) =>
      '$dashboard?from-splash=$fromSplash';

  static List<GetPage> routes = [
    GetPage(name: onboard, page: () => OnboardingScreen()),
    GetPage(name: signIn, page: () => SignInScreen()),
    GetPage(name: homeScreen, page: () => HomeScreen()),
    GetPage(name: diseaseScreen, page: () => DiseaseScreen()),
    GetPage(name: saladScreen, page: () => SaladScreen()),
    GetPage(name: profile, page: () => ProfileScreen()),
    GetPage(name: cameraScreen, page: () => CameraScreen()),
    GetPage(name: signUp, page: () => SignUpScreen()),
    GetPage(
      name: main,
      page:
          () => DashboardScreen(
            pageIndex:
                Get.parameters['page'] == 'home'
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
    GetPage(
      name: dashboard,
      page:
          () => DashboardScreen(
            pageIndex: 0,
            fromSplash: Get.parameters['from-splash'] == 'true',
          ),
    ),

    // GetPage(name: initial, page: () => getInitailRoute());
    // GetPage(
    //     name: language,
    //     page: () =>
    //         ChooseLanguageScreen(fromMenu: Get.parameters['page'] == 'menu')),
  ];
}
