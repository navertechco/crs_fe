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
    return DestinationListWidget(
      children: getDestinationList(),
    );
  }
}
