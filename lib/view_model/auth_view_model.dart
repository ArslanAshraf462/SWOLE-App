import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:swole_app/core/network/api/api_services.dart';
import 'package:swole_app/core/network/app_url.dart';
import 'package:swole_app/core/shared_prefrences/shared_prefs.dart';
import 'package:swole_app/models/auth/signin.dart';
import 'package:swole_app/models/auth/signup.dart';
import 'package:swole_app/routes/routes_name.dart';
import 'package:swole_app/service/service.dart';
import 'package:swole_app/ui/utils/app_dialogs/dialogs.dart';
import '../constants/app_strings.dart';
import '../core/network/api/api_model.dart';
import '../models/auth/current_user.dart';
import '../ui/utils/toasts/toast.dart';
class AuthViewModel with ChangeNotifier {
  CurrentUser? _users;

  CurrentUser? get users => _users;

  set users(CurrentUser? value) {
    _users = value;
    notifyListeners();
  }

  Future<Signup?>? signup({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    NavigatorState navigatorState = Navigator.of(context);
    Signup? user = await ApiServices.callPostApi(
      url: AppUrl.signupEndPoint,
      body: json.encode({
        "email": email,
        "password": password,
        'role': AppUrl.role,
      }),
      modelName: ApiModels.user,
    );
    if (user != null) {
      ToastUtils.show(
        AppStrings.textSuccessRegister,
        ToastType.success,
      );
      navigatorState.pushReplacementNamed(RoutesName.login);
    } else {
      debugPrint(null);
    }
  }
  Future<Signup?>? login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    NavigatorState navigatorState=Navigator.of(context);
    Signin? user = await ApiServices.callPostApi(
      url: AppUrl.loginEndPoint,
      body: json.encode({
        "email": email,
        "password": password,
      }),
      modelName: ApiModels.login,
    );
    await locator<SharedPreferenceHelper>().saveAuthToken(user?.data?.accessToken);
    await locator<SharedPreferenceHelper>().saveRefreshToken(user?.data?.refreshToken);
    if (user != null) {
      ToastUtils.show(
        AppStrings.textSuccessLogin,
        ToastType.success,
      );
      navigatorState.pushReplacementNamed(RoutesName.currentUserScreen);
    } else {
      debugPrint(null);
    }
  }
  Future<CurrentUser?>? currentUser(BuildContext context) async{
     NavigatorState navigatorState=Navigator.of(context);
     _users = await ApiServices.callGetApi(
        url: AppUrl.currentUserEndPoint,
    modelName: ApiModels.currentUserModel,
    );
    debugPrint("current user email -> ${_users?.data?.email.toString()}");

    if(_users == null){
      AppDialogs.showAuthDialog(
        context: context,
        title: AppStrings.currentUserSessionText,
        body: AppStrings.currentUserSessionBodyText,
        okBtnTitle: AppStrings.okText,
        okBtnPressed: () => navigatorState.pushReplacementNamed(RoutesName.login),);
     }
     users =_users;
     // if(users == null){
     //   AppDialogs.showAuthDialog(
     //     context: context,
     //     title: AppStrings.currentUserSessionText,
     //     body: AppStrings.currentUserSessionBodyText,
     //     okBtnTitle: AppStrings.okText,
     //     okBtnPressed: () => navigatorState.pushReplacementNamed(RoutesName.login),);
     //  }
    // notifyListeners();
    return null;
  }
// sessionProvider(BuildContext context){
//   NavigatorState navigatorState=Navigator.of(context);
//   if(users == null){
//     AppDialogs.showAuthDialog(
//       context: context,
//       title: AppStrings.currentUserSessionText,
//       body: AppStrings.currentUserSessionBodyText,
//       okBtnTitle: AppStrings.okText,
//       okBtnPressed: () => navigatorState.pushReplacementNamed(RoutesName.login),);
//     notifyListeners();
//   }
// }
}