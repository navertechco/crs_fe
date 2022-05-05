// Service functions
// ignore_for_file: prefer_function_declarations_over_variables
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:naver_crs/pages/6/services/widgets/custom/index.dart';
import '../index.dart';

Function filterSuggestedServices = () {
  // processDestinations();
  filterServices();
  clearCosts();
};

Function filterServices = () {
  var filteredServices = getFilteredServices();
  updateDragServices(filteredServices);
};

Function updateDragServices = (filteredServices) {
  srvlist.value = <Widget>[];
  for (var srv in filteredServices) {
    srvlist.add(CustomDragableService(service: srv, suggested: true));
  }
};

Function paginateDestination = (context) async {
  if (globalctx.memory["promoted"] != null &&
      globalctx.memory["promoted"]["day"] != null &&
      globalctx.memory["promoted"]["day"][currentDay.value] != null) {
    await nextDestination();
  }
};

Function getFilteredServices = () {
  List filtered = getSrvFiltered();
  var idx = "getDestinationIndex()";
  var sub = getFormValue(globalctx.memory["destinations"], idx, "sub", null);
  var destination =
      getFormValue(globalctx.memory["destinations"], idx, "destination", null);
  var destData = getDestinationValueByName(destination);
  List filteredBySubs = filtered.where((e) {
    if (sub != null && sub != "0") {
      var subs = destData[9]["subs"];
      if (e.value["sub"] != null) {
        var subName =
            filterCatalog(subs, "code", int.parse(sub))[0]["description"];
        var rule = subName == e.value["sub"];
        return rule;
      }
    }
    return true;
  }).toList();

  List filteredByType = filteredBySubs.where((e) {
    if (e.value["service_type"] == "meal") {
      return true;
    }

    if (e.description == "Leisure Time") {
      return true;
    }
    try {
      var compare = currentDestinationType;
      var tr = getServiceByName(e.description).value["service_type"];
      var rule = tr == compare;
      return rule;
    } catch (e) {
      return true;
    }
    // return rule;
  }).toList();
  List filteredByKA = filteredByType.where((e) {
    if (currentDestinationKeyActivities.value.isEmpty) {
      return true;
    }
    if (currentDestination.value == 0 || e.description == "Leisure Time") {
      return true;
    }

    var destKa = getDestinationKa(
        globalDestinationName.value, globalDestinationType.value);
    String ka1 =
        getServiceByName(e.description).value["keyActivityType_fk"].toString();
    String ka2 =
        getServiceByName(e.description).value["keyActivityType_fk2"].toString();
    var rule1 = destKa.contains(ka1);
    var rule2 = destKa.contains(ka2);
    return rule1 || rule2;
  }).toList();
  List filteredByPurpose = filteredByKA.where((e) {
    if (e.value["service_type"] == "meal") {
      return true;
    }
    if (currentDestination.value == 0 || e.description == "Leisure Time") {
      return true;
    }
    var purposes = globalctx.memory["tour"]["purposes"];
    String p1 = getServiceByName(e.description).value["purpose_fk"];
    String p2 = getServiceByName(e.description).value["purpose_fk2"];
    var rule1 = purposes.contains(p1);
    var rule2 = purposes.contains(p2);
    return rule1 || rule2;
  }).toList();
  List filteredByOpenDestinations = filteredByPurpose.where((e) {
    if (e.value["service_type"] == "meal") {
      return true;
    }
    if (currentDestination.value == 0 || e.description == "Leisure Time") {
      return true;
    }
    try {
      var dateName = "";
      var open = getServiceByName(e.description)
          .value["openDestinations"]
          .toString()
          .split(",");
      var rule = open.contains(dateName);
      return rule;
    } catch (e) {
      return true;
    }
  }).toList();
  List filteredByBudget = filteredByOpenDestinations.where((e) {
    return true;
  }).toList();
  List filteredByMaxCapacity = filteredByBudget.where((e) {
    return true;
  }).toList();
  List filteredByExpMode = filteredByMaxCapacity.where((e) {
    if (globalDestinationName.value.toString().toUpperCase() !=
            "galapagos".toString().toUpperCase() &&
        globalDestinationName.value.toString().toUpperCase() !=
            "amazon".toString().toUpperCase()) {
      return true;
    }
    return true;
  }).toList();
  List filteredByAirport = filteredByExpMode;
  List filteredBySuggested = filteredByAirport.where((e) {
    if (e.description == "Leisure Time") {
      return true;
    }
    return getServiceState(e.description) == "suggested";
  }).toList();
  initializeCosts();
  List filteredByLeft = filteredBySuggested.where((e) {
    // return true;

    if (e.description == "Leisure Time") {
      return true;
    }
    var total = totalHours[currentDestination.value] ?? 0.0.obs;
    var acc = accumulatedHours[currentDestination.value] ?? 0.0.obs;
    var currentLeft = (total.value - acc.value) * 60;
    var srvTime = getServiceByName(e.description).value["srvtime"] ?? 600;
    var rule = srvTime <= currentLeft;
    var rule2 = (srvTime - currentLeft) <= 30;
    return rule || rule2;
  }).toList();

  List filterByOpenTime = filteredByLeft.where((e) {
    var closeTime = parseHour(e.value["closeTime"]);
    if (e.description == "Leisure Time") {
      return true;
    }
    if (currentDestination.value == 0) {
      if (closeTime - parseHour(arrivalHour.value) > 30) {
        return true;
      }
      return false;
    } else {
      if (e.value["service_type"] == "meal") {
        return true;
      }
      endHours[currentDestination.value].value = time
          .addHour(totalHours[currentDestination.value].value.round() as int);
      var rule =
          closeTime - toMinutes(endHours[currentDestination.value].value) > 30;
      return rule;
    }
  }).toList();

  filterByOpenTime.sort((a, b) {
    var aTime = a.value["srvtime"];
    var bTime = b.value["srvtime"];
    return aTime.compareTo(bTime);
  });

  Iterable result = filterByOpenTime;

  return result;
};
//////////////////////////////////////////////////////////////////////////////////////
Function getSrvFiltered = () {
  List filtered = [];
  for (Map item in services) {
    List itemList = item.values.toList();
    CatalogDto service = CatalogDto(itemList);
    if (service.value["destination"].toString().toLowerCase() == "all") {
      filtered.add(service);
    }
    if (service.value["destination"].toString().toLowerCase() ==
        globalDestinationName.value) {
      filtered.add(service);
    }
  }
  return filtered;
};
Function resetCurrentDestinationServices = () {
  try {
    var services =
        globalctx.states["services"][currentDestination.value].entries;
    for (var service in services) {
      removeService(service.key);
    }
    accumulatedHours[currentDestination.value].value = 0.0;
    leftHours[currentDestination.value].value =
        totalHours[currentDestination.value].value;
    initializeCosts();
  } catch (e) {
    log(e);
  }
};

