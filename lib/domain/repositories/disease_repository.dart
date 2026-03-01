import 'package:get/get.dart';
import 'package:saladappv2_flutter/api/api_client.dart';
import 'package:saladappv2_flutter/domain/models/disease_list_model.dart';
import 'package:saladappv2_flutter/domain/repositories/disease_repository_interface.dart';
import 'package:saladappv2_flutter/util/app_constants.dart';

class DiseaseRepository implements DiseaseRepositoryInterface {
  final ApiClient apiClient;
  DiseaseRepository({required this.apiClient});
  @override
  Future add(value) {
    throw UnimplementedError();
  }

  @override
  Future getData(String? id) async {
    return await _getDiseaseById(int.parse(id!));
  }

  @override
  Future getList({int? offSet, String? query}) async {
    return await _getDiseaesData();
  }

  Future<DiseaseListModel?> _getDiseaesData() async {
    DiseaseListModel? diseaseList;
    Response response = await apiClient.getData(AppConstants.diseaseListUri);
    if (response.statusCode == 200) {
      diseaseList = DiseaseListModel.fromJson(response.body);
    } else if (response.statusText == ApiClient.noInternetMessage ||
        response.statusCode == 404) {
      String? errorMessage = response.statusText.toString();
      throw Exception(errorMessage);
    }
    return diseaseList;
  }

  Future<DiseaseModel?> _getDiseaseById(int? diseaseId) async {
    DiseaseModel? disease;
    Response response = await apiClient.getData(
      '${AppConstants.diseaseByIdUri}/$diseaseId',
    );
    if (response.statusCode == 200) {
      disease = DiseaseModel.fromJson(response.body);
    }
    return disease;
  }
}
