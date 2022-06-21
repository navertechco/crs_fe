// Service functions
// ignore_for_file: prefer_function_declarations_over_variables
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:naver_crs/pages/6/services/widgets/custom/index.dart';
import 'package:naver_crs/index.dart';


//  .oooooo..o                                 o8o                           oooooooooooo                                       .    o8o                                 
// d8P'    `Y8                                 `"'                           `888'     `8                                     .o8    `"'                                 
// Y88bo.       .ooooo.  oooo d8b oooo    ooo oooo   .ooooo.   .ooooo.        888         oooo  oooo  ooo. .oo.    .ooooo.  .o888oo oooo   .ooooo.  ooo. .oo.    .oooo.o 
//  `"Y8888o.  d88' `88b `888""8P  `88.  .8'  `888  d88' `"Y8 d88' `88b       888oooo8    `888  `888  `888P"Y88b  d88' `"Y8   888   `888  d88' `88b `888P"Y88b  d88(  "8 
//      `"Y88b 888ooo888  888       `88..8'    888  888       888ooo888       888    "     888   888   888   888  888         888    888  888   888  888   888  `"Y88b.  
// oo     .d8P 888    .o  888        `888'     888  888   .o8 888    .o       888          888   888   888   888  888   .o8   888 .  888  888   888  888   888  o.  )88b 
// 8""88888P'  `Y8bod8P' d888b        `8'     o888o `Y8bod8P' `Y8bod8P'      o888o         `V88V"V8P' o888o o888o `Y8bod8P'   "888" o888o `Y8bod8P' o888o o888o 8""888P' 
                                                                                                                                                                      
                                                                                                                                                                      
                                                                                                                                                                      
       

/// ## filterSuggestedServices
/// *__Method to filter Service Drag Objects__*
///
///### Uses:
/// ```dart
///       filterSuggestedServices();
/// ```
/// ### Returns:
///```dart
///  void
///```
void filterSuggestedServices() {
  getFilteredServices().then((value) {
    updateDragServices();
  });
}

/// ## getFilteredServices
/// *__Method to update Service Drag Objects__*
///
///### Uses:
/// ```dart
///       getFilteredServices();
/// ```
/// ### Returns:
///```dart
///  void
///```
Future getFilteredServices() async {
  filtered = await getFilteredServiceData();
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
}
//////////////////////////////////////////////////////////////////////////////////////

/// ## updateDragServices
/// *__Method to update Service Drag Objects__*
///
///### Uses:
/// ```dart
///       updateDragServices();
/// ```
/// ### Returns:
///```dart
///  void
///```
void updateDragServices() {
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
}

/// ## resetDrags
/// *__Method to reset Service Drag Objects__*
///
///### Uses:
/// ```dart
///       resetDrags();
/// ```
/// ### Returns:
///```dart
///  void
///```
void resetDrags() {
  promotedCatalogs = [];
  promotedServices = [];
  suggestedServices = [];
  serviceSuggestedDragData.value = <Widget>[];
  servicePromotedDragData.value = <Widget>[];
}

/// ## getFilteredServiceData
/// *__Method to get filtered services__*
///
///### Uses:
/// ```dart
///       filtered = await getFilteredServiceData();
/// ```
/// ### Returns:
///```dart
///  dynamic
///```
getFilteredServiceData() async {
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
}

/// ## findProp
/// *__Method to get any property in data__*
///
///### Uses:
/// ```dart
///       Text("${findProp(srvData, ["servicename", "hotelname"])}",
/// ```
/// ### Returns:
///```dart
///  dynamic
///```
dynamic findProp(data, props) {
  for (var prop in props) {
    if (data.containsKey(prop)) {
      return data[prop];
    }
  }
}

/// ## resetServices
/// *__Method to reset all services in context__*
///
///### Uses:
/// ```dart
///     onPressed: () {
///          resetServices();
///           },
/// ```
/// ### Returns:
///```dart
///  void
///```
void resetServices() {
  for (var service in promotedServices) {
    setServiceState(service, "suggested");
  }
  updateDragServices();
}

/// ## setServiceState
/// *__Method to set service state in context__*
///
///### Uses:
/// ```dart
///    setServiceState(service, "suggested");
/// ```
/// ### Returns:
///```dart
///  void
///```
void setServiceState(service, state) {
  globalctx.states["services"][currentDestination.value] ??= {}.obs;
  globalctx.states["services"][currentDestination.value][service] ??= {}.obs;
  globalctx.states["services"][currentDestination.value][service]["state"] =
      state;
  filterSuggestedServices();
}

/// ## getServiceState
/// *__Method to get service state from context__*
///
///### Uses:
/// ```dart
///    suggested = getServiceState(service) == "suggested";
/// ```
/// ### Returns:
///```dart
///  String
///```
String getServiceState(service) {
  globalctx.states["services"][currentDestination.value] ??= {}.obs;
  globalctx.states["services"][currentDestination.value][service] ??= {}.obs;
  String? state =
      globalctx.states["services"][currentDestination.value][service]["state"];
  state ??= "suggested";
  return state;
}

/// ## getServiceValueByName
/// *__Method to get service Value by Name as input__*
///
///### Uses:
/// ```dart
///   var srvData = getServiceValueByName(service);
/// ```
/// ### Returns:
///```dart
///  dynamic
///```
dynamic getServiceValueByName(String service) {
  var result;
  try {
    result = getServiceByName(service).value;
  } catch (e) {
    log(e);
  }
  return result;
}

/// ## getServiceByName
/// *__Method to get service data by Name as input__*
///
///### Uses:
/// ```dart
///  var srvData = getServiceByName(service).value;
/// ```
/// ### Returns:
///```dart
///  dynamic
///```
dynamic getServiceByName(String service) {
  var result;
  try {
    result =
        (filteredsrv.firstWhere((element) => element.description == service));
  } catch (e) {
    log(e);
  }
  return result;
}
