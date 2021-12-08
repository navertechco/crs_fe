import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../index.dart';
import 'index.dart';

class DestinationWidget extends GetView<DestinationController> {
  const DestinationWidget({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    
    return Stack(
      children: const [
        CustomParentStarDestinationListForm(),
        CustomParentStarDestinationForm(),
      ],
    );
  }
}
