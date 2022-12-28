import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:swole_app/core/network/api/api_services.dart';
import 'package:swole_app/core/network/app_url.dart';
import 'package:swole_app/models/auth/signin.dart';
import 'package:swole_app/models/auth/signup.dart';
import 'package:swole_app/routes/routes_name.dart';
import '../constants/app_strings.dart';
import '../core/network/api/api_model.dart';
import '../ui/utils/toasts/toast.dart';
class AuthViewModel with ChangeNotifier {
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
    if (user != null) {
      ToastUtils.show(
        AppStrings.textSuccessLogin,
        ToastType.success,
      );
      navigatorState.pushReplacementNamed(RoutesName.welcomeScreen);
    } else {
      debugPrint(null);
    }
  }
}