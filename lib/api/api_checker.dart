import 'package:get/get.dart';
import 'package:saladappv2_flutter/common/widgets/custom_snackbar.dart';

class ApiChecker {
  static void checkApi(Response response, {bool getXSnackbar = false}) {
    if (response.statusCode == 401) {
      //If Server response Unauthorize or Invalid Credential
    } else {
      showCustomSnackBar(response.statusText, getXSnackBar: getXSnackbar);
    }
  }
}
