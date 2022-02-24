// ignore_for_file: prefer_function_declarations_over_variables
import '../index.dart';
import 'package:yaml/yaml.dart';

Function sendTour = (data) async {
  var tour = data.value;
  var description = tour["tour"]["dataTravel"];
  var payload = tour.toString();
  var yaml = loadYaml(payload);
  print(yaml);
  var res = await fetchhandler(kDefaultSchema, kDefaultServer,
      kDefaultServerPort, kDefaultCreateCatalog, 'POST', {
    "state": "tour",
    "data": {
      "catalog_id": 40,
      "order": 0,
      "description": description,
      "is_active": true,
      "code": 1,
      "value": yaml.toString()
    }
  });
  print(res);
};
