// ignore_for_file: prefer_function_declarations_over_variables
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/pages/2/searcher/widgets/index.dart';
import 'package:naver_crs/pages/7/endservices/widgets/index.dart';
import 'package:sweetalert/sweetalert.dart';
import '../constants.dart';
import '../index.dart';
export 'dayfunctions.dart';
export './destinationfunctions.dart';
export './experiencefunctions.dart';

// Other Functions
Future<bool> getCatalog(
  List<String> catalogs,
) async {
  var res = await fetchhandler(kDefaultSchema, kDefaultServer,
      kDefaultServerPort, kDefaultCatalogPath, 'POST', {
    "data": {"catalogs": catalogs}
  });
  // ignore: avoid_print
  log(res);
  if (res['state'] == true) {
    setContext("catalogs", res['data']);
    return true;
  } else {
    return false;
  }
}

RxList<Map<String, dynamic>> daysCatalog = <Map<String, dynamic>>[].obs;

Function processCatalog = (name) {
  var catalogs = getContext("catalogs");
  List<Map<String, dynamic>> catalog = [];
  if (catalogs != null) {
    var items = catalogs[name];
    if (items != null) {
      for (var item in items) {
        Map<String, dynamic> row = {};
        row["code"] = item["code"];
        row["description"] = item["description"];
        row["value"] = item["value"];
        row["relation"] = item["relation"];
        catalog.add(row);
      }
    }
  }
  return catalog;
};

Function getDateValue = (data, key, {def}) {
  try {
    if (data ?? true) {
      if (data[key] ?? true) {
        return DateTime.parse(data[key]);
      }
    } else {
      return def;
    }
  } catch (e) {
    return def;
  }
};
Function getValue = (data, key, {def}) {
  try {
    if (data ?? true) {
      if (data[key] ?? true) {
        return data[key].toString();
      }
    } else {
      return def;
    }
  } catch (e) {
    return def;
  }
};
Function validateData = (data) {
  return data != null ? data.length > 0 : false;
};
Function getData = (data, sub, key) {
  // ignore: invalid_use_of_protected_member
  return data != null && data[sub] != null
      // ignore: invalid_use_of_protected_member
      ? data[sub][key]
      : "0";
};
Function getDataList = (data, sub, key) {
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
Function globalctxReset = () {
  globalctx.reset.value = true;
  resetLeftDays();
  resetDestinations();
  updateDraggableDestinations();
  filterDestinations();
  // resetExperiences();
};

Function getItems = (data, value) {
  RxList<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[].obs;
  List<Map<String, dynamic>> data2 = [];
  data2.add({"code": "0", "description": "Choose a Option"});
  if (data.isNotEmpty) {
    items = <DropdownMenuItem<String>>[].obs;
    data2.addAll(data);
    data2.asMap().forEach((index, item) {
      var description = item["description"];

      if (description.contains("-")) {
        description = item["description"].split("-").toList()[0].toString() +
            " " +
            item["description"].split("-").toList()[1].toString() +
            " " +
            item["description"].split("-").toList()[2].toString();
      }

      items.add(DropdownMenuItem(
        value: item["code"].toString(),
        child: Text(description),
      ));
    });
  }
  return items;
};
Function chunkMap = (data, int portion, List<Map<String, dynamic>> list) {
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
      Map<String, dynamic> item = list[index];
      String code = item["code"];
      item["value"] = data[code];
      chunks[i].add(item);
    }
  }
  return chunks;
};
Function isMobileDevice = () {
  if ((defaultTargetPlatform == TargetPlatform.iOS) ||
      (defaultTargetPlatform == TargetPlatform.android)) {
    // Some android/ios specific code
    return true;
  }
  return false;
};
Function setData = (data, key, value) {
  data[key] = value;
};

Function getRXValue = (data, key, def) {
  try {
    return data[key].value;
  } catch (e) {
    return def;
  }
};

