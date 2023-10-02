import 'dart:convert';
import 'dart:html';
import 'dart:io';

import 'package:http/http.dart';
import 'package:sprinf_app/app/domain/either.dart';

class Http {
  Http(this._baseUrl, this._token, this._client);

  final Client _client;
  final String _baseUrl;
  final String _token;

  Future<Either<HttpFailure, Response>> request(String path,
      {HttpMethod method = HttpMethod.get,
      Map<String, String> headers = const {},
      Map<String, String> queryParameters = const {},
      Map<String, dynamic> body = const {},
      bool useToken = false}) async {
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

      switch (method) {
        case HttpMethod.get:
          response = await _client.get(url);
          break;
        case HttpMethod.post:
          response =
              await _client.post(url, headers: headers, body: bodyString);
          break;
      }
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Either.right(response);
      } else {
        return Either.left(HttpFailure(
            statusCode: response.statusCode, exception: NetworkException()));
      }
    } catch (e) {
      if (e is SocketException || e is ClientException) {
        return Either.left(HttpFailure(exception: NetworkException()));
      } else {
        return Either.left(HttpFailure(exception: e));
      }
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
