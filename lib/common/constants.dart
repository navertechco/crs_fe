// ignore_for_file: non_constant_identifier_names, prefer_function_declarations_over_variables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweetalert/sweetalert.dart';
import 'context/index.dart';
import 'index.dart';

/*
 * DATOS DE SERVIDOR
 */

Function removeFromArray = (array, item) {
  if (array.contains(item)) {
    var index = array.indexOf(item);
    array.value.removeAt(index);
    if (globalctx.experienceDragData.value.isNotEmpty) {
      if (globalctx.experienceDragData.value.length == array.value.length) {
        globalctx.experienceDragData.value.removeAt(index);
      } else {
        var newIndex = index > 0 ? index - 1 : 0;
        globalctx.experienceDragData.value.removeAt(newIndex);
      }
    }
  }
};

Function removeExperience = (experience) {
  removeFromArray(globalctx.selected, experience);
  removeFromArray(globalctx.promoted, experience);
};

var KTextSytle = (context, fontSize, fontWeight) => GoogleFonts.poppins(
        textStyle: TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: MediaQuery.of(context).size.width /
          MediaQuery.of(context).size.height *
          fontSize,
      fontWeight: fontWeight ?? FontWeight.normal,
    ));

const kDefaultSchema = "http";
const kDefaultServer = "192.168.101.4";
const kDefaultServerPort = 9999;
const kDefaultCatalogPath = "/System/FindCatalog";
const kDefaultQueryPath = "/Agent/Query";
const kDefaultDestinationPath = "/Agent/GetDestination";
const kDefaultExperiencePath = "/Agent/GetExperience";
const kDefaultConnectPath = "/User/Connect";
const kDefaultSendPollPath = "/Gamer/SendPoll";
const kDefaultBuyCreditsPath = "/Gamer/BuyCredit";
const kDefaultJoinTournmanetPath = "/Gamer/JoinTournament";

//DIMENSIONES
var kDefaultPadding = 20.0;
const kDefaultRadius = BorderRadius.all(Radius.circular(8.0));
const kFontSize = 72.0;
var kSize = getContext('size');

///COLORES

const kPrimaryColor = Color(0xFFFFFFFF);
const kPrimaryLightColor = Color(0xFFF6F6F6);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFFFFF), Color(0xFFF6F6F6)],
);
const kSecondaryColor = Color(0xFFE0E0E0);
const kTextColor = Color(0xFF0D0D0D);
const kTextLightColor = Color(0xFFB4B4B4);
const kBlueColor = Color(0xFF40BAD5);
const kShadowColor = Color(0xFFE0E0E0);
const kShadowLightColor = Color(0xFFB4B4B4);
const kShadowDarkColor = Color(0xFF707070);
const kShadowGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF707070), Color(0xFFB4B4B4)],
);

const kBackgroundColor = Color(0xFFF6F6F6);

//BORDES
const kDefaultBorder = BorderRadius.all(Radius.circular(8.0));
const kDefaultBorderLight = BorderRadius.all(Radius.circular(4.0));
const kDefaultBorderDark = BorderRadius.all(Radius.circular(4.0));
const kDefaultBorderGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF707070), Color(0xFFB4B4B4)],
);
const kDefaultBorderGradientLight = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFB4B4B4), Color(0xFF707070)],
);
const kDefaultBorderGradientDark = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF707070), Color(0xFFB4B4B4)],
);
const kDefaultBorderGradientLightDark = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFB4B4B4), Color(0xFF707070)],
);
const kDefaultBorderGradientDarkLight = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFB4B4B4), Color(0xFF707070)],
);
const kDefaultBorderGradientDarkDark = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFB4B4B4), Color(0xFF707070)],
);
const kDefaultBorderGradientLightLight = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFB4B4B4), Color(0xFF707070)],
);

//VALIDADORES
final passwordValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ],
);

final idValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'id is required'),
    MinLengthValidator(10, errorText: 'id must be at least 10 digits long'),
    PatternValidator(r'^[0-9]*$', errorText: 'id must have only numbers')
  ],
);

class MaxIntValidator extends FieldValidator<int> {
  int maxValue;
  MaxIntValidator({required String errorText, required this.maxValue})
      : super(errorText);

  @override
  bool isValid(value) {
    if (value > maxValue) return false;
    return true;
  }
}

final maxValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'id is required'),
    MaxIntValidator(errorText: 'mayyor a 100', maxValue: 100),
    PatternValidator(r'^[0-9]*$', errorText: 'id must have only numbers')
  ],
);

final isMobileDevice = () {
  if ((defaultTargetPlatform == TargetPlatform.iOS) ||
      (defaultTargetPlatform == TargetPlatform.android)) {
    // Some android/ios specific code
    return true;
  }
  return false;
};

final chunkMap =
    (Map<String, dynamic> data, int portion, List<Map<String, dynamic>> list) {
  List<List<Map<String, dynamic>>> chunks = [];
  if (data != null) {
    int aprox = (list.length / portion).round() * portion;
    int module = aprox > list.length
        ? (list.length / portion).round()
        : (list.length / portion).round() + 1;

    for (var i = 0; i < module; i++) {
      chunks.add([]);
      for (var j = 0; j < portion; j++) {
        var index = (i * portion) + j;
        if (index > list.length - 1) {
          break;
        }
        Map<String, dynamic> item = list[index];
        String code = item["code"];
        item["value"] = data[code];
        chunks[i].add(item);
      }
    }
  }

  return chunks;
};