Function getFormValue = (data, formKey, key, def) {
  formKey = formKey.toString();
  if (data != null) {
    if (data[formKey] != null) {
      if (data[formKey][key] != null) {
        if (data[formKey][key] == "") {
          return def;
        }
        return data[formKey][key] ?? def;
      }
    }
  }
  return def;
};
Function getFormDateValue = (data, formKey, key, def) {
  if (data != null) {
    if (data[formKey] != null) {
      if (data[formKey][key] != null) {
        if (data[formKey][key] == "") {
          return DateTime.parse(def);
        }
        return DateTime.parse(data[formKey][key]);
      }
    }
  }
  return DateTime.parse(def);
};
Function toCatalog = (item) {
  List list = item.values.toList();
  CatalogDto ctlg = CatalogDto(list);
  return ctlg;
};
Function parseIntValue = (value) {
  if (value is int) {
    return value;
  }
  value ??= "0";
  if (value == "") {
    value = "0";
  }
  value = value.replaceAll(RegExp(r'[^0-9]'), '').replaceAll("-", "");
  return int.parse(value);
};
Function setFormValue = (data, formKey, key, value) {
  try {
    data ??= {}.obs;
    formKey = formKey.toString();
    if (data[formKey] == null) {
      data[formKey] = {}.obs;
    }
    data[formKey][key] = value;
  } catch (e) {
    log(e);
  }
};
dynamic myEncode(dynamic item) {
  if (item is DateTime || item is Map) {
    return item.toIso8601String();
  }
  return item;
}

Function getCountryNameById = (id) {
  var country = destinationCountry
      .firstWhere((element) => element["code"] == int.parse(id));
  var name = country["description"];
  return name;
};

Future<void> showCustomDialog(context, Widget child, String button,
    {Color backgroundColor = Colors.black54,
    Color buttonColor = Colors.black54,
    onSaved}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: backgroundColor,
        content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5, child: child),
        actions: <Widget>[
          TextButton(
            child: Text(button,
                style: KTextSytle(
                        context: context,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: buttonColor)
                    .getStyle()),
            onPressed: () {
              if (onSaved != null) {
                onSaved();
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Function findTravelRhythmDescription = (int code) {
  var travelData = processCatalog("travel_rhythm").toList();
  var description = travelData
      .firstWhere((element) => element["code"] == code)["description"];
  return description;
};
Function parseInt = (value) {
  if (value is String) {
    return int.parse(value);
  }
  return value;
};
Function multiDropDownKaAgeFilter = (trCatalog, travelRhytmAges) {
  return trCatalog.value.where((value) {
    var code = value["code"];
    for (var i = 0; i < travelRhytmAges.keys.length; i++) {
      var range = [
        travelRhytmAges.keys.toList()[i],
        travelRhytmAges.keys
            .toList()[i >= travelRhytmAges.keys.length - 1 ? i : i + 1]
      ];
      if (customerAge.value < 20) {
        return true;
      }
      if (customerAge.value >= range[0] && customerAge.value <= range[1]) {
        if (travelRhytmAges[range[0]]!.contains(code.toString())) {
          return true;
        }
      }
    }
    return false;
  }).toList() as List<Map<String, dynamic>>;
};

Function log = (e) {
  print(e);
};

Function promoteLeisureTime = () {
  var value = getFormValue(
      globalctx.memory["days"], currentDay.value, "leisureTime", 0);
  processHour(value);
  promoteExperience("Leisure Time");
};

Function setLT = (value) {
  int ltindex =
      expList.indexWhere((element) => element["description"] == "Leisure Time");
  globalctx.context.value["catalogs"]["experiences"][ltindex]["value"]
          ["exptime"] ==
      value;
  experiences = processCatalog("experiences");
};

Future<void> getTour(ctx, {int tourId = 0}) async {
  var frame = {
    "data": {"tour_id": tourId}
  };
  var res = await fetchhandler(kDefaultSchema, kDefaultServer,
      kDefaultServerPort, kDefaultFindTour, 'POST', frame);
  // ignore: avoid_print
  log(res);
  if (res['state'] == true) {
    var data = res['data'];
    if (data.length > 0) {
      globalctx.memory["tours"] = data;
      if (tourId == 0) {
        Get.toNamed("/Searcher");
      } else {
        Get.toNamed("/Tour");
      }
    }
  } else {
    SweetAlert.show(ctx,
        curve: ElasticInCurve(),
        title: res['message'],
        style: SweetAlertStyle.error, onPress: (bool isConfirm) {
      Get.close(1);
      return false;
    });
  }
}

Function filterData = (context, value) {
  searchResult!.value = value;
  filteredData.value = data
      .where((quote) =>
          quote["date"].contains(searchResult!.value) ||
          quote["name"].contains(searchResult!.value) ||
          quote["quote"].contains(searchResult!.value))
      .toList();
  var detail = getDetail(context, filteredData);
  searcherDetail.value = (detail);
};
Function processNetRateData = (context, data) {
  var header = getNetRateHeader(context, data);
  var detail = getNetRateDetail(context, data);
  return [header, detail];
};

Function processData = (context, data) {
  var header = getHeader(context, data);
  var detail = getDetail(context, data);
  return [header, detail];
};

Function getNetRateHeader = (context, data) {
  var header = <DataColumn>[];
  if (data.length > 0) {
    for (var key in data[0].keys) {
      String title = key ?? "";
      header.add(DataColumn(
        label: Text(
          '${title.capitalize}',
          style: KTextSytle(
            context: context,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 204, 164, 61),
          ).getStyle(),
        ),
      ));
    }
  }

  return header;
};
Function getHeader = (context, data) {
  var header = <DataColumn>[];
  if (data.length > 0) {
    for (var key in data[0].keys) {
      String title = key ?? "";
      header.add(DataColumn(
        label: Text(
          '${title.capitalize}',
          style: KTextSytle(
            context: context,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 204, 164, 61),
          ).getStyle(),
        ),
      ));
    }
    header.add(DataColumn(
      label: Text(
        'Actions',
        style: KTextSytle(
          context: context,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 204, 164, 61),
        ).getStyle(),
      ),
    ));
  }

  return header;
};

Function getDetail = (context, data) {
  var detail = <DataRow>[];
  if (data.length > 0) {
    for (var row in data) {
      var cells = <DataCell>[];
      for (var key in row.keys) {
        cells.add(DataCell(Text('${row[key]}',
            style: KTextSytle(
                    context: context,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)
                .getStyle())));
      }
      cells.add(
        DataCell(Row(
          children: [
            IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              tooltip: 'PDF',
              onPressed: () {
                showCustomDialog(
                    context,
                    WebView(
                      url:
                          "$kDefaultSchema://$kDefaultServer:$kDefaultServerPort/pdf.html",
                    ),
                    "Close",
                    buttonColor: Colors.white);
              },
            ),
            IconButton(
              icon: const Icon(Icons.money),
              tooltip: 'Net Rate',
              onPressed: () {
                showCustomDialog(context, TotalNetRateWidget(row: row), "Close",
                    buttonColor: Colors.white);
              },
            ),
            IconButton(
              icon: const Icon(Icons.mode_edit),
              tooltip: 'Edit',
              onPressed: () {
                getTour(context, tourId: row["quote"]);
              },
            ),
          ],
        )),
      );
      detail.add(DataRow(cells: cells));
    }
  }

  return detail;
};

