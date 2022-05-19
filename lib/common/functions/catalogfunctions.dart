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

findMemoryCatalog(name, description) {
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
  return catalog.firstWhere((element) =>
      element["code"].toString() == (value.toString()))["description"];
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
