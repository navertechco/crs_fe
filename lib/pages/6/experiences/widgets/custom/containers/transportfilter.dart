import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:naver_crs/pages/6/experiences/widgets/custom/containers/leftHeader.dart';
import 'package:naver_crs/pages/6/experiences/widgets/custom/containers/travelchip.dart';

// ignore: must_be_immutable
class DayExpFilter extends HookWidget {
  const DayExpFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0,
        left: MediaQuery.of(context).size.width * 0.6,
      ),
      child: BodyWidget(),
    );
  }
}

// ignore: must_be_immutable
class BodyWidget extends StatelessWidget {
  const BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var index = getDestinationIndex(
          globalDestinationName.value, globalDestinationType.value);
      Rx<bool> customGuide = Rx(getFormValue(
          globalctx.memory["destinations"], index, "customGuide", false));

      return Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.05,
            left: MediaQuery.of(context).size.width * 0.08,
          ),
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  LeftInfoHeader(
                      fontSize: 13,
                      header: LeftHeader(
                        fontSize: 15,
                      )),
                  LeftDayOptions(
                    customGuide: customGuide,
                    index: index,
                  ),
                ],
              )),
        ),
      );
    });
  }
}

class LeftDayOptions extends StatelessWidget {
  const LeftDayOptions({
    Key? key,
    required this.customGuide,
    required this.index,
  }) : super(key: key);

  final Rx<bool> customGuide;
  final index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.195,
        left: MediaQuery.of(context).size.width * 0.0,
      ),
      child: TravelChips(),
    );
  }
}

class LeftInfoHeader extends StatelessWidget {
  const LeftInfoHeader({
    Key? key,
    required this.header,
    required this.fontSize,
  }) : super(key: key);
  final LeftHeader header;
  final int fontSize;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.01,
              left: MediaQuery.of(context).size.width * 0.0),
          child: Column(children: [
            header,
            CustomTitleWidget(
                fontWeight: FontWeight.bold,
                label:
                    "Current Day: ${dayFormat.format(currentDate.value).replaceAll(" ", "-")}",
                color: Colors.white,
                fontSize: fontSize),
            CustomTitleWidget(
                fontWeight: FontWeight.bold,
                label:
                    "Travel Rhythm: ${findTravelRhythmDescription(parseInt(currentTravelRhythm.value))}",
                color: Colors.white,
                fontSize: fontSize),
            CustomTitleWidget(
                fontWeight: FontWeight.bold,
                label:
                    "Accumulated Hours: ${getTimeStringFromDouble(getRXValue(accumulatedHours, currentDay.value, 0.0))}",
                color: Colors.white,
                fontSize: fontSize),
            CustomTitleWidget(
                fontWeight: FontWeight.bold,
                label:
                    "Left Hours: ${getTimeStringFromDouble(getRXValue(leftHours, currentDay.value, getMaxTrValue(currentTravelRhythm.value)))}",
                color: Colors.white,
                fontSize: fontSize),
          ]),
        ));
  }
}
