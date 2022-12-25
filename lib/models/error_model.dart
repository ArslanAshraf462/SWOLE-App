class Errors {
  String error;

  Errors({
    required this.error,
  });

  factory Errors.fromJson(dynamic jsonData) {
    return Errors(
      error: jsonData["error"],
    );
  }

  Map<String,dynamic> toJson(){
    Map<String,dynamic> map ={};
    map["error"] = error;
    return map;
  }
}