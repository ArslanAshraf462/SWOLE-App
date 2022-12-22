import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:swole_app/core/network/api/response/api_model.dart';

import '../../app_exceptions.dart';
import 'base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices{
  @override
  Future getGetApiResponse(String url,Map<String, String>? headers,dynamic modelName,) async{
    dynamic responseJson;
   try{
     final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
     responseJson = returnResponse(response,modelName);
   }on SocketException{
     throw FetchDataException('No Internet Connection');
   }

   return responseJson;
  }

  @override
  Future getPostApiResponse({required String url,dynamic body,dynamic modelName,}) async {
    dynamic responseJson;
    try{
      final response = await http.post(Uri.parse(url),
      body: body,
        headers: {
        HttpHeaders.authorizationHeader : 'Bearer ywoCe86M0drbjilyZfhtMkQeO2lUw5Yp',
        },
      );
      responseJson = returnResponse(response,modelName);
    }on SocketException{
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(Response response,dynamic modelName) async{
    switch(response.statusCode){
      case 200:
        var data = jsonDecode(response.body.toString());
        dynamic modelObj =
            await ApiModels.getModelObjects(modelName, data);
        return modelObj;
        // dynamic responseJson = json.decode(response.body);
        // return responseJson;
      case 201:
        var data = jsonDecode(response.body.toString());
        dynamic modelObj =
        await ApiModels.getModelObjects(modelName, data);
        return modelObj;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException('Error accorded while communicating with status code${response.statusCode}');
    }
  }

}