Future<bool> getCatalog(
  List<String> catalogs,
) async {
  try {
    var res = await fetchhandler(kDefaultSchema, kDefaultServer,
        kDefaultServerPort, kDefaultCatalogPath, 'POST', {
      "data": {"catalogs": catalogs}
    });
    // ignore: avoid_print
    print(res);
    if (res['state'] == true) {
      setContext("catalogs", res['data']);
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

Function processCatalog = (name) {
  var ctxCatalogs = getContext("catalogs");

  if (ctxCatalogs != null) {
    var catalogs = ctxCatalogs["catalogs"];
    List<Map<String, dynamic>> catalog = [];
    var items = catalogs[name];
    if (items != null) {
      for (var item in items) {
        Map<String, dynamic> row = {};
        row["code"] = item["code"];
        row["description"] = item["description"];
        row["value"] = item["value"];
        catalog.add(row);
      }
    }

    return catalog;
  }

  return <Map<String, dynamic>>[];
};

Function getValue = (data, key, {def}) {
  if (data != null && data.length > 0) {
    if (data[key] != null) {
      return data[key];
    }
  }

  return def;
};

Function validateData = (data) {
  return data != null ? data.length > 0 : false;
};

var getData = (data, sub, key) {
  // ignore: invalid_use_of_protected_member
  return data != null && data[sub] != null
      // ignore: invalid_use_of_protected_member
      ? data[sub][key]
      : "0";
};

var getDataList = (data, sub, key) {
  // ignore: invalid_use_of_protected_member
  return data != null && data[sub] != null
      // ignore: invalid_use_of_protected_member
      ? data[sub][key]
      : <Map<String, dynamic>>[];
};

Function getParam = (key) {
  var params = processCatalog("params");
  var child =
      params.toList().firstWhere((element) => element["description"] == key);
  return child;
};

Function cityData = (Rx<List<Map<String, dynamic>>> citylist, cities) {
  var index = 0;
  citylist.value = [];

  for (var city in cities) {
    citylist.value.add({
      "code": "$index",
      "description": city,
    });
    index++;
  }
};

var getExperiences = (String destination,
    String experience,
    List<int>? keyActivities,
    List<int>? travelRhythms,
    int? destinationOption) async {
  var res = await fetchhandler(kDefaultSchema, kDefaultServer,
      kDefaultServerPort, kDefaultExperiencePath, 'POST', {
    "data": {
      "destination": destination,
      "experience": experience,
      "key_activities": keyActivities ?? [],
      "travel_rhythms": travelRhythms ?? [],
      "destination_option": destinationOption
    }
  });

  if (res['state'] == true) {
    setContext("experiences", res['data']);
    return true;
  } else {
    return false;
  }
};

var globalctxReset = () {
  globalctx.promoted.value = [];
  globalctx.selected.value = [];
  globalctx.destinations.value = [];
  globalctx.experiences.value = [];
  globalctx.destinationDragData.value = [];
  globalctx.experienceDragData.value = [];
  // globalctx.memory = {
  //   "tour": {}.obs,
  //   "customer": {}.obs,
  //   "destinations": {}.obs,
  //   "experiences": {}.obs,
  //   "days": {}.obs
  // }.obs;
};

class CustomRequiredValidator extends TextFieldValidator {
  final ctx;
  CustomRequiredValidator({required String errorText, required this.ctx})
      : super(errorText);

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    return value != null && value != "0" && value != "0";
  }

  @override
  String? call(String? value) {
    if (isValid(value)) {
      return null;
    } else {
      SweetAlert.show(ctx,
          title: errorText,
          subtitle: 'error',
          style: SweetAlertStyle.error, onPress: (bool isConfirm) {
        Get.close(1);
        return false;
      });
      return errorText;
    }
  }
}

var CustomDatetimeRequiredValidator =
    (DateTime? date, {BuildContext? context, required String errorText}) {
  if (date == null) {
    SweetAlert.show(context,
        title: errorText,
        subtitle: 'error',
        style: SweetAlertStyle.error, onPress: (bool isConfirm) {
      Get.close(1);
      return true;
    });
  }
};

var CustomMultiDropdownRequiredValidator = (List<Map<String, dynamic>>? value,
    {BuildContext? context, required String errorText}) {
  if (value == null) {
    SweetAlert.show(context,
        title: errorText,
        subtitle: 'error',
        style: SweetAlertStyle.error, onPress: (bool isConfirm) {
      Get.close(1);
      return true;
    });
  }
};

Function setData = (data, key, value) {
  data[key] = value;
};

Function getFormValue = (data, formKey, key, def) {
  if (data.value[formKey] != null) {
    return data.value[formKey].value[key];
  }
  return def;
};

Function setFormValue = (data, formKey, key, value) {
  data ??= {}.obs;

  if (data.value[formKey] == null) {
    data.value[formKey] = {}.obs;
  }

  data.value[formKey].value[key] = value;
};

List<String> multiDefault = <String>[];
