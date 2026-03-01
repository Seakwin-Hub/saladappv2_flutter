import 'package:saladappv2_flutter/interface/repository_interface.dart';

abstract class SaladRepositoryInterface extends RepositoryInterface {
  @override
  Future getList({int? offSet, String? query});
}
