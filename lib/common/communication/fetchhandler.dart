import 'dart:convert';
import 'package:http/http.dart';

fetchhandler(scheme, host, port, path, metthod, body) async {
  try {
    Response response;
    var headers = {
      // 'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Accept': 'application/json',
    };

    Future<Response> _fetch(uri) async {
      if (metthod == 'GET') {
        return await get(uri, headers: headers);
      }
      return await post(uri, headers: headers, body: json.encode(body));
    }

    if (metthod == 'GET') {
      response = await _fetch(Uri(
          scheme: scheme,
          host: host,
          port: port,
          path: path,
          queryParameters: body));
    } else {
      response =
          await _fetch(Uri(scheme: scheme, host: host, port: port, path: path));
    }
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to connect');
    }
  } catch (e) {
    return {'state': false, 'data': null, 'message': e.toString(), 'code': 500};
  }
}

// main() async {
//   var res = await fectchHandler(
//       'https', 'reqbin.com', '/echo/post/json', 'POST', {
//     'Id': '78912',
//     'Customer': 'Jason Sweet',
//     'Quantity': '1',
//     'Price': '18.00'
//   });
//   print(res);
// }
