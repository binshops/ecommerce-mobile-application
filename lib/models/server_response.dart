import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:prestashop_mobile_app/enums/response_status.dart';

class ServerResponse {
  ResponseStatus responseStatus = ResponseStatus.FAILED;
  var success = false;
  var body;
  var statusCode = 0;
  var message;
  final bool debugMode;

  ServerResponse(Response response, {@required this.debugMode}) {
    if (response != null) {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        body = response.data;
        statusCode = body['code'];
        message = body['message'];
        switch (statusCode) {
          case 410:
            responseStatus = ResponseStatus.USER_NOT_AUTHENTICATED;
            break;
          case 200:
            responseStatus = ResponseStatus.SUCCESS;
            success = true;

            break;
          case 308:
            responseStatus = ResponseStatus.USER_ALREADY_EXISTS;
            success = false;
            break;
          case 403:
            responseStatus = ResponseStatus.UNAUTHORIZED;
            break;
          case 306:
            responseStatus = ResponseStatus.AUTHENTICATION_FAILED;
            success = false;
            break;
          default:
            responseStatus = ResponseStatus.FAILED;
            success = false;
        }
      } else {
        //server did not understand our request
        responseStatus = ResponseStatus.FAILED;
        statusCode = response.statusCode;
        if (response.data != null) {
          body = json.decode(response.data);
        }
      }

      if (debugMode)
        print(
            'Status code: $statusCode for request: ${response.requestOptions.uri}');
    }
  }
}
