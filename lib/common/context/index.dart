// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

import 'package:get/get.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:flutter/services.dart' show rootBundle;

// ignore: prefer_function_declarations_over_variables
Function(String) load = (file) async {
  Future<String> getJson(String file) {
    return rootBundle.loadString("data/$file.json");
  }

  return json.decode(await getJson(file));
};

// ignore: mixin_inherits_from_not_object
class Context with PropertyChangeNotifier<String> {
  RxBool value = true.obs;
  RxList<dynamic> destinationlist = [].obs;
  RxList<dynamic> experiencelist = [].obs;
  Rx<Map<String, dynamic>> context = Rx({
    "index": 0.obs,
    "icons": {}.obs,
    "session": {"avatar": "".obs},
    "data": load("data"),
    "experiences": load("experiences"),
    "destinations": load("destinations"),
    "countries": load("countries")
  }.obs);
  void set_context(key, value) {
    context.value[key] = value;
    notifyListeners(key);
  }

  dynamic get_context(key) {
    return context.value[key];
  }
}

Context globalctx = Context();
setContext(key, value) {
  globalctx.set_context(key, value);
}

getContext(key) {
  return globalctx.get_context(key);
}
