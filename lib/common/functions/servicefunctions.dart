// Service functions
// ignore_for_file: prefer_function_declarations_over_variables
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:naver_crs/pages/6/services/widgets/custom/index.dart';
import '../index.dart';

List filtered = [];

Function filterSuggestedServices = () {
  getFilteredServices().then((value) {
    updateDragServices();
  });
};

Function getFilteredServices = () async {
  filtered = await getSrvFiltered();
  filtered = filtered
      .where((service) =>
          service.relation["destination"] == globalDestinationName.value ||
          service.relation["destination"] == "all")
      .toList();
  globalctx.memory["catalogs"][currentDestination.value] ??= [];
  var catalogs = globalctx.memory["catalogs"][currentDestination.value];
  var rule = catalogs.isNotEmpty;
  if (rule) {
    filtered = filtered.where((service) {
      var state = getServiceState(service.description);
      if (state == "promoted") {
        return true;
      }

      if (service.catalog == "hotel") {
        var room = service.description.split("-")[1];
        if (promotedServices
            .where((element) => element.contains(room))
            .isNotEmpty) {
          return false;
        }
        return true;
      }

      if (service.catalog == "food_services") {
        var meal = service.description.split("-")[1];
        if (promotedServices
            .where((element) => element.contains(meal))
            .isNotEmpty) {
          return false;
        }
        return true;
      }

      return !catalogs.contains(service.catalog);
    }).toList();
  }
  filtered.sort((a, b) => a.code.compareTo(b.code));
  filtered.sort((a, b) => a.order.compareTo(b.order));
};
//////////////////////////////////////////////////////////////////////////////////////

Function updateDragServices = () {
  resetDrags();
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

Function resetDrags = () {
  promotedCatalogs = [];
  promotedServices = [];
  suggestedServices = [];
  serviceSuggestedDragData.value = <Widget>[];
  servicePromotedDragData.value = <Widget>[];
};

Function getSrvFiltered = () async {
  filteredsrv = [];

  Iterable srvs = await services;
  for (var item in srvs) {
    List itemList = item;
    for (var catalog in itemList) {
      catalog = catalog.values.toList();
      CatalogDto service = CatalogDto(catalog);
      filteredsrv.add(service);
    }
  }

  return filteredsrv;
};
Function paginateDestination = (String direction) {
  int sum = direction == "next" ? 1 : -1;
  if (currentDestination.value + sum >= 0 &&
      currentDestination.value + sum <
          globalctx.memory["destinations"].length) {
    currentDestination.value = currentDestination.value + sum;
    globalDestinationIndex.value = currentDestination.value.toString();
    try {
      globalDestinationName.value = globalctx
          .memory["destinations"][globalDestinationIndex.value]
          .value["destination"];
    } catch (e) {
      globalDestinationName.value = "quito";
    }

    if (currentDestination.value == 0) {
      globalDestinationType.value = "arrival";
    } else if (currentDestination.value <
        globalctx.memory["destinations"].length - 1) {
      globalDestinationType.value = "tour";
    } else {
      globalDestinationType.value = "departure";
    }
    log("currentDestination.value: ${currentDestination.value}");
    filterSuggestedServices();
  } else if (currentDestination.value + sum >
      globalctx.memory["destinations"].length - 1) {
    goto("Resume");
  }
};

Function findProp = (data, props) {
  for (var prop in props) {
    if (data.containsKey(prop)) {
      return data[prop];
    }
  }
};
Function resetServices = () {
  for (var service in promotedServices) {
    setServiceState(service, "suggested");
  }
  updateDragServices();
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
