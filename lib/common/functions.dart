import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../index.dart';

//  ██████╗ ██████╗ ███╗   ███╗███╗   ███╗ ██████╗ ███╗   ██╗
// ██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔═══██╗████╗  ██║
// ██║     ██║   ██║██╔████╔██║██╔████╔██║██║   ██║██╔██╗ ██║
// ██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██║   ██║██║╚██╗██║
// ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║╚██████╔╝██║ ╚████║
//  ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝

// ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
// ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
// █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗
// ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║
// ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║
// ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

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

/// ## getDateValue
/// *__Method to get a Date Value from memory__*
///
///### Uses:
/// ```dart
///  initialValue: getDateValue(client, "birth_date",
///                                  def: DateTime(1950, 01, 01)),
/// ```
///
/// @return DateTime?
///
DateTime? getDateValue(data, key, {DateTime? def}) {
  var res = def;
  try {
    if (data ?? true) {
      if (data[key] ?? true) {
        res = DateTime.parse(data[key]);
      }
    } else {
      res = def!;
    }
  } catch (e) {
    res = def!;
  }
  return res;
}

/// ## getValue
/// *__Method to get value from memory__*
///
///### Uses:
/// ```dart
///  var detsdata = getValue(memory, "destinations", def: []);
/// ```
///
/// @return dynamic
///
dynamic getValue(data, key, {def}) {
  try {
    return data[key] ?? def;
  } catch (e) {
    return def;
  }
}

/// ## setValue
/// *__Method to set a value to memory__*
///
///### Uses:
/// ```dart
///  var detsdata = setValue(memory, "destinations", def: []);
/// ```
///
///
///
void setValue(data, key, value) {
  data[key] = value;
}

/// ## getParam
/// *__Method to get a parameter from parameters catalog__*
///
///### Uses:
/// ```dart
///  List destList = getParam("DESTINATION_DATA").values.toList();
/// ```
///
/// @return dynamic
///
dynamic getParam(String key) {
  try {
    var params = findCatalog("params");
    var child =
        params.toList().firstWhere((element) => element["description"] == key);
    return child;
  } catch (e) {
    log(e);
  }
}

/// ## procCityData
/// *__Method to process Country city dropdown filtering__*
///
///### Uses:
/// ```dart
///  onChanged: (value) {
///                               country.value = value!;
///                                procCityData(
///                                    countries[countrylist[int.parse(value)]
///                                        ["description"]]);
///                                log("CHANGED: ");
///                              },
/// ```
///
///
///
void procCityData(cities) {
  var index = 1;
  citylist.value = [];
  for (var city in cities) {
    citylist.value.add({
      "code": "$index",
      "description": city,
    });
    index++;
  }
  citylist.value = citylist.value.toSet().toList();
}

/// ## toMinutes
/// *__Method to convert to minutes a TimeOfDay value__*
///
///### Uses:
/// ```dart
///  var rule = closeTime - toMinutes(endHours[currentDay.value].value)
/// ```
///
///
///
toMinutes(TimeOfDay time) {
  return time.hour * 60 + time.minute;
}

/// ## getGPSDistance
/// *__Method to distance between two GPS coordinates__*
///
///### Uses:
/// ```dart
///   var bDistance = (getGPSDistance(bLat, bLong, arrivalLat, arrivalLong));
/// ```
/// @return double
double getGPSDistance(String latA, String longA, String latB, String longB) {
  return acos(sin(double.parse(latB) * sin(double.parse(latA)) +
          cos(double.parse(latA)) *
              cos(double.parse(latB)) *
              cos(double.parse(longB) - double.parse(longA)))) *
      6371;
}

/// ## updateDatatable
/// *__Method to update a DataTable__*
///
///### Uses:
/// ```dart
///   updateDatatable(ctx, quoteFilter.value);
/// ```
/// @return void
///
void updateDatatable(context, data) {
  var processedData = processData(context, data, null);
  searcherHeader.value = processedData[0];
  if (searchResult!.value.isEmpty) {
    searcherDetail.value = processedData[1];
  }
}

