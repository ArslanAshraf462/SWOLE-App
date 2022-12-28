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
        // connectTimeout: AppUrl.networkTimeout,
        // receiveTimeout: AppUrl.networkTimeout,
        // sendTimeout: AppUrl.networkTimeout,
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



//
  // @override
  // Future getGetApiResponse(String url,Map<String, String>? headers,dynamic modelName,) async{
  //   dynamic responseJson;
  //  try{
  //    final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
  //    responseJson = returnResponse(response,modelName);
  //  }on SocketException{
  //    throw FetchDataException('No Internet Connection');
  //  }
  //
  //  return responseJson;
  // }
  //
  // @override
  // Future getPostApiResponse({required String url,dynamic body,dynamic modelName,}) async {
  //   dynamic responseJson;
  //   try{
  //     final response = await http.post(Uri.parse(url),
  //     body: body,
  //       headers: {
  //       HttpHeaders.contentTypeHeader :'application/json',
  //       HttpHeaders.authorizationHeader : 'Bearer ywoCe86M0drbjilyZfhtMkQeO2lUw5Yp',
  //       },
  //     );
  //     responseJson = returnResponse(response,modelName);
  //   }on SocketException{
  //     throw FetchDataException('No Internet Connection');
  //   }
  //   return responseJson;
  // }
  //
  // dynamic returnResponse(Response response,dynamic modelName) async{
  //   switch(response.statusCode){
  //     case 200:
  //       var data = jsonDecode(response.body.toString());
  //       dynamic modelObj =
  //           await ApiModels.getModelObjects(modelName, data);
  //       return modelObj;
  //       // dynamic responseJson = json.decode(response.body);
  //       // return responseJson;
  //     case 201:
  //       var data = jsonDecode(response.body.toString());
  //       dynamic modelObj =
  //       await ApiModels.getModelObjects(modelName, data);
  //       return modelObj;
  //     case 400:
  //       throw BadRequestException(response.body.toString());
  //     case 404:
  //       throw UnauthorisedException(response.body.toString());
  //     default:
  //       throw FetchDataException('Error accorded while communicating with status code${response.statusCode}');
  //   }
  // }

}