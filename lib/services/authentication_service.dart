import 'dart:async';

class AuthenticationService {
  Map<String, String> defaultHeader = {'Content-type': 'application/json'};

  Future<Map<String, String>> header({bool withContentType = false}) async {
    var header = Map<String, String>();

    if (withContentType) {
      header.addAll({'Content-Type': 'application/json'});
    }
    return header;
  }

}
