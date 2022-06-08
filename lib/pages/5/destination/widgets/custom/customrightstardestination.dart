import 'package:flutter/material.dart';
import '../index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';

class CustomRightStarDestinationForm extends StatelessWidget {
  const CustomRightStarDestinationForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.055,
                left: MediaQuery.of(context).size.width * 0.5,
              ),
              child: DragDestinationWidget(
                  destination: arrival["description"],
                  index: 0,
                  type: "arrival",
                  out: true),
            ),
            DestinationsOrderableListWidget(),
            Obx(() {
              return Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.0,
                  left: MediaQuery.of(context).size.width * 0.5,
                ),
                child: DragDestinationWidget(
                    destination: departure["description"],
                    index: globalctx.destinationDragData.value.length - 1,
                    type: "departure",
                    out: true),
              );
            }),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.86,
            left: MediaQuery.of(context).size.width * 0.0,
          ),
          child: const KeyPadWidget(),
        ),
      ],
    );
  }
}
