import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:naver_crs/index.dart';

Future fetchhandler(scheme, host, port, path, method, body) async {
  var res = http.Response('', 500);
  try {
    if (method == 'GET') {
      res = await fetch(
          method,
          body,
          Uri(
              scheme: scheme,
              host: host,
              port: port,
              path: path,
              queryParameters: body));
    } else {
      res = await fetch(method, body,
          Uri(scheme: scheme, host: host, port: port, path: path));
    }

    if (res.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(res.body);
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

Future fetch(method, body, uri) async {
  var rule = defaultToken == null || defaultToken == "None";
  var res = http.Response('', 500);
  if (rule) {
    res = await head();
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

Future head() async {
  var uri = Uri(
      scheme: kDefaultSchema,
      host: kDefaultServer,
      port: kDefaultServerPort,
      path: kDefaultConnectPath);
  var res = await http.head(uri);
  return res;
}

Future goFetch(rule, method, uri, body) async {
  var res = http.Response('', 500);
  if (!rule) {
    Map<String, String> headers = {
      'token': defaultToken ??
          'gAAAAABhjtSOlFafpsgJ70Sx11gM7Iv_6RuTpnOs1UWf4ELEnYC1gsvx7E2OZjRAUkkflPMXqR7ua7MtC7Y3LCWoB8uo5lmBV-Sns1lIpIy0YPuPXhdPx96We9xqbRcEylp8Fz91PAQf',
      'Content-Type': 'application/json',
      // 'Keep-Alive': 'timeout=5, max=1000',
      'Access-Control-Allow-Origin': '*',
      'Accept': 'application/json',
    };
    if (method == 'GET') {
      res = await http.get(uri, headers: headers);
      return res;
    }
    res = await http.post(uri, headers: headers, body: json.encode(body));
    return res;
  }
  return res;
}
