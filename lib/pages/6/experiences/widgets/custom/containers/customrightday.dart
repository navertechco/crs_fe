import 'package:flutter/material.dart';
import '../index.dart';

class CustomRightDayWidget extends StatelessWidget {
  const CustomRightDayWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.3,
          left: MediaQuery.of(context).size.width * 0.375),
      child: Column(
        children: [
          CustomHeaderWidget(),
          CustomContentWidget(),
          CustomFooterWidget(),
        ],
      ),
    );
  }
}
