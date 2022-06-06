// ignore_for_file: prefer_function_declarations_over_variables, import_of_legacy_library_into_null_safe
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:naver_crs/pages/7/endservices/widgets/index.dart';
import 'package:naver_crs/pages/index.dart';
import 'package:sweetalert/sweetalert.dart';
import '../index.dart';
export 'day.dart';
export 'destination.dart';
export 'experience.dart';

load(key) async {
  try {
    var result = await rootBundle.loadString("assets/data/$key.json");
    setContext(key, json.decode(result));
  } catch (e) {
    log(e);
  }
}

getDateValue(data, key, {def}) {
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
}

getValue(data, key, {def}) {
  try {
    return data[key] ?? def;
  } catch (e) {
    return def;
  }
}

setValue(data, key, value) {
  data[key] = value;
}

validateData(data) {
  return data != null ? data.length > 0 : false;
}

getData(data, sub, key) {
  // ignore: invalid_use_of_protected_member
  return data != null && data[sub] != null
      // ignore: invalid_use_of_protected_member
      ? data[sub][key]
      : "0";
}

getDataList(data, sub, key) {
  // ignore: invalid_use_of_protected_member
  return data != null && data[sub] != null
      // ignore: invalid_use_of_protected_member
      ? data[sub][key]
      : <Map<String, dynamic>>[];
}

getParam(key) {
  try {
    var params = findCatalog("params");
    var child =
        params.toList().firstWhere((element) => element["description"] == key);
    return child;
  } catch (e) {
    log(e);
  }
}

cityData(Rx<List<Map<String, dynamic>>> citylist, cities) {
  var index = 1;
  citylist.value = [];
  for (var city in cities) {
    citylist.value.add({
      "code": "$index",
      "description": city,
    });
    index++;
  }
}

getItems(data, value, hintText) {
  RxList<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[].obs;
  List<Map<String, dynamic>> data2 = [];
  try {
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
  } catch (e) {
    log(e);
  }

  return items;
}

chunkMap(data, int portion, List<Map<String, dynamic>> list) {
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
}

isMobileDevice() {
  if ((defaultTargetPlatform == TargetPlatform.iOS) ||
      (defaultTargetPlatform == TargetPlatform.android)) {
    // Some android/ios specific code
    return true;
  }
  return false;
}

setData(data, key, value) {
  data[key] = value;
}

getRXValue(data, key, def) {
  try {
    return data[key].value;
  } catch (e) {
    return def;
  }
}

getFormValue(data, formKey, key, def) {
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
}

getFormDateValue(data, formKey, key, def) {
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
}

parseIntValue(value) {
  if (value is int) {
    return value;
  }
  value ??= "0";
  if (value == "") {
    value = "0";
  }
  value = value.replaceAll(RegExp(r'[^0-9]'), '').replaceAll("-", "");
  return int.parse(value);
}

setFormValue(data, formKey, key, value) {
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
}

dynamic myEncode(dynamic item) {
  if (item is DateTime || item is Map) {
    return item.toIso8601String();
  }
  return item;
}

getCountryNameById(id) {
  var country = destinationCountry
      .firstWhere((element) => element["code"] == int.parse(id));
  var name = country["description"];
  return name;
}

showCustomDialog(context, Widget child, String button,
    {Widget? customChild,
    Color backgroundColor = Colors.black54,
    Color buttonColor = Colors.black54,
    double width = 0.5,
    double height = 0.75,
    onSaved}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        backgroundColor: backgroundColor,
        content: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            width: MediaQuery.of(context).size.width * width,
            height: MediaQuery.of(context).size.height * height,
            child: child),
        actions: <Widget>[
          Row(
            children: [
              customChild ?? Spacer(),
              TextButton(
                child: Text(button,
                    style: KTextSytle(
                            context: context,
                            fontSize: 10,
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
          ),
        ],
      );
    },
  );
}

findTravelRhythmDescription(int code) {
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
}

parseInt(value) {
  if (value is String) {
    return int.parse(value);
  }
  return value;
}

multiDropDownKaAgeFilter(trCatalog, travelRhytmAges) {
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
}

log(e) {
  print(e);
}

setLT(value) {
  int ltindex =
      expList.indexWhere((element) => element["description"] == "Leisure Time");
  globalctx.context.value["catalogs"]["experiences"][ltindex]["value"]
          ["exptime"] ==
      value;
  experiences = findCatalog("experiences");
}

