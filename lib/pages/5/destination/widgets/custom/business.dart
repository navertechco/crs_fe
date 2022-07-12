
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../index.dart';
import '../../../../index.dart';
import '../index.dart';

class BusinessExpDayWidget extends StatelessWidget {
  const BusinessExpDayWidget({
    Key? key,
    required this.explorationDay,
    required this.destination,
    required this.index,
    required this.type,
  }) : super(key: key);

  final Rx<int> explorationDay;
  final String destination;
  final index;
  final type;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var expDay = explorationDay.value;

      if (destination != "galapagos") {
        return ExpDaysCounterWidget(index: index, type: type);
      }
      return Text('');
    });
  }
}

class BusinessHotelWidget extends StatelessWidget {
  const BusinessHotelWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final index;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var t = arrivalDate.value;
      return HotelWidget(index: index);
    });
  }
}

class BusinessArrivalWidget extends StatelessWidget {
  const BusinessArrivalWidget({
    Key? key,
    required this.explorationMode,
    required this.type,
    required this.destination,
    required this.index,
    required this.arrivalHourCatalog,
  }) : super(key: key);

  final RxString explorationMode;
  final type;
  final String destination;
  final index;
  final List<Map<String, dynamic>> arrivalHourCatalog;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var expMode = explorationMode.value;
      if (type == "arrival" && destination == arrival["description"]) {
        return ArrivalWidget(
            index: index, arrivalHourCatalog: arrivalHourCatalog);
      }
      return Text('');
    });
  }
}

class BusinessTrWidget extends StatelessWidget {
  const BusinessTrWidget({
    Key? key,
    required this.explorationMode,
    required this.index,
    required this.type,
    required this.destination,
  }) : super(key: key);

  final RxString explorationMode;
  final index;
  final type;
  final String destination;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var expMode = explorationMode.value;
      setFormValue(globalctx.memory["destinations"], index, "type", type);
      setFormValue(globalctx.memory["destinations"], index, "index", index);
      setFormValue(
          globalctx.memory["destinations"], index, "destination", destination);
      if (explorationMode.value != "2") {
        return TRWidget(
            type: type,
            explorationMode: explorationMode,
            destination: destination,
            index: index);
      }
      return Text('');
    });
  }
}

class BusinessKAWidget extends StatelessWidget {
  const BusinessKAWidget({
    Key? key,
    required this.explorationMode,
    required this.keyActivities,
    required this.index,
  }) : super(key: key);

  final RxString explorationMode;
  final List<String> keyActivities;
  final index;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (explorationMode.value != "2") {
        return KAWidget(keyActivities: keyActivities, index: index);
      }
      return Text('');
    });
  }
}

class BuisnessExpmodeWidget extends StatelessWidget {
  const BuisnessExpmodeWidget({
    Key? key,
    required this.destination,
    required this.explorationDay,
    required this.explorationMode,
    required this.index,
  }) : super(key: key);

  final String destination;
  final Rx<int> explorationDay;
  final RxString explorationMode;
  final index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: (() {
        if (destination == "galapagos" || destination == "amazon") {
          return Obx(() {
            var expDay = explorationDay.value;
            return ExpModeWidget(
                explorationMode: explorationMode,
                index: index,
                destination: destination);
          });
        }
      })(),
    );
  }
}

class BusinessRouteWidget extends StatelessWidget {
  const BusinessRouteWidget({
    Key? key,
    required this.explorationDay,
    required this.destination,
    required this.explorationMode,
  }) : super(key: key);

  final Rx<int> explorationDay;
  final String destination;
  final RxString explorationMode;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var expDay = explorationDay.value;
      if ((destination == "galapagos" &&
              (explorationMode.value == "3" || explorationMode.value == "1")) ||
          (destination != "galapagos" &&
              (getDestiinationRoutes(destination).isNotEmpty))) {
        {
          return RouteWidget();
        }
      } else {
        return Text('');
      }
    });
  }
}

class BusinessIHWidget extends StatelessWidget {
  const BusinessIHWidget({
    Key? key,
    required this.explorationMode,
    required this.destination,
    required this.index,
  }) : super(key: key);

  final RxString explorationMode;
  final String destination;
  final index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(child: Obx(() {
      var expMode = explorationMode.value;
      if (destination == "galapagos" &&
          (explorationMode.value == "3" || explorationMode.value == "1")) {
        return Column(
          children: [
            Obx(() {
              return CustomFormCalendarFieldWidget(
                  label: "IH Range                    ",
                  initialStartDate: cruiseEndDate.value,
                  initialEndDate: departureDate.value.add(Duration(days: -1)),
                  minimumDate: cruiseEndDate.value,
                  maximumDate: departureDate.value.add(Duration(days: -1)),
                  startEndDateChange: (start, end) {
                    iHStartDate.value = start;
                    iHEndDate.value = end;
                    setFormValue(globalctx.memory["destinations"], index,
                        "iHStartDate", start);
                    setFormValue(globalctx.memory["destinations"], index,
                        "iHEndDate", end);
                  },
                  onSaved: () {});
            }),
          ],
        );
      }
      return Text('');
    }));
  }
}
