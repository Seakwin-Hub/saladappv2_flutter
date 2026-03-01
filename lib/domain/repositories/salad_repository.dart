import 'package:get/get.dart';
import 'package:saladappv2_flutter/api/api_client.dart';
import 'package:saladappv2_flutter/domain/models/salad_list_model.dart';
import 'package:saladappv2_flutter/domain/repositories/salad_repository_interface.dart';
import 'package:saladappv2_flutter/util/app_constants.dart';

class SaladRepository implements SaladRepositoryInterface {
  final ApiClient apiClient;
  SaladRepository({required this.apiClient});
  @override
  Future add(value) {
    throw UnimplementedError();
  }

  @override
  Future getData(String? id) async {
    return await _getSaladById(int.parse(id!));
  }

  @override
  Future getList({int? offSet, String? query}) async {
    return await _getSaladData();
  }

  Future<SaladListModel?> _getSaladData() async {
    SaladListModel? saladList;
    Response response = await apiClient.getData(AppConstants.saladListUri);
    if (response.statusCode == 200) {
      saladList = SaladListModel.fromJson(response.body);
    } else if (response.statusText == ApiClient.noInternetMessage ||
        response.statusCode == 404) {
      String? errorMessage = response.statusText.toString();
      throw Exception(errorMessage);
    }

    return saladList;
  }

  Future<SaladModel?> _getSaladById(int? saladId) async {
    SaladModel? salad;
    Response response = await apiClient.getData(
      '${AppConstants.saladByIdUri}$saladId',
    );
    if (response.statusCode == 200) {
      salad = SaladModel.fromJson(response.body);
    }
    return salad;
  }
}
