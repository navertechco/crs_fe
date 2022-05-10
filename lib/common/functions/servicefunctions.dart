// Service functions
// ignore_for_file: prefer_function_declarations_over_variables
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:naver_crs/pages/6/services/widgets/custom/index.dart';
import '../index.dart';

Function filterSuggestedServices = () {
  getFilteredServices().then((value) {
    updateSuggestedDragServices(value);
  });
};

Function resetDrags = () {
  promotedCatalogs = [];
  promotedServices = [];
  suggestedServices = [];
  serviceSuggestedDragData.value = <Widget>[];
  servicePromotedDragData.value = <Widget>[];
};

Function updateSuggestedDragServices = (filteredServices) async {
  resetDrags();
  var filtered = await filteredServices as Iterable;
  for (var srv in filtered) {
    var state = getServiceState(srv.description);
    if (state == "suggested") {
      suggestedServices.add(srv.description);
      serviceSuggestedDragData.value
          .add(CustomDragableService(service: srv, suggested: true));
    } else {
      promotedCatalogs.add(srv.catalog);
      promotedServices.add(srv.description);
      servicePromotedDragData.value
          .add(DragServiceOptionWidget(service: srv.description));
    }
  }
  globalctx.memory["services"][currentDestination.value] = promotedServices;
  globalctx.memory["catalogs"][currentDestination.value] = promotedCatalogs;
  return;
};

Function getFilteredServices = () async {
  List filtered = await getSrvFiltered();
  filtered = filtered
      .where((service) =>
          service.relation["destination"] == globalDestinationName.value ||
          service.relation["destination"] == "all")
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
      catalog.removeAt(3);
      ServiceDto service = ServiceDto(catalog);
      filteredsrv.add(service);
    }
  }

  return filteredsrv;
};

Function resetServices = () {
  for (var service in promotedServices) {
    setServiceState(service, "suggested");
  }
  promotedServices = [];
  promotedCatalogs = [];
};

Function setServiceState = (service, state) {
  globalctx.states["services"][currentDestination.value] ??= {}.obs;
  globalctx.states["services"][currentDestination.value][service] ??= {}.obs;
  globalctx.states["services"][currentDestination.value][service]["state"] =
      state;
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
