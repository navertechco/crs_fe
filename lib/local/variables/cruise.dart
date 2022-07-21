import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:naver_crs/index.dart';

var cruiseFormat = ''.obs;
var cruiseDay = '0'.obs;
var cruiseShip = ''.obs;
var cruiseRange = ''.obs;
var cruiseCategory = ''.obs;
var cruiseKey = ''.obs;
var cruiseType = ''.obs;
var cruiseCabine = [].obs;
var cruiseCabineLocation = ''.obs;
var cruiseModality = ''.obs;
var cruisePax = ''.obs;
var cruiseTriple = ''.obs;
var cruiseStarts = ''.obs;
var cruiseEnds = ''.obs;
var cruiseIslet = ''.obs;
var cruiseItinerary = Rx(<String>[]);
var cruisePort = ''.obs;
var cruiseAnimal = ''.obs;
var arrivalEdit = false.obs;
var departureEdit = false.obs;
var cruiseEdit = false.obs;
var selectedCruise = ''.obs;
Rx<Iterable> cruiseResults = Rx([]);
List cruises = findCatalog("cruises");
List cabine = findCatalog("cabine");
List itinerary = findCatalog("itinerary");
List animals = findCatalog("animals");
var cruiseTable = Rx(
  DataTable(
    columns: searcherHeader.value,
    rows: searcherDetail.value,
  ),
);
