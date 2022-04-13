// ignore_for_file: prefer_function_declarations_over_variables
import 'dart:convert';
import 'package:yaml/yaml.dart';
import '../index.dart';

Function sendTour = () async {
  var payload = globalctx.payload.toString();
  var yaml = loadYaml(payload);
  var data = (yaml.toString());
  await fetchhandler(kDefaultSchema, kDefaultServer, kDefaultServerPort,
      kDefaultTourEdit, 'POST', {"state": "www", "data": data});
};
