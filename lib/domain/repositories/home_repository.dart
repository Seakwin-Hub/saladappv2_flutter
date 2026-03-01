import 'package:saladappv2_flutter/api/api_client.dart';
import 'package:saladappv2_flutter/domain/repositories/home_repository_interface.dart';

class HomeRepository implements HomeRepositoryInterface {
  final ApiClient apiClient;
  HomeRepository({required this.apiClient});
  @override
  Future add(value) {
    throw UnimplementedError();
  }

  @override
  Future getData(String? id) {
    throw UnimplementedError();
  }

  @override
  Future getList({int? offSet, String? type}) async {
    throw UnimplementedError();
  }
}
