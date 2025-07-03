import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saladappv2_flutter/helper/get_di.dart' as di;
import 'package:saladappv2_flutter/helper/router_helper.dart';
import 'package:saladappv2_flutter/util/app_constants.dart';
import 'package:saladappv2_flutter/common/model/message.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<String, Map<String, String>> languages = await di.init();

  runApp(MyApp(languages: languages));
}

class MyApp extends StatefulWidget {
  final Map<String, Map<String, String>>? languages;
  const MyApp({super.key, required this.languages});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: Size(390, 844),
      builder: (context, child) {
        return GetMaterialApp(
          title: AppConstants.appName,
          translations: Message(languages: widget.languages),
          locale: Locale(
            AppConstants.language[0].languageCode!,
            AppConstants.language[0].countryCode,
          ),
          fallbackLocale: Locale(
            AppConstants.language[0].languageCode!,
            AppConstants.language[0].countryCode,
          ),
          debugShowCheckedModeBanner: false,
          navigatorKey: Get.key,
          initialRoute: RouterHelper.onboard,
          defaultTransition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 200),
          getPages: RouterHelper.routes,
        );
      },
    );
  }
}
