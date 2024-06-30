import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' as GetX;
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:get_storage/get_storage.dart';
import '../utils/constants.dart';
import 'api_client.dart';

class APIClintImpl implements APIClient {
  late Dio _dio;

  APIClintImpl() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 7),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${GetStorage().read(accessToken)}'
      },
    );
    _dio = Dio(options);
    if (useInterceptor) {
      _dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90));
    }
  }

  dynamic purifyResponse(Future<Response> response) async {
    String errorMessage = "Failed to load data from server!";
    Map<String, dynamic> result = {};
    await response.then((value) {
      if (value.statusCode == 200 && ("${value.data['status']}" == "200") && ("${value.data['msg']}" == "OK")) {
        result = value.data;
      } else {
        errorMessage = "${value.data['description']}";
        EasyLoading.dismiss();
        throw Error();
      }
      EasyLoading.dismiss();
    }).catchError((error) {
      GetX.Get.snackbar(
        'Failed',
        errorMessage,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(.4),
        colorText: Colors.black,
      );
      EasyLoading.dismiss();
      return null;
    });
    return result.isEmpty ? null : result;
  }

  @override
  Future<dynamic> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    return purifyResponse(_dio.get(endpoint, queryParameters: queryParameters));
  }

  @override
  Future<dynamic> post(String endpoint, {required String data}) async {
    return await purifyResponse(_dio.post(endpoint, data: data));
  }

  @override
  Future delete(String endpoint) {
    return purifyResponse(_dio.delete(endpoint));
  }

  @override
  Future<dynamic> uploadFiles(String endpoint,
      {Map<String, dynamic>? data,
      Map<String, dynamic>? keysAndFilePaths}) async {
    FormData formData = FormData();

    if (data != null) {
      data.forEach((key, value) {
        formData.fields.add(MapEntry(key, value.toString()));
      });
    }

    if (keysAndFilePaths != null) {
      keysAndFilePaths.forEach((key, value) async {
        String fileName = value.split('/').last;
        formData.files.add(MapEntry(
          key,
          await MultipartFile.fromFile(value, filename: fileName),
        ));
      });
    }

    return await purifyResponse(_dio.post(endpoint, data: formData));
  }


}
