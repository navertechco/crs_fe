import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:naver_crs/index.dart';

/// ## fetchHandler
/// *__Method Handler to fetch methods from REST API__*
///
///### Uses:
/// ```dart
///  var res = await fetchHandler(kDefaultSchema, kDefaultServer,
///      kDefaultServerPort, kDefaultConnectPath, 'POST', {
///    "state": "logOut",
///    "data": {"username": username}
///  });
/// ```
Future fetchHandler(scheme, host, port, path, method, body) async {
  var res = http.Response('', 500);
  try {
    if (method == 'GET') {
      res = await fetchWithToken(
          method,
          body,
          Uri(
              scheme: scheme,
              host: host,
              port: port,
              path: path,
              queryParameters: body));
    } else {
      res = await fetchWithToken(method, body,
          Uri(scheme: scheme, host: host, port: port, path: path));
    }

    if (res.statusCode == 200) {
      var jsonResponse = json.decode(res.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to connect');
    }
  } catch (e) {
    
    return {
      'state': false,
      'data': null,
      'message': "Service is temporarily unavailable, please try again later",
      'code': res.statusCode
    };
  }
}

/// ## fetchWithToken
/// *__Method to manage sending request with token to REST API__*
///
///### Uses:
/// ```dart
///  res = await fetchWithToken(method, body,
///          Uri(scheme: scheme, host: host, port: port, path: path));
/// ```
Future fetchWithToken(method, body, uri) async {
  var rule = defaultToken == null || defaultToken == "None";
  var res = http.Response('', 500);
  if (rule) {
    res = await getNewToken();
    if (res.statusCode == 200) {
      defaultToken = res.headers['token'] == "None"
          ? 'gAAAAABhjtSOlFafpsgJ70Sx11gM7Iv_6RuTpnOs1UWf4ELEnYC1gsvx7E2OZjRAUkkflPMXqR7ua7MtC7Y3LCWoB8uo5lmBV-Sns1lIpIy0YPuPXhdPx96We9xqbRcEylp8Fz91PAQf'
          : res.headers['token'];
      rule = false;
      res = await goFetch(rule, method, uri, body);
    }
  } else {
    res = await goFetch(rule, method, uri, body);
  }
  return res;
}

/// ## getNewToken
/// *__Method to get new Token from REST API__*
///
///### Uses:
/// ```dart
///  res = await getNewToken();
/// ```
Future getNewToken() async {
  var uri = Uri(
      scheme: kDefaultSchema,
      host: kDefaultServer,
      port: kDefaultServerPort,
      path: kDefaultConnectPath);
  var res = await http.head(uri);
  return res;
}

/// ## goFetch
/// *__Method to finaly fetch to REST API__*
///
///### Uses:
/// ```dart
///  res = await goFetch(rule, method, uri, body);
/// ```
Future goFetch(rule, method, uri, body) async {
  var res = http.Response('', 500);
  var _client = http.Client();
  try {
    if (!rule) {
      Map<String, String> headers = {
        'token': defaultToken ??
            'gAAAAABhjtSOlFafpsgJ70Sx11gM7Iv_6RuTpnOs1UWf4ELEnYC1gsvx7E2OZjRAUkkflPMXqR7ua7MtC7Y3LCWoB8uo5lmBV-Sns1lIpIy0YPuPXhdPx96We9xqbRcEylp8Fz91PAQf',
        'Content-Type': 'application/json; charset=UTF-8',
        "Connection": "Keep-Alive",
        "Keep-Alive": "timeout=5, max=1000",
        'Access-Control-Allow-Origin': '*',
        'Accept': 'application/json',
      };
      if (method == 'GET') {
        res = await _client.get(uri, headers: headers);
        return res;
      }
      res = await _client.post(uri,
          headers: headers,
          body: json.encode(body));
      return res;
    }
  } catch (e) {
    log(e);
  }

  return res;
}
