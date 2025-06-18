import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DeviceUtils {
  ///This code hides the keyboard When nothing is focused
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  ///This function changes the status bar color on your device (the top bar with battery, time, signal, etc.).
  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color),
    );
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static bool isLandscapeOrientation(BuildContext context) {
    /// detect if the device is in landscape orientation,
    return MediaQuery.of(context).orientation == Orientation.landscape;

    ///detect if the device is in landscape orientation, based on the keyboard visibility
    // final viewInsets = View.of(context).viewInsets;
    // return viewInsets.bottom == 0;
  }

  static bool isPortraitOrientation(BuildContext context) {
    /// detect if the device is in portrait orientation,
    return MediaQuery.of(context).orientation == Orientation.portrait;

    ///detect if the device is in portrait orientation, based on the keyboard visibility

    // final viewInsets = View.of(context).viewInsets;
    // return viewInsets.bottom != 0;
  }

  static void setFullScreen(bool enable) {
    SystemChrome.setEnabledSystemUIMode(
      //immersiveSticky hides system UI like the status bar and navigation bar — great for videos/games.
      //edgeToEdge shows system UI (normal mode).
      enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge,
    );
  }

  static double getScreenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getPixelRatio() {
    return MediaQuery.of(Get.context!).devicePixelRatio;
  }

  static double getStatusBarHeight() {
    return MediaQuery.of(Get.context!).padding.top;
  }

  // This returns the standard height for the bottom navigation bar in Flutter.
  static double getBottomNavigationBarHeight() {
    return kBottomNavigationBarHeight;
  }

  // This returns the height of the AppBar (toolbar), which is a standard height in Flutter.
  static double getAppBarHeight() {
    return kToolbarHeight;
  }

  // This retrieves the height of the on-screen keyboard.
  static double getKeyboardHeight() {
    final viewInsets = MediaQuery.of(Get.context!).viewInsets;
    // Height of keyboard
    return viewInsets.bottom;
  }

  static Future<bool> isKeyboardVisible() async {
    final viewInsets = View.of(Get.context!).viewInsets;
    return viewInsets.bottom > 0;
  }

  // This checks if the app is running on a real physical device (as opposed to an emulator or simulator).
  static Future<bool> isPhysicalDevice() async {
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  // This triggers device vibration twice — once immediately, and once again after a given duration.
  static void vibrate(Duration duration) {
    HapticFeedback.vibrate();
    Future.delayed(duration, () => HapticFeedback.vibrate());
  }

  // Locks the app to specific screen orientations
  static Future<void> setPreferredOrientations(
    List<DeviceOrientation> orientations,
  ) async {
    await SystemChrome.setPreferredOrientations(orientations);
  }

  // Hides the status bar (battery, time, signal, etc.)
  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  // Shows  the status bar (battery, time, signal, etc.)
  static void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  // Checks whether the device is connected to the internet by trying to resolve example.com.
  //This is a basic check. For more robust handling, use plugins like connectivity_plus instead.
  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  // Checks which platform (iOS) the app is running on.
  static bool isIOS() {
    return Platform.isIOS;
  }

  // Checks which platform (Android) the app is running on.
  static bool isAndroid() {
    return Platform.isAndroid;
  }
}
