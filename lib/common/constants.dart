import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'context/index.dart';
import 'index.dart';

/*
 * DATOS DE SERVIDOR
 */

// ignore: prefer_function_declarations_over_variables
Function removeFromArray = (array, item) {
  if (array.contains(item)) {
    var index = array.indexWhere((element) => element == item);
    array.removeAt(index);
    globalctx.experienceDragData.value.removeAt(index);
  }
};
// ignore: prefer_function_declarations_over_variables
Function removeExperience = (experience) {
  removeFromArray(globalctx.selected, experience);
  removeFromArray(globalctx.promoted, experience);
};

// ignore: constant_identifier_names, prefer_function_declarations_over_variables, non_constant_identifier_names
var KTextSytle = (context, fontSize, fontWeight) => GoogleFonts.poppins(
        textStyle: TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: MediaQuery.of(context).size.width /
          MediaQuery.of(context).size.height *
          fontSize,
      fontWeight: fontWeight ?? FontWeight.normal,
    ));

const kDefaultSchema = "http";
const kDefaultServer = "192.168.101.3";
const kDefaultServerPort = 9999;
const kDefaultCatalogPath = "/System/FindCatalog";
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
  String errorText;
  int maxValue;
  MaxIntValidator({required this.errorText, required this.maxValue}) : super(errorText);

  @override
  bool isValid(value) {
    if (value > maxValue) return false;
    return true;
  }
}

final MaxValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'id is required'),
    MaxIntValidator(errorText: 'mayyor a 100', maxValue:100),
    PatternValidator(r'^[0-9]*$', errorText: 'id must have only numbers')
  ],
);

// ignore: prefer_function_declarations_over_variables
final isMobileDevice = () {
  if ((defaultTargetPlatform == TargetPlatform.iOS) ||
      (defaultTargetPlatform == TargetPlatform.android)) {
    // Some android/ios specific code
    return true;
  }
  return false;
};

// ignore: prefer_function_declarations_over_variables
final chunkArray = (list, int portion) {
  List<List<Map<String, dynamic>>> chunks = [];
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
      chunks[i].add(list[index]);
    }
  }
  return chunks;
};

Future<void> getCatalog(
  List<String> catalogs,
) async {
  var res = await fetchhandler(kDefaultSchema, kDefaultServer,
      kDefaultServerPort, kDefaultCatalogPath, 'POST', {
    "data": {"catalogs": catalogs}
  });
  // ignore: avoid_print
  print(res);
  if (res['state'] == true) {
    setContext("catalogs", res['data']);
  }
}

// ignore: prefer_function_declarations_over_variables
Function processCatalog = (name) {
  var ctx_catalogs = getContext("catalogs");

  if (ctx_catalogs != null) {
    var catalogs = ctx_catalogs["catalogs"];
    List<Map<String, dynamic>> catalog = [];
    var items = catalogs[name];
    if (items != null) {
      for (var item in items) {
        Map<String, dynamic> row = {};
        row["code"] = item["code"];
        row["description"] = item["description"];
        catalog.add(row);
      }
    }

    return catalog;
  }

  return <Map<String, dynamic>>[];
};
