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
    Map<String, dynamic> destinations = getContext("destinations");
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


