// Service functions
// ignore_for_file: prefer_function_declarations_over_variables
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:naver_crs/pages/6/services/widgets/custom/index.dart';
import 'package:naver_crs/index.dart';

filterSuggestedServices() {
  getFilteredServices().then((value) {
    updateDragServices();
  });
}

getFilteredServices() async {
  filtered = await getSrvFiltered();
  filtered = filtered
      .where((service) =>
          service.relation["destination"] == globalDestinationName.value ||
          service.relation["destination"] == "all")
      .toList();
  globalctx["memory"]["catalogs"][currentDestination.value] ??= [];
  var catalogs = globalctx["memory"]["catalogs"][currentDestination.value];
  var rule = catalogs != null;
  if (rule) {
    filtered = filtered.where((service) {
      var state = getServiceState(service.description);
      if (state == "promoted") {
        return true;
      }

      if (service.catalog == "hotel") {
        var room = service.description.split("-")[1];
        if (promotedServices.where((element) => element.contains(room)) !=
            null) {
          return false;
        }
        return true;
      }

      if (service.catalog == "food_services") {
        var meal = service.description.split("-")[1];
        if (promotedServices.where((element) => element.contains(meal)) !=
            null) {
          return false;
        }
        return true;
      }

      return !catalogs.contains(service.catalog);
    }).toList();
  }
  filtered.sort((a, b) => a.code.compareTo(b.code));
  filtered.sort((a, b) => a.order.compareTo(b.order));
}
//////////////////////////////////////////////////////////////////////////////////////

updateDragServices() {
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
  globalctx["memory"]["services"][currentDestination.value] = promotedServices;
  globalctx["memory"]["catalogs"][currentDestination.value] = promotedCatalogs;
  return;
}

resetDrags() {
  promotedCatalogs = [];
  promotedServices = [];
  suggestedServices = [];
  serviceSuggestedDragData.value = <Widget>[];
  servicePromotedDragData.value = <Widget>[];
}

getSrvFiltered() async {
  filteredsrv = [];

  Iterable srvs = services as Iterable;
  for (var item in srvs) {
    List itemList = item;
    for (var catalog in itemList) {
      catalog = catalog.values.toList();
      CatalogDto service = CatalogDto(catalog);
      filteredsrv.add(service);
    }
  }

  return filteredsrv;
}

paginateDestination(String direction) async {
  int sum = direction == "next" ? 1 : -1;
  if (currentDestination.value + sum >= 0 &&
      currentDestination.value + sum <
          globalctx["memory"]["destinations"].length) {
    currentDestination.value = currentDestination.value + sum;
    globalDestinationIndex.value = currentDestination.value.toString();
    try {
      globalDestinationName.value = globalctx["memory"]["destinations"]
              [globalDestinationIndex.value]
          .value["destination"];
    } catch (e) {
      globalDestinationName.value = "quito";
    }

    globalDestinationType.value = "tour";

    if (currentDestination.value == 0) {
      globalDestinationType.value = "arrival";
    }
    if (currentDestination.value ==
        globalctx["memory"]["destinations"].length - 1) {
      globalDestinationType.value = "departure";
    }

    log("currentDestination.value: ${currentDestination.value}");
    filterSuggestedServices();
  } else if (currentDestination.value + sum >
      globalctx["memory"]["destinations"].length - 1) {
    goto("Resume");
  } else {
    goto("Experiences");
  }
}

findProp(data, props) {
  for (var prop in props) {
    if (data.containsKey(prop)) {
      return data[prop];
    }
  }
}

resetServices() {
  for (var service in promotedServices) {
    setServiceState(service, "suggested");
  }
  updateDragServices();
}

setServiceState(service, state) {
  globalctx["states"]["services"][currentDestination.value] ??= {}.obs;
  globalctx["states"]["services"][currentDestination.value][service] ??= {}.obs;
  globalctx["states"]["services"][currentDestination.value][service]["state"] =
      state;
  filterSuggestedServices();
}

getServiceState(service) {
  globalctx["states"]["services"][currentDestination.value] ??= {}.obs;
  globalctx["states"]["services"][currentDestination.value][service] ??= {}.obs;
  var state = globalctx["states"]["services"][currentDestination.value][service]
      ["state"];
  state ??= "suggested";
  return state;
}

getServiceValueByName(String service) {
  var result;
  try {
    result = getServiceByName(service).value;
  } catch (e) {
    log(e);
  }
  return result;
}

getServiceByName(String service) {
  var result;
  try {
    result =
        (filteredsrv.firstWhere((element) => element.description == service));
  } catch (e) {
    log(e);
  }
  return result;
}
