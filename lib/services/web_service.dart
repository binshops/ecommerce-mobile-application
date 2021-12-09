import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:prestashop_mobile_app/models/server_response.dart';
import 'package:prestashop_mobile_app/services/authentication_service.dart';

class WebService {
  AuthenticationService authenticationService;

  WebService({this.authenticationService});

  WebService setDependencies(
    AuthenticationService authenticationService,
  ) {
    this.authenticationService = authenticationService;
    print('Web service updated');
    return this;
  }

  final dio = Dio();

  Future<ServerResponse> getFunction(
    String url, {
    var body,
  }) async {
    print('requesting data from $url');
    Response response;
    try {
      var headers = await authenticationService.header(withContentType: false);
      response = await dio.get(url, options: Options(headers: headers));
    } catch (errorMessage) {
      print('request failed with this error : ');
      print(errorMessage);
    }
    return ServerResponse(response, debugMode: debugMode);
  }

  Future<ServerResponse> postFunction(
    String url, {
    bool withContentType = false,
    var body,
  }) async {
    print('requesting data from $url');
    Response response;
    try {
      var headers =
          await authenticationService.header(withContentType: withContentType);
      response = await dio.post(
        url,
        options: Options(
          headers: headers,
        ),
        data: json.encode(body),
      );
    } catch (errorMessage) {
      print('request failed with this error : ');
      print(errorMessage);
    }
    return ServerResponse(response, debugMode: debugMode);
  }

  Future<ServerResponse> deleteFunction(
    String url, {
    bool withContentType = false,
    var body,
  }) async {
    print('requesting data from $url');
    Response response;
    try {
      var headers =
          await authenticationService.header(withContentType: withContentType);
      response = await dio.delete(
        url,
        options: Options(
          headers: headers,
        ),
        data: json.encode(body),
      );
    } catch (errorMessage) {
      print('request failed with this error : ');
      print(errorMessage);
    }
    return ServerResponse(response, debugMode: debugMode);
  }
}
