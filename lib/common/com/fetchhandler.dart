import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> fetch(method, body, uri) async {
  var headers = {
    'token':
        'AAABhjtSOlFafpsgJ70Sx11gM7Iv_6RuTpnOs1UWf4ELEnYC1gsvx7E2OZjRAUkkflPMXqR7ua7MtC7Y3LCWoB8uo5lmBV-Sns1lIpIy0YPuPXhdPx96We9xqbRcEylp8Fz91PAQf',
    'Content-Type': 'application/json',
    'Keep-Alive': 'timeout=5, max=1000',
    'Access-Control-Allow-Origin': '*',
    'Accept': 'application/json',
  };
  if (method == 'GET') {
    return await http.get(uri, headers: headers);
  }
  return await http.post(uri, headers: headers, body: json.encode(body));
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
      'message': e.toString(),
      'code': response.statusCode
    };
  }
}
