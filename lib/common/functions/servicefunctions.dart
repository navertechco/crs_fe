// Service functions
// ignore_for_file: prefer_function_declarations_over_variables
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:naver_crs/pages/6/services/widgets/custom/index.dart';
import '../index.dart';

Function filterSuggestedServices = () {
  filterServices();
  clearCosts();
};

Function filterServices = () {
  getFilteredServices().then((value) {
    updateDragServices(value);
  });
};

Function updateDragServices = (filteredServices) async {
  srvlist.value = <Widget>[];
  srvlistmem.value = [];
  var filtered = await filteredServices as Iterable;
  for (var srv in filtered) {
    var obj = CustomDragableService(service: srv, suggested: true);
    if (!srvlistmem.contains(srv.description)) {
      srvlist.add(obj);
      srvlistmem.add(srv.description);
    }
  }
  return;
};

Function paginateDestination = (context) async {
  if (globalctx.memory["promoted"] != null &&
      globalctx.memory["promoted"]["day"] != null &&
      globalctx.memory["promoted"]["day"][currentDay.value] != null) {
    await nextDestination();
  }
};

Function getFilteredServices = () async {
  List filtered = await getSrvFiltered();
  filtered = filtered
      .where((service) => getServiceState(service.description) != "promoted")
      .toList()
      .toSet()
      .toList();
  filtered = filtered
      .where((service) =>
          service.relation["destination"] == globalDestinationName.value ||
          service.relation["destination"] == "all")
      .toList()
      .toSet()
      .toList();

  Iterable result = filtered;

  return result;
};
//////////////////////////////////////////////////////////////////////////////////////
Function getSrvFiltered = () async {
  filteredsrv = [];

  Iterable srvs = await services;
  for (var item in srvs) {
    List itemList = item;
    for (var catalog in itemList) {
      catalog = catalog.values.toList();
      catalog.removeAt(0);
      catalog.removeAt(2);
      CatalogDto service = CatalogDto(catalog);
      filteredsrv.add(service);
    }
  }

  return filteredsrv;
};
Function resetCurrentDestinationServices = () {
  try {
    var srvs = globalctx.services[currentDestination.value];
    for (var service in srvs) {
      setServiceState(service, "suggested");
    }
    initializeCosts();
    filterSuggestedServices();
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
  setServiceState(service, "promoted");
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
  // accumulatedHours[currentDestination.value].value =
  //     accumulatedHours[currentDestination.value].value + value;
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
  // var srvtime = (parseInt(srvData['srvtime']) * 1.0) as double;
  return 0 / 60;
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
    result =
        (filteredsrv.firstWhere((element) => element.description == service));
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
