// ignore_for_file: prefer_function_declarations_over_variables

import 'dart:convert';
import 'dart:math';

import '../index.dart';

Function saveTour = (data) async {
  var json = data.value.toString();
  var res = await fetchhandler(kDefaultSchema, kDefaultServer,
      kDefaultServerPort, kDefaultCreateCatalog, 'POST', {
    "data": {
      "catalog_id": 40,
      "order": 0,
      "description": "TOUR TEST 1234",
      "is_active": true,
      "code": 121,
      "value": json
    }
  });
  print(res);
};
