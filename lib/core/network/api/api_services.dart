import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:swole_app/core/network/api/api_model.dart';
import 'package:swole_app/core/network/app_url.dart';

import '../../../constants/app_strings.dart';
import '../../../models/error_model.dart';
import '../../../ui/utils/toasts/toast.dart';

import 'dio_exceptions.dart';

class ApiServices{

  static Future<dynamic> callPostApi({
    required String url,
    dynamic modelName,
    dynamic body,
    Map<String, dynamic>? params,
    Map<String, dynamic>? header,
  }) async {
    try {
      BaseOptions options = BaseOptions(
        baseUrl: AppUrl.baseUrl,
        contentType: 'application/json',
        headers: {
         'Authorization' :  AppUrl.token,
        },
      );
      Dio dio = Dio(options);
      Response response = await dio.post(
        url,
        data: body,
        options: Options(headers: header),
        queryParameters: params,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        dynamic modelObject = await ApiModels.getModelObjects(
          modelName,
          response.data,
        );
        debugPrint(response.data.toString());
        return modelObject;
      }
      return null;
    } on DioError catch (er) {
      if (er.response != null) {
        Errors errorResponse = ApiModels.getModelObjects(
          ApiModels.errorModel,
          json.decode(er.response?.data),
        );
        ToastUtils.show(errorResponse.error.toString(), ToastType.error);
        debugPrint("error :${errorResponse.error}");
        return null;
      } else {
        DioExceptions.fromDioException(er);
        debugPrint(er.toString());
        return null;
      }
    } on Exception {
      ToastUtils.show(AppStrings.textUndefinedError, ToastType.error);
      return null;
    } catch (er) {
      debugPrint(er.toString());
      return null;
    }
  }

}