Function resetServices = () {
  globalctx.services.value = {};
  globalctx.serviceDragData.value = {};
  srvDraggable.value = 1;

  for (Map service in services) {
    CatalogDto srvCatalog = toCatalog(service);
    removeService(srvCatalog.description);
  }
};

Function deleteService = (service) {
  if (globalctx.services[currentDestination.value].contains(service)) {
    var index = globalctx.services[currentDestination.value]
        .indexWhere((element) => element == service);
    globalctx.services[currentDestination.value].removeAt(index);
    globalctx.serviceDragData.value[currentDestination.value]!.removeAt(index);
  }
};
Function removeService = (service) {
  downgradeServiceDestinations(service);
  deleteService(service);
};
Function promoteService = (service) {
  upgradeServiceDestinations(service);

  List<CatalogDto> filtered = [];
  for (Map item in services) {
    List itemList = item.values.toList();
    CatalogDto srv = CatalogDto(itemList);
    filtered.add(srv);
  }
  CatalogDto serviceData = filtered.firstWhere((e) => e.description == service);
  globalctx.memory["promoted"] ??= {};
  globalctx.memory["promoted"]["day"] ??= {};
  globalctx.memory["promoted"]["day"][currentDestination.value] ??= {};
  globalctx.memory["promoted"]["day"][currentDestination.value][service] =
      serviceData.toJson();
};
Function setServiceState = (service, state) {
  globalctx.states["services"][currentDestination.value] ??= {}.obs;
  globalctx.states["services"][currentDestination.value][service] ??= {}.obs;
  globalctx.states["services"][currentDestination.value][service]["state"] =
      state;
  // proccessServices();
  if (state == "selected") {
    moveService(service);
  }
  filterSuggestedServices();
};
Function getServiceState = (service) {
  globalctx.states["services"][currentDestination.value] ??= {}.obs;
  globalctx.states["services"][currentDestination.value][service] ??= {}.obs;
  var state =
      globalctx.states["services"][currentDestination.value][service]["state"];
  state ??= "suggested";
  return state;
};
Function moveService = (String service) {
  globalctx.services[currentDestination.value] ??= [];
  globalctx.serviceDragData.value[currentDestination.value] ??= [];
  if (!globalctx.services[currentDestination.value].contains(service)) {
    globalctx.services[currentDestination.value].add(service);
    globalctx.serviceDragData.value[currentDestination.value]!
        .add(DragServiceOptionWidget(service: service));
  }
};
Function upgradeServiceDestinations = (String service) {
  var state = getServiceState(service);
  if (state == "selected") {
    var value = calculateServiceDestinations(service);
    processCost(value);
  }
  setServiceState(service, "promoted");
};
Function downgradeServiceDestinations = (String service) {
  var state = getServiceState(service);
  if (state == "promoted") {
    var value = calculateServiceDestinations(service);
    if (service == "Leisure Time") {
      value = getFormValue(
          globalctx.memory["days"], currentDestination.value, "leisureTime", 0);
    }
    processCost(-value);
  }
  setServiceState(service, "suggested");
};
Function processCost = (value) {
  accumulatedHours[currentDestination.value].value =
      accumulatedHours[currentDestination.value].value + value;
  initializeCosts();
};

