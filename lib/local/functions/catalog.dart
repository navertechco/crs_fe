// Other s
import 'dart:convert';

import 'package:naver_crs/common/com/index.dart';
import 'package:naver_crs/index.dart';

//  ██████╗ █████╗ ██╗      █████╗ ████████╗ ██████╗  ██████╗
// ██╔════╝██╔══██╗██║     ██╔══██╗╚══██╔══╝██╔═══██╗██╔════╝
// ██║     ███████║██║     ███████║   ██║   ██║   ██║██║  ███╗
// ██║     ██╔══██║██║     ██╔══██║   ██║   ██║   ██║██║   ██║
// ╚██████╗██║  ██║███████╗██║  ██║   ██║   ╚██████╔╝╚██████╔╝
//  ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝  ╚═════╝

// ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
// ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
// █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗
// ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║
// ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║
// ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

/// ## getMemoryCatalogChild
/// *__Method to get filtered catalog child from memory__*
///
///### Uses:
/// ```dart
///  getMemoryCatalogChild("cabine", "value", "days"),
/// ```
///
/// @return catalogs (List<Catalog>)
///
List<Map<String, dynamic>> getMemoryCatalogChild(name, field, description,
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

/// ## getMemoryCatalogChild
/// *__Method to get filtered catalog child from memory__*
///
///### Uses:
/// ```dart
///  getMemoryCatalogChild("cabine", "value", "days"),
/// ```
///
/// @return catalogs (List<Catalog>)
///
List<Map<String, dynamic>> getMemoryChild(name, field, description,
    {Map? filter, Function? condition}) {
  var memory = globalctx.memory[name];
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
      if (field.isEmpty) {
        items = memory.map((e) => e).toSet().toList();
      } else {
        items = memory.map((e) => e[field].toString()).toSet().toList();
      }
    } else {
      if (field.isEmpty) {
        items = memory.map((e) => e[description].toString()).toSet().toList();
      } else {
        items = memory
            .map((e) => e[field][description].toString())
            .toSet()
            .toList();
      }
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

/// ## updateDestinationsCatalogFilteredByCountry
/// *__Method to update destination and airport global catalogs since country is selected__*
///
///### Uses:
/// ```dart
///  updateDestinationsCatalogFilteredByCountry();
/// ```
///
/// @return void
///
void updateDestinationsCatalogFilteredByCountry() {
  var countryName = getCountryNameById(destCountry.value);
  destinationsCatalog = findCatalog("destinations")
      .where((element) =>
          element["relation"]["country"].toString().toLowerCase() ==
          countryName.toString().toLowerCase())
      .toList();
  airportCatalog = findCatalog("airport")
      .where((element) =>
          element["relation"]["country"].toString().toLowerCase() ==
          countryName.toString().toLowerCase())
      .toList();
}

/// ## getCatalogDescription
/// *__Method to get a catalog description__*
///
///### Uses:
/// ```dart
///   getCatalogDescription(
///                        getMemoryCatalogChild("hotel", "value", "budget_fk"),
///                        value)
/// ```
///
/// @return dynamic
///
dynamic getCatalogDescription(catalog, value) {
  log(value);
  if (value == "0") {
    return '';
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

/// ## filterCatalog
/// *__Method to filter a catalog gived a key and a value__*
///
///### Uses:
/// ```dart
///  filterCatalog(subs, "code", int.parse(sub))[0]["description"];
/// ```
///
/// @return catalog (List<String>)
///
List filterCatalog(catalog, key, value) {
  try {
    var res =
        findCatalog(catalog).toList().where((e) => e[key] == value).toList();
    return res;
  } catch (e) {
    log(e);
    return [];
  }
}

/// ## toCatalog
/// *__Method to convert a list to a catalog Strut__*
///
///### Uses:
/// ```dart
///  toCatalog(filterCatalog(
///          "destinations", "description", arrival.value["description"])[0]);
/// ```
///
/// @return catalog (Catalog)
///
CatalogDto toCatalog(item) {
  List list = item.values.toList();
  CatalogDto ctlg = CatalogDto(list);
  return ctlg;
}

/// ## getCatalogs
/// *__Method to fetch certain catalogs from backend__*
///
///### Uses:
/// ```dart
///  var services =
///    getCatalogs(["hotel", "transport_service", "cruises", "food_services"])
///        .then((value) => value);
/// ```
///
/// @return catalogs (List<Catalog>)
///
Future getCatalogs(catalogs) async {
  try {
    var res = await fetchHandler(kDefaultSchema, kDefaultServer,
        kDefaultServerPort, kDefaultFindCatalog, 'POST', {
      "data": {"catalogs": catalogs}
    });
    if (res != null) {
      if (res is String) {
        res = jsonDecode(res);
      }
    }
    if (res['state'] == true) {
      var catalogs = getContext("catalogs") ?? {};
      setContext("catalogs", {...catalogs, ...res['data']["catalogs"] as Map});
      return true;
    } else {
      log(res["message"]);
      return false;
    }
  } catch (e) {
    log(e);
    return false;
  }
}

/// ## findCatalog
/// *__Method to find a catalog from context__*
///
///### Uses:
/// ```dart
///  var destinations =
///   findCatalog("destinations");
/// ```
///
/// @return catalog (Catalog)
///
List<Map<String, dynamic>> findCatalog(name) {
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