/// ## getItems
/// *__Method to get items from a parent dropdown widget__*
///
///### Uses:
/// ```dart
///   var items = getItems(data, value, hintText);
/// ```
/// @return RxList<DropdownMenuItem<String>>
///
RxList<DropdownMenuItem<String>> getItems(data, value, hintText) {
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

/// ## isMobileDevice
/// *__Method to detect if host is a mobile device__*
///
///### Uses:
/// ```dart
///   var isMobile = isMobileDevice() ? 2 : 1;
/// ```
/// @return bool
///
bool isMobileDevice() {
  if ((defaultTargetPlatform == TargetPlatform.iOS) ||
      (defaultTargetPlatform == TargetPlatform.android)) {
    // Some android/ios specific code
    return true;
  }
  return false;
}

/// ## getRXValue
/// *__Method to get valu from a GetX memory__*
///
///### Uses:
/// ```dart
///    label: "Accumulated Hours: ${getTimeStringFromDouble(getRXValue(accumulatedHours, currentDay.value, 0.0))}",
///
/// ```
/// @return dynamic
///
dynamic getRXValue(data, key, def) {
  try {
    return data[key].value;
  } catch (e) {
    return def;
  }
}

/// ## getFormValue
/// *__Method to detect form value from memory__*
///
///### Uses:
/// ```dart
///     var days = int.parse(getFormValue(
///      globalctx.memory["destinations"], index, "explorationDay", "0"));
/// ```
/// @return dynamic
///
dynamic getFormValue(data, formKey, key, def) {
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

/// ## setFormValue
/// *__Method to set a form value to memory__*
///
///### Uses:
/// ```dart
///      setFormValue(globalctx.memory["destinations"], 1,
///                      "cruiseStartDate", start);
/// ```
/// @return void
///
void setFormValue(data, formKey, key, value) {
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

saveCruiseCalendar(start, end) {
  cruiseStartDate.value = start;
  cruiseEndDate.value = end;
  arrivalDate.value = start.add(Duration(days: -2));
  departureDate.value = end.add(Duration(days: 1));
  setFormValue(globalctx.memory["destinations"], 1, "cruiseStartDate", start);
  setFormValue(globalctx.memory["destinations"], 1, "cruiseEndDate", end);
  var val1 = end.difference(start).inDays + 1;
  var val0 = int.parse(
      getFormValue(globalctx.memory["destinations"], 1, "cruiseExpDays", "0"));

  saveExplorationDay(1, val0, val1, key: "cruiseExpDays");
}

saveMultiDropDown(setters, catalog, values, limit) {
  if (values.length <= limit) {
    var mem = <String>[];
    var length = values.length;

    for (var i = 0; i < length; i++) {
      mem.add(catalog.toList().where((e) => e["code"] == values[i]).toList()[0]
          ["description"]);
    }
    setFormValue(setters[0], setters[1], setters[2], mem);
  }
}

/// ## setFormValue
/// *__Method to parse a value to int__*
///
///### Uses:
/// ```dart
///     var exptime = (parseInt(expData['exptime']) * 1.0) as double;
/// ```
/// @return int
///
int parseInt(dynamic value) {
  if (value is String) {
    return int.parse(value);
  }
  return value;
}

/// ## processData
/// *__Method to process data to a dataTable__*
///
///### Uses:
/// ```dart
///     var processedData = processData(context, data, null);
/// ```
/// @return List
///
List processData(context, data, columns) {
  List<DataColumn> header = getHeader(context, data, columns);
  List<DataRow> detail = getTourDataRows(context, data, columns);
  return [header, detail];
}

/// ## getHeader
/// *__Method to get a dataTable header__*
///
///### Uses:
/// ```dart
///     List<DataColumn> header = getHeader(context, data, columns);
/// ```
/// @return List
///
List<DataColumn> getHeader(context, data, columns) {
  List<DataColumn> header = <DataColumn>[];
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

/// ## getDataSource
/// *__Method to get a Calendar dataSource__*
///
///### Uses:
/// ```dart
///     dataSource: MeetingDataSource(getDataSource(
///                          "${row['quote_itinerary']}"
///                              .replaceAll("[", " ")
///                              .replaceAll("]", " "))),
/// ```
/// @return List
///
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

/// ## getTimeStringFromDouble
/// *__Method to get a time value in string format from a decimal value__*
///
///### Uses:
/// ```dart
///     label:"Accumulated Hours: ${getTimeStringFromDouble(getRXValue(accumulatedHours, currentDay.value, 0.0))}",
/// ```
/// @return String
///
String getTimeStringFromDouble(double value) {
  if (value < 0) return '00:00';
  int flooredValue = value.floor();
  double decimalValue = value - flooredValue;
  String hourValue = getHourString(flooredValue);
  String minuteString = getMinuteString(decimalValue);

  return '$hourValue:$minuteString';
}

/// ## getMinuteString
/// *__Method to get a minute in string format from a decimal value__*
///
///### Uses:
/// ```dart
///     String minuteString = getMinuteString(decimalValue);
/// ```
/// @return String
///
String getMinuteString(double decimalValue) {
  return '${(decimalValue * 60).toInt()}'.padLeft(2, '0');
}

/// ## getHourString
/// *__Method to get a minute in string format from a decimal value__*
///
///### Uses:
/// ```dart
///     String hourValue = getHourString(flooredValue);
/// ```
/// @return String
///
String getHourString(int flooredValue) {
  return '${flooredValue % 24}'.padLeft(2, '0');
}

/// ## gotoPage
/// *__Method to jump to a page updating toolbar menu__*
///
///### Uses:
/// ```dart
///     gotoPage("Resume");
/// ```
/// @return void
///
void gotoPage(page) {
  var index = pageList.indexWhere((element) => element["label"] == page);
  if (index != -1) {
    if (selectedIndex.value != index) {
      selectedIndex.value = index;
      Get.toNamed("/$page");
    }
  }
}

/// ## gotoPage
/// *__Method to logOut__*
///
///### Uses:
/// ```dart
///     logOut(session["username"]);
/// ```
/// @return void
///
Future logOut(
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

/// ## gotoPage
/// *__Method to push List__*
///
///### Uses:
/// ```dart
///     pushList(daysOff, destId, currenDestDaysOff);
/// ```
/// @return void
///
pushList(List list, int id, dynamic value) {
  try {
    list[id] = value;
  } catch (e) {
    list.add(value);
  }
}

/// ## getListMaxValue
/// *__Method to get Max value from a List__*
///
///### Uses:
/// ```dart
///     var maxValue = getListMaxValue(destDays);
/// ```
/// @return dynamic
///
dynamic getListMaxValue(List list) {
  var result = list[0];
  for (var i = 0; i < list.length; i++) {
    if (list[i] > result) {
      result = list[i];
    }
  }
  return result;
}

updateMulitDropdown(data, value, dataSource, dataValue) {
  try {
    if (data != null) {
      if (data.isNotEmpty) {
        dataSource = data.map((e) {
          return {"display": e["description"], "value": e["code"]};
        }).toList();
      } else {
        dataSource = [
          {
            'display': "No data from Service",
            'value': 0,
          }
        ];
      }
    }

    if (value != null) {
      if (value.isNotEmpty) {
        dataValue = [];
        for (var item in value) {
          dataValue.add(data
              .firstWhere((element) => element["description"] == item)["code"]);
        }
      } else {
        dataValue = [];
      }
    }
    return [dataValue, dataSource];
  } catch (e) {
    log(e);
  }
}

windowCheck() {
  var isPortrait = Get.width > Get.height;
  var isLandscape = Get.width < Get.height;
  var isMobileLayout = Get.width < 600 || Get.height < 600;
  var isDesktopLayout = Get.width >= 800 || Get.height >= 600;
  var isMobile = isMobileDevice() & isMobileLayout;
  var isTablet = isMobileDevice() & !isMobileLayout;
  var isWebMobile = kIsWeb && isMobileDevice();
  var isWebMobilePortrait = isWebMobile & isPortrait;
  var isWebMobileLandscap = isWebMobile & isLandscape;
  var isWebDesktop = kIsWeb && !isMobileDevice();
  var isMobilePortrait = isMobile & isPortrait;
  var isMobileLandscape = isMobile & isLandscape;
  var isTabletPortrait = isTablet & isPortrait;
  var isTabletLandscape = isTablet & isLandscape;
  var isDesktop = !isMobile && isDesktopLayout && !kIsWeb;

  if (isWebMobilePortrait) {
  } else if (isWebMobileLandscap) {
  } else if (isWebDesktop) {
  } else if (isMobilePortrait) {
  } else if (isMobileLandscape) {
  } else if (isTabletLandscape) {
  } else if (isTabletPortrait) {
  } else if (isDesktop) {
  } else {}
}
