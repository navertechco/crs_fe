import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

var quoteDate = ''.obs;
var quoteName = ''.obs;
var quoteId = ''.obs;
var quoteState = ''.obs;
var quoteDisplay = false.obs;
var quoteFilter = Rx(globalctx.memory["tours"]);
var quoteTable = DataTable(columns: [], rows: []).obs;
Rx<Iterable> quoteResults = Rx([]);
