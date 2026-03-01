import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:saladappv2_flutter/interface/repository_interface.dart';

abstract class CameraRepositoryInterface extends RepositoryInterface {
  Future<dynamic> imageDetection(XFile file);
}
