class SaladListModel {
  List<SaladModel>? saladList;
  SaladListModel({this.saladList});

  SaladListModel.fromJson(Map<String, dynamic> json) {
    if (json['saladtype'] != null) {
      saladList = <SaladModel>[];
      json['saladtype'].forEach((v) {
        saladList!.add(SaladModel.fromJson(v));
      });
    }
  }
}

class SaladModel {
  int? saladId;
  String? saladName;
  String? saladDescription;
  List<String>? saladImage;

  SaladModel({
    this.saladId,
    this.saladName,
    this.saladDescription,
    this.saladImage,
  });

  SaladModel.fromJson(Map<String, dynamic> json) {
    saladId = json['sid'];
    saladName = json['saladname'];
    saladDescription = json['descrip'];
    saladImage =
        json['images'] != null ? List<String>.from(json['images']) : null;
  }
}