Function initializeCosts = () {
  leftHours[currentDestination.value] ??= 0.0.obs;
  accumulatedHours[currentDestination.value] ??= 0.0.obs;
  totalHours[currentDestination.value] ??= 0.0.obs;
  endHours[currentDestination.value] ??= time.obs;
  totalHours[currentDestination.value].value =
      getMaxTrValue(currentTravelRhythm.value);
  leftHours[currentDestination.value].value =
      totalHours[currentDestination.value].value -
          accumulatedHours[currentDestination.value].value;
  endHours[currentDestination.value].value =
      time.addHour(totalHours[currentDestination.value].value.round() as int);
  clearCosts();
};
Function calculateServiceDestinations = (String service) {
  var srvData = getServiceByName(service).value;
  var srvtime = (parseInt(srvData['srvtime']) * 1.0) as double;
  return srvtime / 60;
};

Function getServiceTravelRhythmByName = (String service) {
  var srvData = getServiceValueByName(service);
  var trData = findCatalog("travel_rhythm").toList();
  var trObject = trData.firstWhere((e) =>
      e["description"].toString().toUpperCase() ==
      srvData["travel_rhythm"].toString().toUpperCase());
  return trObject;
};
Function getServiceValueByName = (String service) {
  var result;
  try {
    result = getServiceByName(service).value;
  } catch (e) {
    log(e);
  }
  return result;
};
Function getServiceByName = (String service) {
  var result;
  try {
    result = toCatalog(srvList
        .firstWhere((element) => element["description"].toString() == service));
  } catch (e) {
    log(e);
  }
  return result;
};
Function updateDraggableServices = () {
  if (globalctx.promotedServices.keys.contains("Leisure Time")) {
    destDraggable.value = 0;
  }
};

Function clearCosts = () {
  clearedHours[currentDestination.value] ??= false;
  if (clearedHours[currentDestination.value]) {
    currentTravelRhythm.value = "0";
    totalHours[currentDestination.value].value = 10.0;
    leftHours[currentDestination.value].value =
        totalHours[currentDestination.value].value -
            accumulatedHours[currentDestination.value].value;
  }
};
