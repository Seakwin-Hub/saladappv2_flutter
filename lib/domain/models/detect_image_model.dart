class DetectImageModel {
  List<ImageModel>? dataDetected;
  DetectImageModel({this.dataDetected});

  DetectImageModel.fromJson(Map<String, dynamic> json) {
    if (json['objresponse'] != null) {
      dataDetected = [];
      json['objresponse'].forEach((v) {
        dataDetected!.add(ImageModel.fromJson(v));
      });
    }
  }
}

class ImageModel {
  int? diseaseId;
  String? messsage;
  String? imageDetected;

  ImageModel({
    this.diseaseId,
    this.imageDetected,
    this.messsage,
  });

  ImageModel.fromJson(Map<String, dynamic> json) {
    diseaseId = json['diseaseid'];
    messsage = json['message'];
    imageDetected = json['image_url'];
  }
}
