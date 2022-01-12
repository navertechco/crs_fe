// ignore_file: file_names
import 'package:flutter/material.dart';

import '../../../../index.dart';
import '../index.dart';
import 'index.dart';

class CustomLeftStarDestinationForm extends StatelessWidget {
  const CustomLeftStarDestinationForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var params = processCatalog("params");
    Map<dynamic, dynamic> destinations = getValue(params[0], "value");
    List<Widget> destinationlist = [];
    for (var destination in destinations.keys) {
      destinationlist.add(
        CustomDragableDestination(destination: destination),
      );
    }
    return DestinationListWidget(
      children: destinationlist,
    );
  }
}
