// ignore_for_file: non_constant_identifier_names
import 'package:get/get.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

// ignore: mixin_inherits_from_not_object
class Context with PropertyChangeNotifier<String> {
  void set_context(key, value) {
    context.value[key] = value;
    notifyListeners(key);
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
