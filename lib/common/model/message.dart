import 'package:get/get.dart';

class Message extends Translations {
  final Map<String, Map<String, String>>? languages;
  Message({required this.languages});

  @override
  Map<String, Map<String, String>> get keys {
    return languages!;
  }
}
