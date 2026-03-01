import 'package:saladappv2_flutter/interface/repository_interface.dart';

abstract class HomeRepositoryInterface extends RepositoryInterface {
  @override
  Future getList({int? offSet, String? type});
}
