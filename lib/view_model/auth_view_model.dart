import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:swole_app/core/network/api/network_api_services.dart';
import 'package:swole_app/core/network/app_url.dart';
import 'package:swole_app/services/auth_services.dart';
import 'package:swole_app/ui/utils/toasts/toast.dart';
import '../core/network/api/response/api_model.dart';
import '../routes/routes_name.dart';

class AuthViewModel with ChangeNotifier{
  final _myRepo = NetworkApiServices();

  bool _loading = false;
  bool _signUpLoading = false;

  bool get signUpLoading => _signUpLoading;

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async{
    setLoading(true);
    _myRepo.getPostApiResponse(url: AppUrl.loginEndPoint).then((value){
      setLoading(false);
      ToastUtils.flushBarErrorMessage('Login Successfully', context);
      Navigator.pushNamed(context, RoutesName.home);
      if(kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      ToastUtils.flushBarErrorMessage(error.toString(), context);
      if(kDebugMode) {
        print(error.toString());
      }
    });
  }



  Future<void> signUpApi({required String email,
    required String password,required BuildContext context}) async{
    setSignUpLoading(true);
    _myRepo.getPostApiResponse(
        url: AppUrl.signupEndPoint,
        modelName: ApiModels.user,
        body: {
      'email':email,
      'password':password,
      'role' : "a1953075-c13d-4a4c-997f-396a6a54649e",
    }).then((value){
      setSignUpLoading(false);
      ToastUtils.flushBarErrorMessage('Signup Successfully', context);
      Navigator.pushNamed(context, RoutesName.login);
      if(kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setSignUpLoading(false);
      ToastUtils.flushBarErrorMessage(error.toString(), context);
      if(kDebugMode) {
        print(error.toString());
      }
    });
  }
}