import 'package:get/get.dart';
import 'package:saladappv2_flutter/domain/models/disease_list_model.dart';
import 'package:saladappv2_flutter/domain/repositories/disease_repository_interface.dart';
import 'package:saladappv2_flutter/presentation/controller/salad_controller.dart';

class DiseaseController extends GetxController implements GetxService {
  final DiseaseRepositoryInterface diseaseRepositoryInterface;
  DiseaseController({required this.diseaseRepositoryInterface});

  List<DiseaseModel>? _diseaseItem;
  List<DiseaseModel>? get diseaseItem => _diseaseItem;

  DiseaseListModel? _diseaseList;
  DiseaseListModel? get diseaseList => _diseaseList;

  DiseaseModel? _disease;
  DiseaseModel? get disease => _disease;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool? _hasConnection;
  bool? get hasConnection => _hasConnection;

  bool _isExceptionError = false;
  bool get isExceptionError => _isExceptionError;

  void handleLoading(bool loading) {
    _isLoading = !loading;
    update();
  }

  void handleConnection() {
    _hasConnection = Get.find<SaladController>().hasConnection!;
    update();
  }

  void getDiseaseList() async {
    _isLoading = true;
    try {
      _diseaseList = await diseaseRepositoryInterface.getList();
      if (_diseaseList != null) {
        _diseaseItem = [];
        for (var diseaseItem in _diseaseList!.diseaseList!) {
          _diseaseItem!.add(diseaseItem);
        }
        _isExceptionError = false;
        _isLoading = false;
        update();
      }
    } catch (e) {
      _isExceptionError = true;
      _isLoading = false;
      update();
    }
  }

  Future<DiseaseModel?> getDiseaseById(DiseaseModel disease) async {
    _disease ??= DiseaseModel();
    if (_disease!.diseaseName != null) {
      _disease = disease;
    } else {
      _disease = null;
      _disease = await diseaseRepositoryInterface.getData(
        disease.diseaseId.toString(),
      );
    }
    return _disease;
  }
}
