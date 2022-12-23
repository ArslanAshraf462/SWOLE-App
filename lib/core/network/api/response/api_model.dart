import 'package:swole_app/models/auth/signup.dart';

import '../../../../models/auth/signin.dart';

class ApiModels {
  static const String user = "USER";
  static const String login = "LOGIN";
  static dynamic getModelObjects(String modelName, dynamic json) {
    switch (modelName) {
      case user:
        return Signup.fromJson(json);
      case login:
        return Signin.fromJson(json);
    }
  }

}
