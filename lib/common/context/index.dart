// ignore_for_file: non_constant_identifier_names
import 'package:get/get.dart'; 

// ignore: mixin_inherits_from_not_object
class Context {
  void set_context(key, value) {
    context.value[key] = value;
  }

  dynamic get_context(key) {
    return context.value[key];
  }

  Rx<Map<String, dynamic>> context = Rx({
    "index": 0.obs,
    "icons": {}.obs,
    "countries": {},
    "session": {"avatar": ''.obs},
    "catalogs": {}.obs
  }.obs);
}
