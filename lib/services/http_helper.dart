import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:quyoshli/services/db_service.dart';

import 'log_service.dart';

class HttpInterceptor implements InterceptorContract {
  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) {
    try {
      // Fetching access token from your local
      var accessToken = DBService.getAccessToken();
      // Clear previous header and update it with updated token
      request.headers.clear();
      // request.headers['x-api-key'] = API_KEY;

      request.headers['Content-type'] = 'application/json';
      request.headers['Accept-Language'] = DBService.getLanguage();
      if (accessToken.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $accessToken';
      }
      log(request.url.toString());

      LogService.i(request.toString());
    } catch (e) {
      LogService.e(e.toString());
    }
    return request;
  }

  @override
  FutureOr<BaseResponse> interceptResponse({required BaseResponse response}) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response is Response) {
        LogService.i(jsonDecode(response.body).toString());
      }
    } else {
      LogService.e(response.statusCode.toString());
      LogService.e(response.toString());
    }
    return response;
  }

  @override
  FutureOr<bool> shouldInterceptRequest() {
    return true;
  }

  @override
  FutureOr<bool> shouldInterceptResponse() {
    return true;
  }
}

class HttpRetryPolicy extends RetryPolicy {
  //Number of retry
  @override
  int maxRetryAttempts = 2;

  @override
  Future<bool> shouldAttemptRetryOnResponse(BaseResponse response) async {
    if (response.statusCode == 401) {
      // Load access and refresh token from local
      var accessToken = "";
      var refreshToken = "";

      // Call refresh token Api and get response
      // Map<String, String> headers = {'Content-type': 'application/json'};
      // headers.putIfAbsent("Authorization", () => 'Bearer $accessToken');
      // headers.putIfAbsent("RefreshToken", () => 'Bearer $refreshToken');
      // var response = await HttpService.GET(HttpService.API_REFRESH_TOKEN, HttpService.paramsEmpty());
      // Store access and refresh token to local

      return true;
    }
    return false;
  }
}

class HttpException implements Exception {
  final _message;
  final _prefix;

  HttpException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends HttpException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends HttpException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends HttpException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends HttpException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
