import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Context {
  static Map<String, dynamic> context = {
    "index": 0,
    "session": {"avatar": "".obs}
  };

  static void set_context(key, value) {
    context[key] = value;
  }

  static dynamic get_context(key) {
    return context[key];
  }
}

setContext(key, value) {
  Context.set_context(key, value);
}

getContext(key) {
  return Context.get_context(key);
}
