// ignore_for_file: non_constant_identifier_names, prefer_function_declarations_over_variables, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:google_fonts/google_fonts.dart';
import 'context/index.dart';
import 'index.dart';
export './variables.dart';
export './functions/functions.dart';

/*
 * DATOS DE SERVIDOR
 */

class KTextSytle {
  var getStyle;
  KTextSytle(
      {context,
      fontSize,
      fontWeight,
      disabled = false,
      color = const Color.fromARGB(255, 0, 0, 0)}) {
    getStyle = () {
      return GoogleFonts.poppins(
          textStyle: TextStyle(
        color: color,
        fontSize: MediaQuery.of(context).size.width /
            MediaQuery.of(context).size.height *
            fontSize,
        fontWeight: fontWeight ?? FontWeight.normal,
      ));
    };
  }
}

const kDefaultSchema = "http";
const kDefaultServer = "uiodesign.fortiddns.com";
const kDefaultServerPort = 9999;
const kDefaultCatalogPath = "/System/FindCatalog";
const kDefaultQueryPath = "/Agent/Query";
const kDefaultDestinationPath = "/Agent/GetDestination";
const kDefaultExperiencePath = "/Agent/GetExperience";
const kDefaultConnectPath = "/User/Connect";
const kDefaultSendPollPath = "/Gamer/SendPoll";
const kDefaultBuyCreditsPath = "/Gamer/BuyCredit";
const kDefaultJoinTournmanetPath = "/Gamer/JoinTournament";
const kDefaultFindTour = "/Tour/FindTour";
const kDefaultTourEdit = "/Tour/Edit";
const kDefaultCreateCatalog = "/Admin/CreateCatalog";

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
