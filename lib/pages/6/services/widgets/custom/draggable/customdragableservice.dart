import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';

import '../../index.dart';

class CustomDragableService extends StatelessWidget {
  const CustomDragableService({
    Key? key,
    required this.service,
    required this.suggested,
  }) : super(key: key);

  final service;
  final bool suggested;
  @override
  Widget build(BuildContext context) {
    var serviceOptionWidget = ServiceOptionWidget(
      service: service.description,
      suggested: suggested,
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.2,
    );

    String title = service.description;

    return Draggable<String>(
      maxSimultaneousDrags: expDraggable.value,
      data: title,
      feedback: serviceOptionWidget,
      childWhenDragging: serviceOptionWidget,
      child: serviceOptionWidget,
    );
  }
}
