// ignore_for_file: prefer_function_declarations_over_variables
import 'package:yaml/yaml.dart';
import '../index.dart';

Function saveTour = () async {
  try {
    if (!generated) {
      var payload = globalctx.payload.toString();
      var yaml = loadYaml(payload);
      var data = (yaml.toString());
      var res = await fetchhandler(kDefaultSchema, kDefaultServer,
          kDefaultServerPort, kDefaultTourEdit, 'POST', {
        "state": "new",
        "id": globalctx.memory["tour"]["code"],
        "data": data
      });
      if (res.statusCode == 200 && res["state"]) {
        generated = true;
      }
    }
  } catch (e) {
    generated = false;
  }
};
