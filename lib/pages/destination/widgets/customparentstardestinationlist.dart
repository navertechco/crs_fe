// ignore_file: file_names
import 'package:flutter/material.dart';
import 'package:naver_crs/common/index.dart';

import 'index.dart';

class CustomParentStarDestinationListForm extends StatelessWidget {
  const CustomParentStarDestinationListForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> destinations = getContext("destinations");
    List<DestinationOptionWidget> destinationlist = [];
    destinations.keys.forEach((key) {
      destinationlist.add(
        DestinationOptionWidget(destination: key),
      );
    });
    return DestinationListWidget(
      children: destinationlist,
    );
  }
}
