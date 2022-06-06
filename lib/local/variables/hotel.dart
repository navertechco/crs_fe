import 'package:get/get_rx/src/rx_types/rx_types.dart';

var hotelCategory = ''.obs;
var hotelRoomCategory = [].obs;
var hotelName = ''.obs;
Rx<Iterable> hotelResults = Rx([]);
var budgets = {"1": "5 stars", "0": "4 stars"};
List filteredHotel = [];
