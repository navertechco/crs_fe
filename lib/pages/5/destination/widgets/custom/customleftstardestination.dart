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

    List<Widget> destinationlist = [];
    for (Map item in destinationsCatalog) {
      List itemList = item.values.toList();
      CatalogDto destination = CatalogDto(itemList);

      destinationlist.add(
        CustomDragableDestination(destination: destination.description!),
      );
    }
    return DestinationListWidget(
      children: destinationlist,
    );
  }
}
