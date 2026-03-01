import 'package:get/get.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:saladappv2_flutter/api/api_client.dart';
import 'package:saladappv2_flutter/domain/models/detect_image_model.dart';
import 'package:saladappv2_flutter/domain/repositories/camera_repository_interface.dart';
import 'package:saladappv2_flutter/util/app_constants.dart';

class CameraRepository implements CameraRepositoryInterface {
  final ApiClient apiClient;
  CameraRepository({required this.apiClient});
  @override
  Future add(value) {
    throw UnimplementedError();
  }

  @override
  Future getData(String? id) {
    throw UnimplementedError();
  }

  @override
  Future getList({int? offSet}) {
    throw UnimplementedError();
  }

  @override
  Future<DetectImageModel?> imageDetection(XFile file) async {
    DetectImageModel? imageDetected;
    Response response = await apiClient.postMultipleData(
        AppConstants.imageUpload, [MultipartBody('file', file)],
        handleError: false);
    if (response.statusCode == 200) {
      imageDetected = DetectImageModel.fromJson(response.body);
    } else if (response.statusText == ApiClient.noInternetMessage ||
        response.statusCode == 404) {
      String? errorMessage = response.statusText.toString();
      throw Exception(errorMessage);
    }

    return imageDetected;
  }
}
