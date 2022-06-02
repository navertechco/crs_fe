// Other s
import 'package:naver_crs/common/com/index.dart';

import '../index.dart';

getCatalog(
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

cruiseReset() {
  cruiseFormat.value = "";
  cruiseDay.value = "";
  cruiseShip.value = "";
  cruiseRange.value = "";
  cruiseCategory.value = "";
  cruiseKey.value = "";
  cruiseType.value = "";
  cruiseCabine.value = "";
  cruiseModality.value = "";
  cruisePax.value = "";
  cruiseTriple.value = "";
  cruiseStarts.value = "";
  cruiseEnds.value = "";
  cruiseIslet.value = "";
  cruiseItinerary.value = "";
  cruisePort.value = "";
  cruiseAnimal.value = "";
  arrivalEdit.value = false;
  departureEdit.value = false;
  moreFilters.value = false;
}

findMemoryChildCatalog(name, field, description,
    {Map? filter, Function? condition}) {
  List<Map<String, dynamic>> memory = findCatalog(name);
  List<Map<String, dynamic>> output = <Map<String, dynamic>>[];
  List items = [];
  var idx = 1;

  if (condition != null) {
    memory = memory.where((e) => condition(e)).toList();
    if (description.isEmpty) {
      items = memory.map((e) => e[field].toString()).toSet().toList();
    } else {
      items =
          memory.map((e) => e[field][description].toString()).toSet().toList();
    }
    items.sort();
    for (var item in items) {
      Map<String, dynamic> row = {};
      row["code"] = idx;
      row["description"] = item;
      output.add(row);
      idx++;
    }
    return output;
  }

  if (filter != null) {
    var relations = filter["relation"];
    var fc = findCatalog(filter["catalog"]);
    for (var j in fc) {
      for (var k in memory) {
        var rule = true;
        for (var rel in relations) {
          rule = rule && k[field][rel].toString() == j[field][rel].toString();
        }
        if (j[field][filter["key"]].toString() == filter["value"].toString() &&
            rule) {
          items.add(k);
        }
      }
    }
    items = items.map((e) => e[field][description].toString()).toSet().toList();
  } else {
    if (description.isEmpty) {
      items = memory.map((e) => e[field].toString()).toSet().toList();
    } else {
      items =
          memory.map((e) => e[field][description].toString()).toSet().toList();
    }
  }

  items.sort();
  for (var item in items) {
    Map<String, dynamic> row = {};
    row["code"] = idx;
    row["description"] = item;
    output.add(row);
    idx++;
  }

  return output;
}

findMemoryCatalog(name, description) {
  var memory = globalctx.memory[name];
  List<Map<String, dynamic>> output = <Map<String, dynamic>>[];
  if (memory != null) {
    var idx = 1;
    List items = memory.map((e) => e[description].toString()).toSet().toList();
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
}

updateDestinationsCatalog() {
  var countryName = getCountryNameById(destCountry.value);
  destinationsCatalog = findCatalog("destinations").where((element) =>
      element["relation"]["country"].toString().toLowerCase() ==
      countryName.toString().toLowerCase());
  airportCatalog = findCatalog("airport").where((element) =>
      element["relation"]["country"].toString().toLowerCase() ==
      countryName.toString().toLowerCase());
}

processDaysCatalog() {
  totalDays.value =
      departureDate.value.difference(arrivalDate.value).inDays + 1;
  if (totalDays.value > 0) {
    daysCatalog.value = [];
    for (int i = 0; i < totalDays.value; i++) {
      Map<String, dynamic> row = {};
      row["code"] = i + 1;
      row["description"] = "Day ${i + 1}";
      daysCatalog.add(row);
    }
  }
}

getCatalogDescription(catalog, value) {
  log(value);
  if (value == "0") {
    return "";
  }

  if (value is List) {
    var result = [];
    if (value.isNotEmpty) {
      for (var item in catalog) {
        if (value.contains(item["code"])) {
          result.add(item["description"]);
        }
      }
    }
    return result;
  }

  return catalog.firstWhere((element) =>
      element["code"].toString() == (value.toString()))["description"];
}

secureFilter(catalog, condition) {
  try {
    var res = catalog.where(condition).toList();
    return res;
  } catch (e) {
    log(e);
    return <Map<String, dynamic>>[];
  }
}

filterCatalog(catalog, key, value) {
  try {
    var res =
        findCatalog(catalog).toList().where((e) => e[key] == value).toList();
    return res;
  } catch (e) {
    log(e);
    return [];
  }
}

toCatalog(item) {
  List list = item.values.toList();
  CatalogDto ctlg = CatalogDto(list);
  return ctlg;
}

getCatalogs(catalogs) async {
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
}

findCatalog(name) {
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
}
