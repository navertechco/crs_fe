import 'package:flutter/material.dart';

import 'index.dart';

class LeftWidget extends StatelessWidget {
  const LeftWidget({
    Key? key,
    required this.experience,
  }) : super(key: key);

  final experience;

  @override
  Widget build(BuildContext context) {
    return CarouselWidget();
  }
}
