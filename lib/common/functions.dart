import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../index.dart';

/// ## loadDummyData
/// *__Method load local json file as dummy data__*
///
///### Uses:
/// ```dart
///  await loadDummyData("countries");
/// ```
loadDummyData(key) async {
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

toMinutes(TimeOfDay time) {
  return time.hour * 60 + time.minute;
}

getDistance(a, b, c, d) {
  return acos(sin(double.parse(c) * sin(double.parse(a)) +
          cos(double.parse(a)) *
              cos(double.parse(c)) *
              cos(double.parse(d) - double.parse(b)))) *
      6371;
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

updateDatatable(context, data) {
  var processedData = processData(context, data, null);
  searcherHeader.value = processedData[0];
  if (searchResult!.value.isEmpty) {
    searcherDetail.value = processedData[1];
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
        if (data[formKey][key] == '') {
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
        if (data[formKey][key] == '') {
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
  if (value == '') {
    value = "0";
  }
  value = value.replaceAll(RegExp(r'[^0-9]'), '').replaceAll("-", '');
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

parseInt(value) {
  if (value is String) {
    return int.parse(value);
  }
  return value;
}

processData(context, data, columns) {
  var header = getHeader(context, data, columns);
  var detail = getDetail(context, data, columns);
  return [header, detail];
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
      String title = key ?? '';
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
    if (day == '' || day == " ") {
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
  var res = await fetchHandler(kDefaultSchema, kDefaultServer,
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

multiSaving(values, catalog, context, index, field, memory) {
  memory.value = <String>[];
  var length = values.length;

  for (var i = 0; i < length; i++) {
    memory.value.add(
        filterCatalog(catalog, "code", values[i])[0]["description"].toString());
  }

  setFormValue(context, index, field, memory.value);
}

pushList(List list, int id, dynamic value) {
  try {
    list[id] = value;
  } catch (e) {
    list.add(value);
  }
}

String getTimeStringFromDouble(double value) {
  if (value < 0) return '00:00';
  int flooredValue = value.floor();
  double decimalValue = value - flooredValue;
  String hourValue = getHourString(flooredValue);
  String minuteString = getMinuteString(decimalValue);

  return '$hourValue:$minuteString';
}


