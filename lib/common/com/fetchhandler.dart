import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:naver_crs/index.dart';
import 'package:naver_crs/index.dart';

Future<http.Response> head() async {
  var headers = {
    'Content-Type': 'application/json',
    'Keep-Alive': 'timeout=5, max=1000',
    'Access-Control-Allow-Origin': '*',
    'Accept': 'application/json',
  };
  var uri = Uri(
      scheme: kDefaultSchema,
      host: kDefaultServer,
      port: kDefaultServerPort,
      path: kDefaultConnectPath);
  var res = await http.head(uri, headers: headers);

  return res;
}

Future<http.Response> fetch(method, body, uri) async {
  if (defaultToken == null) {
    var res = await head();
    defaultToken = res.headers['token'];
  }
  Map<String, String> headers = {
    'token': defaultToken ?? '',
    'Content-Type': 'application/json',
    'Keep-Alive': 'timeout=5, max=1000',
    'Access-Control-Allow-Origin': '*',
    'Accept': 'application/json',
  };
  if (defaultToken != null) {
    if (method == 'GET') {
      return await http.get(uri, headers: headers);
    }
    return await http.post(uri, headers: headers, body: json.encode(body));
  }
  return http.Response('', 500);
}

Future<dynamic> fetchhandler(scheme, host, port, path, method, body) async {
  http.Response response = http.Response("", 201);
  try {
    if (method == 'GET') {
      response = await fetch(
          method,
          body,
          Uri(
              scheme: scheme,
              host: host,
              port: port,
              path: path,
              queryParameters: body));
    } else {
      response = await fetch(method, body,
          Uri(scheme: scheme, host: host, port: port, path: path));
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to connect');
    }
  } catch (e) {
    return {
      'state': false,
      'data': null,
      'message': "Service is temporarily unavailable, please try again later",
      'code': response.statusCode
    };
  }
}