Function getNetRateDetail = (context, data) {
  var detail = <DataRow>[];
  if (data.length > 0) {
    for (var row in data) {
      var cells = <DataCell>[];
      for (var key in row.keys) {
        cells.add(DataCell(Text('${row[key]}',
            style: KTextSytle(
                    context: context,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)
                .getStyle())));
      }

      detail.add(DataRow(cells: cells));
    }
  }

  return detail;
};

String getTimeStringFromDouble(double value) {
  if (value < 0) return 'Invalid Value';
  int flooredValue = value.floor();
  double decimalValue = value - flooredValue;
  String hourValue = getHourString(flooredValue);
  String minuteString = getMinuteString(decimalValue);

  return '$hourValue:$minuteString';
}

String getMinuteString(double decimalValue) {
  return '${(decimalValue * 60).toInt()}'.padLeft(2, '0');
}

String getHourString(int flooredValue) {
  return '${flooredValue % 24}'.padLeft(2, '0');
}

Function goto = (page) {
  selectedIndex.value = pageList.indexOf(page);
  Get.toNamed("/$page");
};

Future<void> logout(
  username,
) async {
  var res = await fetchhandler(kDefaultSchema, kDefaultServer,
      kDefaultServerPort, kDefaultConnectPath, 'POST', {
    "state": "logout",
    "data": {"username": username}
  });

  if (res['state'] == true) {
    selectedIndex.value = 0;
    Get.toNamed("/Splash");
  } else {
    log(res["message"]);
  }
}

Function getTrColor = (tr) {
  
  var color = {
    "SOFT": Colors.green,
    "MEDIUM": Colors.yellow,
    "HARD": Colors.red
  };

  return color[tr.toString().toUpperCase()];
};