getHotel(ctx, {int id = 0, int index = 0}) async {
  currentDestinationIndex.value = index;
  if (globalctx.memory["hotels"] == null) {
    var frame = {
      "data": {"id": id}
    };
    var res = await fetchhandler(kDefaultSchema, kDefaultServer,
        kDefaultServerPort, kDefaultFindHotel, 'POST', frame);
    // ignore: avoid_print
    log(res);
    if (res['state'] == true) {
      var data = res['data'];
      if (data.length > 0) {
        globalctx.memory["hotels"] = data;
        showCustomDialog(
            ctx,
            HotelCalendarWidget(
              ctx: ctx,
            ),
            "Close",
            customChild: HotelKeyPadWidget(),
            backgroundColor: Colors.white,
            buttonColor: Colors.black,
            height: 0.25,
            width: 0.35);
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
        HotelCalendarWidget(
          ctx: ctx,
        ),
        "Close",
        customChild: HotelKeyPadWidget(),
        backgroundColor: Colors.white,
        buttonColor: Colors.black,
        height: 0.25,
        width: 0.35);
  }
}

getCruise(ctx, {int cruiseId = 999, String cruiseName = ""}) async {
  var frame = {
    "data": {
      "cruise_id": cruiseId,
      "cruise_name": cruiseName != "" ? cruiseName.split("-")[0] : ""
    },
  };
  var res = await fetchhandler(kDefaultSchema, kDefaultServer,
      kDefaultServerPort, kDefaultFindCruise, 'POST', frame);
  // ignore: avoid_print
  log(res);
  if (res['state'] == true) {
    var data = res['data'];
    if (data.length > 0) {
      showCruiseDetailDialog(ctx, data[0]);
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

resetData(context, controller) {
  var data = globalctx.memory["tours"];
  if (searchResult!.value.isNotEmpty) {
    controller.clear();
    searchResult!.value = "";
    filteredData.value = data;
    var detail = getDetail(context, filteredData, null);
    searcherDetail.value = (detail);
  }
}

filterData(context, value) {
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
      var detail = getDetail(context, filteredData, null);
      searcherDetail.value = (detail);
    }
  } catch (e) {
    log(e);
  }
}

processNetRateData(context, data) {
  var header = getNetRateHeader(context, data);
  var detail = getNetRateDetail(context, data);
  return [header, detail];
}

processData(context, data, columns) {
  var header = getHeader(context, data, columns);
  var detail = getDetail(context, data, columns);
  return [header, detail];
}

getNetRateHeader(context, data) {
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
}

getHeader(context, data, columns) {
  var header = <DataColumn>[];
  List cols = [];

  if (data.isNotEmpty) {
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
}

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
  var current = firstMonday;
  for (var day in dataList) {
    if (day == "" || day == " ") {
      count++;
      continue;
    }

    if (current.month == now.month) {
      var nextDay = current.add(Duration(days: count));
      meetings
          .add(Meeting(day, nextDay, nextDay, const Color(0xFF0F8644), true));
      current = nextDay;
    }
    count++;
  }
  return meetings;
}

getDetail(context, data, columns) {
  var states = [
    "Error",
    "New",
    "Created",
    "Rejected",
    "Cancelled",
    "Expired",
    "Pending",
    "Approved",
  ];
  var detail = <DataRow>[];
  if (data.length > 0) {
    for (var row in data) {
      var cells = <DataCell>[];
      var keys = row.keys.toList();

      if (columns != null) {
        keys = columns;
      }

      for (var key in keys) {
        if (key == "state") {
          row[key] = states[row[key]];
        }

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
                getTour(context, tourId: row['quote'], detail: true,
                    cb: (data) {
                  if (data.length > 0) {
                    globalctx.memory["tour"] = data[0];
                    showCustomDialog(context, NetRatePage(), "Close",
                        buttonColor: Colors.white, width: 1.0);
                  }
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.copy),
              tooltip: 'Copy',
              onPressed: () {
                getTour(context, tourId: row["quote"], detail: true,
                    cb: (data) {
                  if (data.length > 0) {
                    globalctx.memory["tour"] = data[0];
                    if (row["quote"] == 0) {
                      Get.toNamed("/Searcher");
                    } else {
                      Get.toNamed("/Tour");
                    }
                  }
                });
              },
            ),
          ],
        )),
      );
      detail.add(DataRow(cells: cells));
    }
  }

  return detail;
}

