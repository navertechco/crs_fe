import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

import '../../../../index.dart';

class DestinationDetailState extends GetXState   {
  final localDestination = Rx(getContext('destinationdata'));
  var memory = {};
  
  @override
  void initState() {
    super.initState();
  }
}
