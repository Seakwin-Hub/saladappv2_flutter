import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saladappv2_flutter/api/api_checker.dart';
import 'package:saladappv2_flutter/common/model/error_response.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;

class ApiClient extends GetxService {
  final String appBaseUrl;
  static final String noInternetMessage = "connection_to_api_server_failed".tr;
  final int timeoutInSeconds = 40;

  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}) {
    updateHeader();
  }

  Map<String, String> updateHeader({bool setHeader = true}) {
    Map<String, String> header = {};
    header.addAll({'Content-Type': 'application/json; charset=UTF-8'});
    if (setHeader) {
      _mainHeaders = header;
    }
    return header;
  }

  Future<Response> getData(
    String uri, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    bool handleError = true,
  }) async {
    try {
      if (kDebugMode) {
        print('====> API Call: $uri\nHeader: ${headers ?? _mainHeaders}');
      }
      http.Response response = await http
          .get(Uri.parse(appBaseUrl + uri), headers: headers ?? _mainHeaders)
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri, handleError);
    } catch (e) {
      if (kDebugMode) {
        print('------------${e.toString()}');
      }

      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipleData(
    String uri,
    List<MultipartBody> multipartBody, {
    Map<String, String>? headers,
    bool handleError = true,
  }) async {
    try {
      if (kDebugMode) {
        print('====> API Call: $uri\nHeader: ${headers ?? _mainHeaders}');
        print('====> API Body with ${multipartBody.length} picture');
      }
      http.MultipartRequest request =
          http.MultipartRequest('POST', Uri.parse(appBaseUrl + uri));
      request.headers.addAll(headers ?? _mainHeaders);
      for (MultipartBody multipart in multipartBody) {
        if (multipart.file != null) {
          Uint8List list = await multipart.file!.readAsBytes();
          request.files.add(http.MultipartFile(
            multipart.key,
            multipart.file!.readAsBytes().asStream(),
            list.length,
            filename: 'imageDetect.jpg',
          ));
        }
      }
      http.Response response =
          await http.Response.fromStream(await request.send());

      return handleResponse(response, uri, handleError);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(
    http.Response response,
    String uri,
    bool handleError,
  ) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (_) {}
    Response response0 = Response(
      body: body ?? response.body,
      bodyString: response.body.toString(),
      request: Request(
        url: response.request!.url,
        method: response.request!.method,
        headers: response.request!.headers,
      ),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (response0.statusCode != 200 &&
        response0.body != null &&
        response0 is! String) {
      if (response0.body.toString().startsWith('{error: [{code :')) {
        ErrorResponse errorResponse = ErrorResponse.fromJson(response0.body);
        response0 = Response(
          body: response0.body,
          statusCode: response0.statusCode,
          statusText: errorResponse.errors![0].message,
        );
      } else if (response0.body.toString().startsWith('{message')) {
        response0 = Response(
          statusCode: response0.statusCode,
          body: response0.body,
          statusText: response0.body['message'],
        );
      }
    } else if (response0.statusCode != 200 && response0.body == null) {
      response0 = Response(statusCode: 0, statusText: noInternetMessage);
    } else if (response0.statusCode == 200) {
      if (response0.body.toString().startsWith('{msg')) {
        response0 = Response(
          body: response0.body,
          statusCode: 404,
          statusText: response0.body['msg'],
        );
      }
      return response0;
    }
    if (kDebugMode) {
      print('====> API Response: [${response0.statusCode}] $uri');
    }
    if (handleError) {
      if (response0.statusCode == 200) {
        return response0;
      } else {
        ApiChecker.checkApi(response0);
        return const Response();
      }
    } else {
      return response0;
    }
  }
}

class MultipartBody {
  String key;
  XFile? file;

  MultipartBody(this.key, this.file);
}
