class DiseaseListModel {
  List<DiseaseModel>? diseaseList;
  DiseaseListModel({this.diseaseList});

  DiseaseListModel.fromJson(Map<String, dynamic> json) {
    if (json['diseaselist'] != null) {
      diseaseList = <DiseaseModel>[];
      json['diseaselist'].forEach((v) {
        diseaseList!.add(DiseaseModel.fromJson(v));
      });
    }
  }
}

class DiseaseModel {
  int? diseaseId;
  String? diseaseName;
  String? causeOfDisease;
  String? diseaseMeaning;
  String? typeOfDisease;
  String? diseaseTreatment;
  List<String>? diseaseImage;

  DiseaseModel({
    this.diseaseId,
    this.diseaseName,
    this.causeOfDisease,
    this.diseaseMeaning,
    this.typeOfDisease,
    this.diseaseTreatment,
    this.diseaseImage,
  });

  DiseaseModel.fromJson(Map<String, dynamic> json) {
    diseaseId = json['did'];
    diseaseName = json['disease'].toString();
    causeOfDisease = json['cause'];
    diseaseMeaning = json['dmeaning'];
    typeOfDisease = json['typedisease'];
    diseaseTreatment = json['treatment'];
    diseaseImage =
        json['images'] != null ? List<String>.from(json['images']) : null;
  }
}
