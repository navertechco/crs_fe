import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import '../index.dart';

var quoteDate = "".obs;
var quoteDisplay = false.obs;
var quoteFilter = Rx(globalctx.memory["tours"]);
var quoteTable = DataTable(columns: [], rows: []).obs;