getNetRateDetail(context, data) {
  var detail = <DataRow>[];
  if (data.length > 0) {
    for (var row in data) {
      var cells = <DataCell>[];
      for (var key in row.keys) {
        if (key == "") {}
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
}

String getTimeStringFromDouble(double value) {
  if (value < 0) return '00:00';
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

goto(page) {
  var index = pageList.indexWhere((element) => element["label"] == page);
  if (index != -1) {
    if (selectedIndex.value != index) {
      selectedIndex.value = index;
      Get.toNamed("/$page");
    }
  }
}

logout(
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

getTrColor(tr) {
  var color = {
    "SOFT": Colors.green,
    "MEDIUM": Colors.yellow,
    "HARD": Colors.red
  };

  return color[tr.toString().toUpperCase()];
}

multiSaving(values, catalog, context, index, field, memory) {
  memory.value = <String>[];
  var length = values.length;

  for (var i = 0; i < length; i++) {
    memory.value.add(
        filterCatalog(catalog, "code", values[i])[0]["description"].toString());
  }

  setFormValue(context, index, field, memory.value);
}

purposeValidate(values) {
  if (values.length > 3) {
    var mem = [values[0], values[1], values[2]];
    absorvedPurpose.value = true;
    savePurposes(mem);
  } else {
    savePurposes(values);
  }
}

savePurposes(values) {
  if (values == null) return;
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
}

getDistance(a, b, c, d) {
  return acos(sin(double.parse(c) * sin(double.parse(a)) +
          cos(double.parse(a)) *
              cos(double.parse(c)) *
              cos(double.parse(d) - double.parse(b)))) *
      6371;
}

toMinutes(TimeOfDay time) {
  return time.hour * 60 + time.minute;
}

getDayId(int destId, int destDay) {
  var maxDestDays = getMaxDestDays();
  var currenDestDays = getDestDays(destId);
  var currenDestDaysOff = maxDestDays - currenDestDays;
  pushList(daysOff, destId, currenDestDaysOff);
  var accOff = getAccOff(destId);
  var destMatrixIndex = maxDestDays * destId + destDay;
  var dayId = destMatrixIndex - accOff;
  return dayId;
}

updateDestDays() {
  destDays = [];
  for (var dest in globalctx.memory["destinations"].entries) {
    var destDay = dest.value;
    destDays.add(int.parse(destDay["explorationDay"]));
  }
}

getDestDays(int destId) {
  updateDestDays();
  return destDays[destId];
}

pushList(List list, int id, dynamic value) {
  try {
    list[id] = value;
  } catch (e) {
    list.add(value);
  }
}

getAccOff(destId) {
  var accOff = 0;
  for (var i = 0; i < destId; i++) {
    accOff += daysOff[i] as int;
  }
  return accOff;
}

getMaxDestDays() {
  updateDestDays();
  var maxValue = getMax(destDays);
  return maxValue;
}

getMax(list) {
  var result = list[0];
  for (var i = 0; i < list.length; i++) {
    if (list[i] > result) {
      result = list[i];
    }
  }
  return result;
}

getTrLimit(value) {
  var trLimits = {
    "soft": 60,
    "medium": 60,
    "hard": 180,
    "0": 60,
    "1": 60,
    "2": 60,
    "3": 180
  };
  var result = trLimits[value.toString().toLowerCase()];
  return result;
}

saveTravelCode(ctrl, value) {
  leadPassenger.value = value!;
  ctrl!.state.leadPassenger = value;
  ctrl!.state.travelCode =
      getTravelCode(getValue(client, "lead_passenger", def: "jose cuevas"));
  travelCode.value = getTravelCode(value);
}

getTravelCode(value) {
  var res = value.toString().replaceAll(" ", "-") +
      "-" +
      tour["passengers"].toString() +
      "-" +
      dayFormat.format(arrivalDate.value).replaceAll(" ", "-") +
      "-" +
      globalctx.memory["tour"]["code"].toString();
  return res;
}

updateDatatable(context, data) {
  var processedData = processData(context, data, null);
  searcherHeader.value = processedData[0];
  if (searchResult!.value.isEmpty) {
    searcherDetail.value = processedData[1];
  }
}
