// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

// ignore: mixin_inherits_from_not_object
class Context with PropertyChangeNotifier<String> {
  RxBool value = true.obs;
  RxList<dynamic> destinationlist = [].obs;
  Rx<Map<String, dynamic>> context = Rx({
    "index": 0.obs,
    "icons": {}.obs,
    "session": {"avatar": "".obs},
    "destinations": {
      "northern": [
        "assets/custom/img/1x/Recurso 318mdpi.png",
        "Northern Highlands",
        "assets/custom/img/1x/Recurso 309mdpi.png",
        "assets/custom/img/1x/Recurso 308mdpi.png"
      ],
      "southern": [
        "assets/custom/img/1x/Recurso 318mdpi.png",
        "Southern Highlands",
        "assets/custom/img/1x/Recurso 300mdpi.png",
        "assets/custom/img/1x/Recurso 225mdpi.png"
      ],
      "galapagos": [
        "assets/custom/img/1x/Recurso 318mdpi.png",
        "Galápagos",
        "assets/custom/img/1x/Recurso 565mdpi.png",
        "assets/custom/img/1x/Recurso 564mdpi.png"
      ],
      "volcano": [
        "assets/custom/img/1x/Recurso 318mdpi.png",
        "Volcano ",
        "assets/custom/img/1x/Recurso 304mdpi.png",
        "assets/custom/img/1x/Recurso 303mdpi.png"
      ],
      "amazon": [
        "assets/custom/img/1x/Recurso 318mdpi.png",
        "Amazon ",
        "assets/custom/img/1x/Recurso 293mdpi.png",
        "assets/custom/img/1x/Recurso 292mdpi.png"
      ],
      "quito": [
        "assets/custom/img/1x/Recurso 318mdpi.png",
        "Quito",
        "assets/custom/img/1x/Recurso 216mdpi.png",
        "assets/custom/img/1x/Recurso 215mdpi.png"
      ],
      "guayaquil": [
        "assets/custom/img/1x/Recurso 318mdpi.png",
        "Quayaquil",
        "assets/custom/img/1x/Recurso 214mdpi.png",
        "assets/custom/img/1x/Recurso 213mdpi.png"
      ],
      "cuenca": [
        "assets/custom/img/1x/Recurso 318mdpi.png",
        "Cuenca",
        "assets/custom/img/1x/Recurso 204mdpi.png",
        "assets/custom/img/1x/Recurso 203mdpi.png"
      ],
      "otavalo": [
        "assets/custom/img/1x/Recurso 318mdpi.png",
        "Otavalo",
        "assets/custom/img/1x/Recurso 202mdpi.png",
        "assets/custom/img/1x/Recurso 201mdpi.png"
      ],
      "coast": [
        "assets/custom/img/1x/Recurso 318mdpi.png",
        "Coast",
        "assets/custom/img/1x/Recurso 193mdpi.png",
        "assets/custom/img/1x/Recurso 192mdpi.png"
      ],
    }
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
