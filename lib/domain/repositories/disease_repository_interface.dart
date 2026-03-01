import 'package:saladappv2_flutter/interface/repository_interface.dart';

abstract class DiseaseRepositoryInterface extends RepositoryInterface {
  @override
  Future getList({int? offSet, String? query});
}
