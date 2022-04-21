// ignore_file: file_names
import 'package:flutter/material.dart';
import 'package:naver_crs/common/index.dart';

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
    List destinations = destinationsCatalog.toList();
    destinations.sort((a, b) {
      var arrivalData = toCatalog(filterCatalog(
          "destinations", "description", arrival.value["description"])[0]);
      var arrivalLat = arrivalData.relation["latitude"];
      var arrivalLong = arrivalData.relation["longitude"];
      var aLat = toCatalog(a).relation["latitude"];
      var bLat = toCatalog(b).relation["latitude"];
      var aLong = toCatalog(a).relation["longitude"];
      var bLong = toCatalog(b).relation["longitude"];
      var aDistance = getDistance(aLat, aLong, arrivalLat, arrivalLong).toInt();
      var bDistance = getDistance(bLat, bLong, arrivalLat, arrivalLong).toInt();
      return aDistance.compareTo(bDistance);
    });
    for (Map item in destinations) {
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
