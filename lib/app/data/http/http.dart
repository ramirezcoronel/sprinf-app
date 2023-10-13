import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart';
import 'package:sprinf_app/app/domain/either.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'failure.dart';
part 'logs.dart';
part 'parse_response_body.dart';

part 'http.g.dart';

enum HttpMethod { get, post }

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
      required R Function(dynamic responseBody) onSucess,
      Map<String, String> headers = const {},
      Map<String, String> queryParameters = const {},
      Map<String, dynamic> body = const {},
      bool useToken = false}) async {
    Map<String, dynamic> logs = {};
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

      logs = {'url': url.toString(), 'method': method.toString(), 'body': body};

      switch (method) {
        case HttpMethod.get:
          response = await _client.get(url);
          break;
        case HttpMethod.post:
          response =
              await _client.post(url, headers: headers, body: bodyString);
          break;
      }
      dynamic responseBody = _parseResponseBody(response.body);
      logs = {
        ...logs,
        'statusCode': response.statusCode,
        'responseBody': responseBody
      };

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Either.right(onSucess(responseBody));
      } else {
        return Either.left(HttpFailure(
            statusCode: response.statusCode,
            exception: responseBody.toString()));
      }
    } catch (e, s) {
      logs = {...logs, 'exception': e.toString()};
      stackTrace = s;
      if (e is SocketException || e is ClientException) {
        logs = {...logs, 'exception': 'networkException: ${e.toString()}'};
        return Either.left(HttpFailure(exception: e.toString()));
      } else {
        return Either.left(HttpFailure(exception: e));
      }
    } finally {
      _printLogs(logs, stackTrace);
    }
  }
}

@riverpod
Http http(HttpRef ref, {required String baseUrl, required String token}) {
  return Http(baseUrl: baseUrl, token: token, client: Client());
}
