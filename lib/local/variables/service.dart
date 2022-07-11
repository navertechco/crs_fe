import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../index.dart';

var serviceSuggestedDragData = Rx(<Widget>[]);
var servicePromotedDragData = Rx(<Widget>[]);
var services =
    getCatalogs(["hotel", "transport_service", "cruises", "food_services"])
        .then((value) => value);
var promotedServices = [];
var suggestedServices = [];