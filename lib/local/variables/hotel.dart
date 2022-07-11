import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import '../../index.dart';

var hotelCategory = '0'.obs;
var hotelRoomCategory = [].obs;
var hotelName = ''.obs;
Rx<Iterable> hotelResults = Rx([]);
var budgets = {"1": "5 stars", "0": "4 stars"};
List filteredHotel = [];
var currentHotelName = Rx(getFormValue(
    globalctx.memory["destinations"], globalDestinationIndex, "hotelName", ''));
var hotelTable = Rx(
  DataTable(
    columns: searcherHeader.value,
    rows: searcherDetail.value,
  ),
);
var hotelFilterMemory = findCatalog("more_hotel_filters")
    .where((e) {
      var rule = true;
      var filter = hotelResults.value
          .where((f) => f["value"][e["value"]["key"]] == "Yes")
          .toList()
          .map((e) => e["description"].toString())
          .toList();
      rule = filter.contains(e["description"]);
      return rule;
    })
    .toList()
    .map((e) => e["description"].toString())
    .toList()
    .obs;
