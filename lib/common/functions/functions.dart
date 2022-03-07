// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  // print(res);
  if (res['state'] == true) {
    setContext("catalogs", res['data']);
    return true;
  } else {
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
        row["relation"] = item["relation"];
        catalog.add(row);
      }
    }

    return catalog;
  }

  return <Map<String, dynamic>>[];
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
  allPromotedDestinations = [];
  globalctx.promotedDestinations.value = [];
  globalctx.selectedDestinations.value = [];
  globalctx.destinations.value = [];
  globalctx.experiences.value = [];
  globalctx.destinationDragData.value = [];
  globalctx.experienceDragData.value = {};
  globalctx.reset.value = true;
  totalDays.value = departureDate.value.difference(arrivalDate.value).inDays;
  leftAccumulated.value = 0;
  dayleft.value = totalDays.value;
  globalctx.states["destinations"] = {};
  draggable.value = 0;
  updateDraggableDestinations();
  updateAirPorts();
};
Function getItems = (data, value) {
  RxList<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[].obs;
  List<Map<String, dynamic>> data2 = [];
  data2.add({"code": "0", "description": "Choose a Option"});
  if (data.isNotEmpty) {
    items = <DropdownMenuItem<String>>[].obs;
    data2.addAll(data);
    data2.asMap().forEach((index, item) {
      items.add(DropdownMenuItem(
        value: item["code"].toString(),
        child: Text(item["description"]),
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

Function getFormValue = (data, formKey, key, def) {
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

Function getDestinationDay = (String destination) {
  if (globalctx.memory != null) {
    if (destinations != null) {
      if (destinations[destination] != null) {
        if (destinations[destination]["explorationDay"] != null) {
          return int.parse(destinations[destination]["explorationDay"]);
        }
      }
    }
  }

  return 0;
};

Function setDestination = (String destination) {
  destinations[destination] ??= {};
};

Function setDestinationDay = (String destination, value) {
  setDestination(destination);
  destinations[destination]["explorationDay"] ??= value;
};

Function getLeftAccumulated = (destination) {
  leftAccumulated.value = 0;
  totalDays.value = departureDate.value.difference(arrivalDate.value).inDays;
  for (String item in destinations.keys) {
    bool exists = item != destination;
    if (exists) {
      leftAccumulated.value -= getDestinationDay(item) as int;
    }
  }
  return leftAccumulated.value;
};

Function parseIntValue = (value) {
  value ??= "0";
  if (value == "") {
    value = "0";
  }
  value == value.replaceAll(RegExp(r'[^0-9]'), '').replaceAll("-", "");
  return int.parse(value);
};

Function setFormValue = (data, formKey, key, value) {
  data ??= {}.obs;

  if (data[formKey] == null) {
    data[formKey] = {}.obs;
  }

  data[formKey][key] = value;
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

Function updateDestinationsCatalog = () {
  var countryName = getCountryNameById(destCountry.value);
  destinationsCatalog = processCatalog("destinations").where((element) =>
      element["relation"]["country"].toString().toLowerCase() ==
      countryName.toString().toLowerCase());

  airportCatalog = processCatalog("airport").where((element) =>
      element["relation"]["country"].toString().toLowerCase() ==
      countryName.toString().toLowerCase());
};

Function updateAirPorts = () {
  var arr = destinationsCatalog
      .toList()
      .where((element) => element["code"] == int.parse(arrivalPort.value)).first;
  var dep = destinationsCatalog.toList().where(
      (element) => element["code"] == int.parse(departurePort.value)).first;

  arrival.value = arr;
  departure.value = dep;

  filterSelectedDestinations();
};
