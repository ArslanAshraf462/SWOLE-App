// import 'package:flutter/cupertino.dart';
// import '../core/network/api/network_api_services.dart';
// import '../core/network/app_url.dart';
//
// class AuthServices{
//
//   final NetworkApiServices _apiServices = NetworkApiServices();
//   Future<dynamic> loginApi(dynamic data,Map<String, String>? headers,dynamic modelName) async{
//     try{
//       dynamic response = await _apiServices.getPostApiResponse(url: AppUrl.loginEndPoint, data: data,headers: headers,modelName: modelName);
//       return response;
//     }catch(e){
//       rethrow;
//     }
//   }
//
//   Future<dynamic> signUpApi(dynamic data,Map<String, String>? headers,dynamic modelName) async{
//     try{
//       dynamic response = await _apiServices.getPostApiResponse(url: AppUrl.signupEndPoint, data: data,headers: headers,modelName: modelName);
//       debugPrint(response);
//       return response;
//     }catch(e){
//       debugPrint(e.toString());
//       rethrow;
//     }
//   }
//
// }