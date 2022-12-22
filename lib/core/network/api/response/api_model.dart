import 'package:swole_app/models/auth/signup.dart';

class ApiModels {
  static const String user = "USER";
  static dynamic getModelObjects(String modelName, dynamic json) {
    switch (modelName) {
      case user:
        return Signup.fromJson(json);
    }
  }

}
