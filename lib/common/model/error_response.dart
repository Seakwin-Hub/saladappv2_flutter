class ErrorResponse {
  List<Errors>? _errors;
  List<Errors>? get errors => _errors;

  ErrorResponse({List<Errors>? errors}) {
    _errors = errors;
  }

  ErrorResponse.fromJson(dynamic json) {
    if (json['errors'] != null) {
      _errors = [];
      json['errors'].forEach((v) {
        _errors!.add(Errors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_errors != null) {
      map['errors'] = _errors!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Errors {
  String? _code;
  String? _message;
  String? _msg;

  String? get code => _code;
  String? get message => _message;
  String? get msg => _msg;

  Errors({String? code, String? message, String? msg}) {
    _code = code;
    _message = message;
    _msg = msg;
  }

  Errors.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};

    map['code'] = _code;
    map['msg'] = _msg;
    map['message'] = _message;
    return map;
  }
}
