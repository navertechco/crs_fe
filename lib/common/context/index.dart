// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

import 'package:get/get.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:flutter/services.dart' show rootBundle;

// ignore: mixin_inherits_from_not_object
class Context with PropertyChangeNotifier<String> {
  Rx<Map<String, dynamic>> context = Rx({
    "index": 0.obs,
    "icons": {}.obs,
    "session": {"avatar": "".obs},
  }.obs);

  RxBool value = true.obs;
  RxList<dynamic> destinationlist = [].obs;
  RxList<dynamic> experiencelist = [].obs;

  Context() {
    load("data");
    load("experiences");
    load("destinations");
    load("countries");
  }

  void load(file) {
    rootBundle.loadString("assets/data/$file.json").then((value) {
      context.value[file] = json.decode(value);
    });
  }

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
  print(globalctx.context);
  return globalctx.get_context(key);
}
