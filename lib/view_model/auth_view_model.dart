import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:swole_app/core/network/api/api_services.dart';
import 'package:swole_app/core/network/app_url.dart';
import 'package:swole_app/models/auth/signup.dart';
import 'package:swole_app/routes/routes_name.dart';
import '../constants/app_strings.dart';
import '../core/network/api/api_model.dart';
import '../ui/utils/toasts/toast.dart';
class AuthViewModel with ChangeNotifier{
   Future<Signup?>? signup({
     required BuildContext context,
    required String email,
    required String password,
  }) async {
     Signup? user = await ApiServices.callPostApi(
      url: AppUrl.signupEndPoint,
      params: {
        "email": email,
        "password": password,
        'role' : AppUrl.role,
      },
      modelName: ApiModels.user,
    );
    if (user != null) {
      ToastUtils.show(
        AppStrings.textSuccessLogin,
        ToastType.success,
      );
      Navigator.pushReplacementNamed(context, RoutesName.login);
    } else {
      debugPrint(null);
    }
  }
}



// class AuthViewModel with ChangeNotifier{
//   final _service = ApiServices();
//
//   bool _loading = false;
//   bool _signUpLoading = false;
//
//   bool get signUpLoading => _signUpLoading;
//
//   setSignUpLoading(bool value) {
//     _signUpLoading = value;
//     notifyListeners();
//   }
//
//   bool get loading => _loading;
//
//   setLoading(bool value) {
//     _loading = value;
//     notifyListeners();
//   }
//
//   Future<void> loginApi({required String email,
//   required String password,required BuildContext context}) async{
//     setLoading(true);
//     _service.getPostApiResponse(
//         url: AppUrl.loginEndPoint,
//         modelName: ApiModels.login,
//         body: {
//           'email':'jawad@gmail.com',
//           'password':'11111111',
//           'role' : "a1953075-c13d-4a4c-997f-396a6a54649e",
//           'access_token' : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImU5MTdmN2I3LTE0MGItNDQ0ZC1iZmM5LWVjZGRiMWQ1NmEyZiIsInJvbGUiOiJhMTk1MzA3NS1jMTNkLTRhNGMtOTk3Zi0zOTZhNmE1NDY0OWUiLCJhcHBfYWNjZXNzIjp0cnVlLCJhZG1pbl9hY2Nlc3MiOmZhbHNlLCJpYXQiOjE2NzE3Nzc1MjYsImV4cCI6MTY3MTc3ODQyNiwiaXNzIjoiZGlyZWN0dXMifQ.QLg7sz7XPOlepv6H8nSWUBGnOhW9_eEdZZg-9h_ZFg0",
//           "refresh_token": "5xGxlDJsTNN7nVz5tFioxJVmOjHInd3YKtsyuB32l1mX-rOPASn8plss7xc3T7Ex"
//         }
//     ).then((value){
//       setLoading(false);
//       ToastUtils.flushBarErrorMessage('Login Successfully', context);
//       Navigator.pushNamed(context, RoutesName.resetPasswordScreen);
//       if(kDebugMode) {
//         print(value.toString());
//       }
//     }).onError((error, stackTrace) {
//       setLoading(false);
//       ToastUtils.flushBarErrorMessage(error.toString(), context);
//       if(kDebugMode) {
//         print(error.toString());
//       }
//     });
//   }
//
//
//
//   Future<void> signUpApi({required String email,
//     required String password,required BuildContext context}) async{
//     setSignUpLoading(true);
//     _service.getPostApiResponse(
//         url: AppUrl.signupEndPoint,
//         modelName: ApiModels.user,
//         body: {
//       'email':email,
//       'password':password,
//       'role' : "a1953075-c13d-4a4c-997f-396a6a54649e",
//     }).then((value){
//       setSignUpLoading(false);
//       ToastUtils.flushBarErrorMessage('Signup Successfully', context);
//       Navigator.pushNamed(context, RoutesName.login);
//       if(kDebugMode) {
//         print(value.toString());
//       }
//     }).onError((error, stackTrace) {
//       setSignUpLoading(false);
//       ToastUtils.flushBarErrorMessage(error.toString(), context);
//       if(kDebugMode) {
//         print(error.toString());
//       }
//     });
//   }
// }