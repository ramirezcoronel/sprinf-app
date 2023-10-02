import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:sprinf_app/app/domain/either.dart';

class Http {
  Http({required baseUrl, required token, required client})
      : _client = client,
        _baseUrl = baseUrl,
        _token = token;

  final Client _client;
  final String _baseUrl;
  final String _token;

  Future<Either<HttpFailure, R>> request<R>(String path,
      {HttpMethod method = HttpMethod.get,
      required R Function(String responseBody) onSucess,
      Map<String, String> headers = const {},
      Map<String, String> queryParameters = const {},
      Map<String, dynamic> body = const {},
      bool useToken = false}) async {
    Map logs = {};
    StackTrace? stackTrace;
    try {
      Uri url = Uri.parse(path.startsWith('http') ? path : '$_baseUrl$path');

      if (queryParameters.isNotEmpty) {
        url = url.replace(queryParameters: queryParameters);
      }

      headers = {
        'Content-Type': 'application/json',
        ...headers,
      };

      if (useToken) {
        headers = {'Authorization': 'Bearer $_token', ...headers};
      }

      late final Response response;

      final String bodyString = jsonEncode(body);

      logs = {'url': url, 'method': method, 'body': body};

      switch (method) {
        case HttpMethod.get:
          response = await _client.get(url);
          break;
        case HttpMethod.post:
          response =
              await _client.post(url, headers: headers, body: bodyString);
          break;
      }

      logs = {
        ...logs,
        'statusCode': response.statusCode,
        'responseBody': response.body
      };

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Either.right(onSucess(response.body));
      } else {
        return Either.left(HttpFailure(
            statusCode: response.statusCode, exception: NetworkException()));
      }
    } catch (e, s) {
      logs = {...logs, 'exception': e.runtimeType};
      stackTrace = s;
      if (e is SocketException || e is ClientException) {
        logs = {...logs, 'exception': 'networkException'};
        return Either.left(HttpFailure(exception: NetworkException()));
      } else {
        return Either.left(HttpFailure(exception: e));
      }
    } finally {
      log('''
🛠️
--------------------------------------------------------
${const JsonEncoder.withIndent(' ').convert(logs)}
--------------------------------------------------------
🛠️
''', stackTrace: stackTrace);
    }
  }
}

class HttpFailure {
  final int? statusCode;
  final Object? exception;

  HttpFailure({this.statusCode, this.exception});
}

class NetworkException {}

enum HttpMethod { get, post }
