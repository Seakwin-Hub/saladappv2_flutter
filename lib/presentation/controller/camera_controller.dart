import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saladappv2_flutter/common/widgets/custom_snackbar.dart';
import 'package:saladappv2_flutter/domain/models/detect_image_model.dart';
import 'package:saladappv2_flutter/domain/models/disease_list_model.dart';
import 'package:saladappv2_flutter/domain/repositories/camera_repository_interface.dart';
import 'package:saladappv2_flutter/helper/image_compress.dart';
import 'package:saladappv2_flutter/presentation/controller/disease_controller.dart';

class CameraController extends GetxController implements GetxService {
  final CameraRepositoryInterface cameraRepositoryInterface;
  CameraController({required this.cameraRepositoryInterface});

  XFile? _pickedFile;
  XFile? get pickedFile => _pickedFile;

  Uint8List? _rawFile;
  Uint8List? get rawFile => _rawFile;

  DiseaseModel? _diseaseData;
  DiseaseModel? get diseaseData => _diseaseData;

  List<DiseaseModel>? _diseaseItem;
  List<DiseaseModel>? get diseaseItem => _diseaseItem;

  DetectImageModel? _detectImage;
  DetectImageModel? get detectImage => _detectImage;

  ImageModel? _imageData;
  ImageModel? get imageData => _imageData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isNotDetectCall = true;
  bool get isNotDetectCall => _isNotDetectCall;

  void initData() {
    _pickedFile = null;
    _rawFile = null;
    _diseaseData = null;
    _isNotDetectCall = true;
    _diseaseItem = [];
    _imageData = null;

    update();
  }

  void pickImage(bool isCamera) async {
    _isLoading = true;
    update();
    _pickedFile = await ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (_pickedFile != null) {
      _pickedFile = await ImageCompress.compressImage(_pickedFile!);
      _rawFile = await _pickedFile!.readAsBytes();
      _isLoading = false;
      update();
    }
  }

  void detectionImage() async {
    _isLoading = true;
    try {
      _detectImage =
          await cameraRepositoryInterface.imageDetection(_pickedFile!);
      if (_detectImage != null) {
        _diseaseItem = Get.find<DiseaseController>().diseaseItem;
        _imageData = _detectImage!.dataDetected!.firstOrNull;

        if (_diseaseItem != null) {
          _diseaseData = _diseaseItem!
              .firstWhereOrNull((e) => e.diseaseId == _imageData!.diseaseId);
        }
        if (_diseaseData == null || imageData!.imageDetected!.isEmpty) {
          return showCustomSnackBar("image_problem".tr, getXSnackBar: true);
        }

        _isNotDetectCall = false;
        _isLoading = false;
        update();
      }
    } catch (e) {
      _isLoading = false;
      update();
    }
  }
}
