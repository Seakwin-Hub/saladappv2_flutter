import 'package:saladappv2_flutter/domain/models/language_model.dart';
import 'package:saladappv2_flutter/util/images.dart';

class AppConstants {
  static const double appVersion = 1.0;
  static const String fontFamily = "Battambang";

  ///Shared Key
  static const String appName = "Salad Detection";
  static const String baseUrl = 'http://10.0.2.2:5000';
  static const String diseaseListUri = '/diseaselist';
  static const String diseaseByIdUri = '/disease';
  static const String saladListUri = '/saladlist';
  static const String saladByIdUri = '/saladtype';
  static const String imageUpload = '/imageupload';

  static const String theme = "theme";
  static const String languageCode = 'your_language_code';
  static const String onBoard = "onboard";

  ///Language
  static List<LanguageModel> language = [
    LanguageModel(
      imageUrl: Images.english,
      languageName: "English",
      countryCode: "US",
      languageCode: "en",
    ),
    LanguageModel(
      imageUrl: Images.khmer,
      languageName: "Khmer",
      countryCode: "KH",
      languageCode: "km",
    ),
  ];
}
