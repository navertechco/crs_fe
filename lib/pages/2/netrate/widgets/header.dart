import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'customformtitle.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map tour = globalctx.memory["tour"];
    return Column(
      children: [
        CustomFormTitleWidget(
            level: 2,
            label:
                "Data report #(Between: ${tour["arrival_date"]} and ${tour["departure_date"]})"),
      ],
    );
  }
}
