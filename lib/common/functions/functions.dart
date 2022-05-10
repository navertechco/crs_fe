// ignore_for_file: prefer_function_declarations_over_variables, import_of_legacy_library_into_null_safe
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:naver_crs/pages/2/searcher/widgets/index.dart';
import 'package:naver_crs/pages/7/endservices/widgets/index.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../constants.dart';
import '../index.dart';
export 'dayfunctions.dart';
export './destinationfunctions.dart';
export './experiencefunctions.dart';

Future<void> load(key) async {
  try {
    var result = await rootBundle.loadString("assets/data/$key.json");
    setContext(key, json.decode(result));
  } catch (e) {
    log(e);
  }
}

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

Function findMemoryCatalog = (name, description) {
  var memory = globalctx.memory[name];
  List<Map<String, dynamic>> output = <Map<String, dynamic>>[];
  if (memory != null) {
    var idx = 1;
    List items = memory.map((e) => e[description]).toSet().toList();
    items.sort();
    for (var item in items) {
      Map<String, dynamic> row = {};
      row["code"] = idx;
      row["description"] = item;
      output.add(row);
      idx++;
    }
  }
  return output;
};

Function findCatalog = (name) {
  var catalogs = getContext("catalogs");
  List<Map<String, dynamic>> catalog = <Map<String, dynamic>>[];
  if (catalogs.isNotEmpty) {
    var items = catalogs[name];
    if (items != null) {
      for (var item in items) {
        catalog.add(item);
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
    return data[key] ?? def;
  } catch (e) {
    return def;
  }
};
Function setValue = (data, key, value) {
  data[key] = value;
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
  var params = findCatalog("params");
  var child =
      params.toList().firstWhere((element) => element["description"] == key);
  return child;
};
Function cityData = (Rx<List<Map<String, dynamic>>> citylist, cities) {
  var index = 1;
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

Function getItems = (data, value, hintText) {
  RxList<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[].obs;
  List<Map<String, dynamic>> data2 = [];
  data2.add({"code": "0", "description": hintText ?? "Choose a Option"});
  if (data.length > 0) {
    items = <DropdownMenuItem<String>>[].obs;
    data2.addAll(data);
    data2.asMap().forEach((index, item) {
      var description = item["description"];

      if (description.contains("-")) {
        for (var item in item["description"].split("-").toList()) {
          description += item + " ";
        }
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
  try {
    if (code == 0) {
      return "HARD";
    }
    var travelData = findCatalog("travel_rhythm").toList();
    var description = travelData
        .firstWhere((element) => element["code"] == code)["description"];
    return description;
  } catch (e) {
    log(e);
  }
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
  experiences = findCatalog("experiences");
};

Future<void> getCruise(ctx, {int cruiseId = 0}) async {
  if (globalctx.memory["cruises"] == null) {
    var frame = {
      "data": {"cruise_id": cruiseId}
    };
    var res = await fetchhandler(kDefaultSchema, kDefaultServer,
        kDefaultServerPort, kDefaultFindCruise, 'POST', frame);
    // ignore: avoid_print
    log(res);
    if (res['state'] == true) {
      var data = res['data'];
      if (data.length > 0) {
        globalctx.memory["cruises"] = data;
        showCustomDialog(
          ctx,
          CruiseCalendarWidget(ctx: ctx),
          "Close",
          backgroundColor: Colors.white,
          buttonColor: Colors.black,
        );
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
  } else {
    showCustomDialog(
      ctx,
      CruiseCalendarWidget(ctx: ctx),
      "Close",
      backgroundColor: Colors.white,
      buttonColor: Colors.black,
    );
  }
}

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

Function resetData = (context, controller) {
  var data = globalctx.memory["tours"];
  if (searchResult!.value.isNotEmpty) {
    controller.clear();
    searchResult!.value = "";
    filteredData.value = data;
    var detail = getDetail(context, filteredData);
    searcherDetail.value = (detail);
  }
};
Function filterData = (context, value) {
  var data = globalctx.memory["tours"];
  try {
    searchResult!.value = value.toString();
    if (searchResult!.value.isNotEmpty) {
      filteredData.value = data
          .where((quote) =>
              quote["date"].toString().contains(searchResult!.value) ||
              quote["name"].toString().contains(searchResult!.value) ||
              quote["quote"].toString().contains(searchResult!.value))
          .toList();
      var detail = getDetail(context, filteredData);
      searcherDetail.value = (detail);
    }
  } catch (e) {
    log(e);
  }
};
Function processNetRateData = (context, data) {
  var header = getNetRateHeader(context, data);
  var detail = getNetRateDetail(context, data);
  return [header, detail];
};

Function processCruiseData = (context, data, columns) {
  var header = getHeader(context, data, columns);
  var detail = getCruiseDetail(context, data, columns);
  return [header, detail];
};

Function processData = (context, data, columns) {
  var header = getHeader(context, data, columns);
  var detail = getDetail(context, data, columns);
  return [header, detail];
};

Function getNetRateHeader = (context, data) {
  var header = <DataColumn>[];
  if (data.length > 0) {
    for (var key in data[0].keys) {
      String title = key ?? "";
      header.add(DataColumn(
        label: Text(
          title.capitalize!.replaceAll("_", " "),
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
Function getHeader = (context, data, columns) {
  var header = <DataColumn>[];
  List cols = [];

  if (data.length > 0) {
    cols = data[0].keys.toList();
    if (columns != null) {
      cols = columns;
    }
    for (var key in cols) {
      String title = key ?? "";
      header.add(DataColumn(
        label: Text(
          title.capitalize!.replaceAll("_", " "),
          textAlign: TextAlign.left,
          style: KTextSytle(
            context: context,
            fontSize: 10,
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
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 204, 164, 61),
        ).getStyle(),
      ),
    ));
  }

  return header;
};

List<Meeting> getDataSource(data) {
  List dataList = [];
  final List<Meeting> meetings = <Meeting>[];

  for (var i = 0; i < 3; i++) {
    dataList = [...dataList, ...data.split(',').toList()];
  }
  var count = 0;
  var now = arrivalDate.value;
  var firstOfMonth = DateTime(now.year, now.month, 1);
  var firstMonday = firstOfMonth
      .add(Duration(days: (7 - (firstOfMonth.weekday - DateTime.monday)) % 7));
  var currentDay = firstMonday;
  for (var day in dataList) {
    if (day == "" || day == " ") {
      count++;
      continue;
    }

    if (currentDay.month == now.month) {
      var nextDay = currentDay.add(Duration(days: count));
      meetings
          .add(Meeting(day, nextDay, nextDay, const Color(0xFF0F8644), true));
      currentDay = nextDay;
    }
    count++;
  }
  return meetings;
}

Function getCruiseDetail = (context, data, columns) {
  var detail = <DataRow>[];
  if (data.length > 0) {
    for (var row in data) {
      var cells = <DataCell>[];
      var keys = row.keys.toList();

      if (columns != null) {
        keys = columns;
      }

      for (var key in keys) {
        cells.add(DataCell(Text('${row[key]}',
            textAlign: TextAlign.left,
            style: KTextSytle(
                    context: context,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)
                .getStyle())));
      }
      cells.add(
        DataCell(
          IconButton(
            padding: EdgeInsets.all(0),
            icon: const Icon(Icons.event_note_rounded, size: 20),
            tooltip: 'Show Cruise Itinerary',
            onPressed: () {
              showCustomDialog(
                context,
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "${row['cruise_name']}",
                        style: KTextSytle(
                          context: context,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 204, 164, 61),
                        ).getStyle(),
                      ),
                      Image.network(
                        "${row['image']}",
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.5,
                      ),
                      Text(
                        "${processCruiseItinerary(row)}",
                        style: KTextSytle(
                          context: context,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ).getStyle(),
                      ),
                      Obx(() {
                        try {
                          return SfCalendar(
                            firstDayOfWeek: 1,
                            backgroundColor: Colors.white,
                            minDate: arrivalDate.value.add(Duration(days: 1)),
                            maxDate:
                                departureDate.value.add(Duration(days: -1)),
                            view: CalendarView.month,
                            dataSource: MeetingDataSource(getDataSource(
                                "${row['cruise_itinerary']}"
                                    .replaceAll("[", " ")
                                    .replaceAll("]", " "))),
                            monthViewSettings: MonthViewSettings(
                                appointmentDisplayMode:
                                    MonthAppointmentDisplayMode.appointment),
                          );
                        } catch (e) {
                          log(e);
                          return Text(
                            "No Calendar Aivable",
                            style: KTextSytle(
                              context: context,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 204, 164, 61),
                            ).getStyle(),
                          );
                        }
                      })
                    ],
                  ),
                ),
                "Close",
                backgroundColor: Color.fromARGB(100, 0, 0, 0),
              );
            },
          ),
        ),
      );
      detail.add(DataRow(cells: cells));
    }
  }

  return detail;
};
Function getDetail = (context, data, columns) {
  var detail = <DataRow>[];
  if (data.length > 0) {
    for (var row in data) {
      var cells = <DataCell>[];
      var keys = row.keys.toList();

      if (columns != null) {
        keys = columns;
      }

      for (var key in keys) {
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
                var url =
                    "$kDefaultSchema://$kDefaultServer:$kDefaultServerPort/docx.html?doc=${row['travel_code']}";
                showCustomDialog(
                    context,
                    WebView(
                      url: url,
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
  var index = pageList.indexOf(page);
  if (selectedIndex.value != index) {
    selectedIndex.value = index;
    Get.toNamed("/$page");
  }
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
    Get.toNamed("/Signin");
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

Function getCatalogs = (catalogs) async {
  Map res = await fetchhandler(kDefaultSchema, kDefaultServer,
      kDefaultServerPort, kDefaultFindCatalog, 'POST', {
    "data": {"catalogs": catalogs}
  });
  if (res['state'] == true) {
    var entries = res['data']["catalogs"].values.toList();
    return entries;
  } else {
    log(res["message"]);
  }
};

Function newTour = () async {
  var res = await fetchhandler(kDefaultSchema, kDefaultServer,
      kDefaultServerPort, kDefaultNewTourEdit, 'POST', {});
  if (res['state'] == true) {
    globalctx.memory["tour"]["code"] = res['data']["id"];
    setContext("catalogs", res['data']["catalogs"]);
    selectedIndex.value = 0;
    Get.toNamed("/Tour");
  } else {
    log(res["message"]);
  }
};

Function multiSaving = (values, catalog, context, index, field, memory) {
  memory.value = <String>[];
  var length = values.length;

  for (var i = 0; i < length; i++) {
    memory.value.add(
        filterCatalog(catalog, "code", values[i])[0]["description"].toString());
  }

  setFormValue(context, index, field, memory.value);
};

Function filterCatalog = (catalog, key, value) {
  try {
    var res =
        findCatalog(catalog).toList().where((e) => e[key] == value).toList();
    return res;
  } catch (e) {
    log(e.toString());
    return [];
  }
};

Function savePurposes = (values) {
  if (values == null) return;
  if (values.length > 3) {
    Get.snackbar("Error", "You can select maximum 3 purposes",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 10,
        margin: EdgeInsets.all(10),
        duration: Duration(seconds: 3));
    return;
  }
  if (values.length <= 3) {
    purposeMemory.value = <String>[];
    var length = values.length;
    for (var i = 0; i < length; i++) {
      purposeMemory.value.add(filterCatalog("purposes", "code", values[i])[0]
              ["description"]
          .toString());
    }
    setFormValue(globalctx.memory, "tour", "purposes", purposeMemory.value);
  }
};

Function getDistance = (a, b, c, d) {
  return acos(sin(double.parse(c) * sin(double.parse(a)) +
          cos(double.parse(a)) *
              cos(double.parse(c)) *
              cos(double.parse(d) - double.parse(b)))) *
      6371;
};

Function filterCruises = (ctx) {
  if (globalctx.memory["cruises"] != null) {
    List filtered = globalctx.memory["cruises"];

    List filterByCategory = filtered
        .where((element) => element["cruise_category"]
            .toString()
            .toUpperCase()
            .contains(cruiseCategory.value))
        .toList();
    List filterByKey = filterByCategory
        .where((element) => element["cruise_itinerary"]
            .toString()
            .toUpperCase()
            .contains(cruiseKey.value))
        .toList();
    List filterByType = filterByKey
        .where((element) => element["cruise_type"]
            .toString()
            .toUpperCase()
            .contains(cruiseType.value))
        .toList();
    List filterByModality = filterByType
        .where((element) => element["modality"]
            .toString()
            .toUpperCase()
            .contains(cruiseModality.value))
        .toList();
    List filterByArrival = filterByModality
        .where((element) => element["cruise_format"]
            .toString()
            .toUpperCase()
            .contains(cruiseArrival.value.toString().toUpperCase()))
        .toList();
    List filterByDeparture = filterByArrival
        .where((element) => element["cruise_format"]
            .toString()
            .toUpperCase()
            .contains(cruiseDeparture.value.toString().toUpperCase()))
        .toList();
    List filterByIslet = filterByDeparture
        .where((element) => element["cruise_itinerary"]
            .toString()
            .toUpperCase()
            .contains(cruiseIslet.value.toString().toUpperCase()))
        .toList();
    List filterByDays = filterByIslet.where((element) => true).toList();
    List filterByDay = filterByDays.where((element) => true).toList();
    List filterByCruise = filterByDay.where((element) => true).toList();
    List filterByDateRange = filterByCruise.where((element) => true).toList();
    List filterByCabine = filterByDateRange.where((element) => true).toList();
    List filterByTriple = filterByCabine.where((element) => true).toList();

    cruiseResults.value = filterByTriple.toList();

    var processedData = processCruiseData(ctx, cruiseResults.value, columns);
    searcherHeader.value = processedData[0];
    searcherDetail.value = processedData[1];

    cruiseTable.value = DataTable(
      columns: searcherHeader.value,
      rows: searcherDetail.value,
    );
  }
};

Function getCatalogDescription = (catalog, value) {
  log(value);
  if (value == "0") {
    return "";
  }
  return catalog.firstWhere((element) =>
      element["code"].toString() == (value.toString()))["description"];
};

List columns = ["cruise_name", "cruise_format"];

Rx<Iterable> cruiseResults = Rx([]);
var cruiseTable = Rx(
  DataTable(
    columns: searcherHeader.value,
    rows: searcherDetail.value,
  ),
);

Function processCruiseItinerary = (row) {
  var itinerary = row["cruise_itinerary"]
      .toString()
      .replaceAll("[", "")
      .replaceAll("]", "");
  var itineraryList = itinerary.split(",");
  var result = "";
  var i = 1;
  for (var item in itineraryList) {
    if (item.toString() != "") {
      result +=
          "${getCatalogDescription(findCatalog("week_day"), i)}: ${item.toString()} \n";
    }

    if (i == 7) {
      i = 1;
    } else {
      i++;
    }
  }
  return result;
};

Function toMinutes = (TimeOfDay time) {
  return time.hour * 60 + time.minute;
};
