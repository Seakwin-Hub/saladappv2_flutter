import 'package:saladappv2_flutter/features/localization/domain/models/language_model.dart';
import 'package:saladappv2_flutter/util/images.dart';

class AppConstants {
  static const double appVersion = 1.0;
  static const String fontFamily = "Roboto";

  ///Shared Key
  static const String appName = "Your App Name";
  static const String apiKey = 'eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0';
  static const String baseUrl = 'https://your-api-url.com';
  static const String theme = "theme";
  static const String token = "app_token";
  static const String localizationKey = 'X-localization';
  static const String languageCode = 'your_language_code';

  ///Language
  static List<LanguageModel> language = [
    LanguageModel(
      imageUrl: Images.english,
      languageName: "English",
      countryCode: "US",
      languageCode: "en",
    ),
  ];
}
