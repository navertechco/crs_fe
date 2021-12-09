// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

// ignore: mixin_inherits_from_not_object
class Context with PropertyChangeNotifier<String> {
  RxBool value = true.obs;
  RxList<dynamic> destinationlist = [].obs;
  RxList<dynamic> experiencelist = [].obs;
  Rx<Map<String, dynamic>> context = Rx({
    "index": 0.obs,
    "icons": {}.obs,
    "session": {"avatar": "".obs},
    "experiences": {
      "northern": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Northern Highlands",
        "assets/custom/img/1x/Recurso_309mdpi.png",
        "assets/custom/img/1x/Recurso_308mdpi.png"
      ],
      "southern": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Southern Highlands",
        "assets/custom/img/1x/Recurso_300mdpi.png",
        "assets/custom/img/1x/Recurso_225mdpi.png"
      ],
      "galapagos": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Galápagos",
        "assets/custom/img/1x/Recurso_565mdpi.png",
        "assets/custom/img/1x/Recurso_564mdpi.png"
      ],
      "volcano": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Volcano ",
        "assets/custom/img/1x/Recurso_304mdpi.png",
        "assets/custom/img/1x/Recurso_303mdpi.png"
      ],
      "amazon": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Amazon ",
        "assets/custom/img/1x/Recurso_293mdpi.png",
        "assets/custom/img/1x/Recurso_292mdpi.png"
      ],
      "quito": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Quito",
        "assets/custom/img/1x/Recurso_216mdpi.png",
        "assets/custom/img/1x/Recurso_215mdpi.png"
      ],
      "guayaquil": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Quayaquil",
        "assets/custom/img/1x/Recurso_214mdpi.png",
        "assets/custom/img/1x/Recurso_213mdpi.png"
      ],
      "cuenca": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Cuenca",
        "assets/custom/img/1x/Recurso_204mdpi.png",
        "assets/custom/img/1x/Recurso_203mdpi.png"
      ],
      "otavalo": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Otavalo",
        "assets/custom/img/1x/Recurso_202mdpi.png",
        "assets/custom/img/1x/Recurso_201mdpi.png"
      ],
      "coast": [
        "assets/custom/img/1x/Recurso_191mdpi.png",
        "Coast",
        "assets/custom/img/1x/Recurso_374mdpi.png",
        "assets/custom/img/1x/Recurso_192mdpi.png"
      ],
    },
    "destinations": {
      "northern": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Northern Highlands",
        "assets/custom/img/1x/Recurso_309mdpi.png",
        "assets/custom/img/1x/Recurso_308mdpi.png"
      ],
      "southern": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Southern Highlands",
        "assets/custom/img/1x/Recurso_300mdpi.png",
        "assets/custom/img/1x/Recurso_225mdpi.png"
      ],
      "galapagos": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Galápagos",
        "assets/custom/img/1x/Recurso_565mdpi.png",
        "assets/custom/img/1x/Recurso_564mdpi.png"
      ],
      "volcano": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Volcano ",
        "assets/custom/img/1x/Recurso_304mdpi.png",
        "assets/custom/img/1x/Recurso_303mdpi.png"
      ],
      "amazon": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Amazon ",
        "assets/custom/img/1x/Recurso_293mdpi.png",
        "assets/custom/img/1x/Recurso_292mdpi.png"
      ],
      "quito": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Quito",
        "assets/custom/img/1x/Recurso_216mdpi.png",
        "assets/custom/img/1x/Recurso_215mdpi.png"
      ],
      "guayaquil": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Quayaquil",
        "assets/custom/img/1x/Recurso_214mdpi.png",
        "assets/custom/img/1x/Recurso_213mdpi.png"
      ],
      "cuenca": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Cuenca",
        "assets/custom/img/1x/Recurso_204mdpi.png",
        "assets/custom/img/1x/Recurso_203mdpi.png"
      ],
      "otavalo": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Otavalo",
        "assets/custom/img/1x/Recurso_202mdpi.png",
        "assets/custom/img/1x/Recurso_201mdpi.png"
      ],
      "coast": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Coast",
        "assets/custom/img/1x/Recurso_193mdpi.png",
        "assets/custom/img/1x/Recurso_192mdpi.png"
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
