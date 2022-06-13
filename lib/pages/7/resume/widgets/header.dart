import 'package:counter/counter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:naver_crs/index.dart';
import 'package:naver_crs/pages/2/netrate/widgets/custompadingtitle.dart';
import 'customformtitle.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomFormTitleWidget(level: 1, label: "Client Information"),
        Row(
          children: [
            CustomDetailWidget(
                label: "Names: ",
                value: getFormValue(globalctx.memory, "customer", "names", '')),
            CustomDetailWidget(
                label: "Last Names: ",
                value: getFormValue(
                    globalctx.memory, "customer", "last_names", '')),
            CustomDetailWidget(
                label: "email: ",
                value: getFormValue(globalctx.memory, "customer", "email", '')),
            CustomDetailWidget(
                label: "dni: ",
                value: getFormValue(globalctx.memory, "customer", "dni", '')),
          ],
        ),
        Row(
          children: [
            CustomDetailWidget(
                label: "Lead Passenger: ",
                value: getFormValue(
                    globalctx.memory, "customer", "lead_passenger", '')),
            CustomDetailWidget(
                label: "Address Line: ",
                value: getFormValue(
                    globalctx.memory, "customer", "address_line", '')),
            CustomDetailWidget(
                label: "City: ",
                value: getFormValue(globalctx.memory, "customer", "city", '')),
            CustomDetailWidget(
                label: "Country: ",
                value:
                    getFormValue(globalctx.memory, "customer", "country", '')),
          ],
        ),
        const CustomFormTitleWidget(level: 1, label: "Tour Information"),
        Row(
          children: [
            CustomDetailWidget(
                label: "Tour Code: ",
                value: getFormValue(globalctx.memory, "tour", "code", '')),
            CustomDetailWidget(
                label: "Passengers: ",
                value:
                    getFormValue(globalctx.memory, "tour", "passengers", '')),
            CustomDetailWidget(
                label: "Budget: ",
                value: getFormValue(
                    globalctx.memory, "tour", "accomodation_type", '')),
            CustomDetailWidget(
                label: "Country: ",
                value: getFormValue(globalctx.memory, "tour", "country", '')),
          ],
        ),
        const CustomFormTitleWidget(level: 1, label: "Logistic Information"),
        Row(
          children: [
            CustomDetailWidget(
                label: "Arrival Port: ",
                value: getFormValue(
                    globalctx.memory, "logistic", "arrival_port", '')),
            CustomDetailWidget(
                label: "Departure Port: ",
                value: getFormValue(
                    globalctx.memory, "logistic", "departure_port", '')),
            CustomDetailWidget(
                label: "Tour option: ",
                value: getFormValue(
                    globalctx.memory, "logistic", "tour_option", '')),
          ],
        ),
        Row(
          children: [
            CustomDetailWidget(
                label: "Arrival Date: ",
                value: getFormValue(
                    globalctx.memory, "logistic", "arrival_date", '')),
            CustomDetailWidget(
                label: "Departure Date: ",
                value: getFormValue(
                    globalctx.memory, "logistic", "departure_date", '')),
          ],
        ),
        CustomFormTitleWidget(
            level: 2,
            label:
                "Itinerary #(Between: ${currentDayFormat.format(arrivalDate.value)} and ${currentDayFormat.format(departureDate.value)})"),
        Row(
          children: [
            CustomPadingTitleWidget(
                customlabel: "\t\tGuides:\t\t\t\t",
                fontWeight: FontWeight.bold),
            Counter(
              initial: 0,
              min: 0,
              max: 50,
              step: 1,
              onValueChanged: (value) {},
            ),
          ],
        ),
        OptionField(
            label: "\t\tMeal Option (A, B, C, D):\t\t\t\t", data: [0, 1, 2, 3])
      ],
    );
  }
}

class OptionField extends StatelessWidget {
  const OptionField({
    Key? key,
    this.label,
    this.data,
  }) : super(key: key);
  final label;
  final data;
  @override
  Widget build(BuildContext context) {
    var groupValue = 0.obs;
    changeField(value) {
      groupValue.value = value;
    }

    var dataField = <Widget>[];
    for (var i = 0; i < data.length; i++) {
      dataField.add(
        Radio(value: i, groupValue: groupValue.value, onChanged: changeField),
      );
    }
    return Obx(() => Row(
          children: [
            CustomPadingTitleWidget(
                customlabel: label, fontWeight: FontWeight.bold),
            ...dataField
          ],
        ));
  }
}

class CustomDetailWidget extends StatelessWidget {
  const CustomDetailWidget({
    Key? key,
    this.label,
    this.value,
  }) : super(key: key);
  final label;
  final value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.08,
        top: MediaQuery.of(context).size.height * 0.001,
      ),
      child: Row(
        children: [
          CustomFormLabelWidget(
            label: label,
            fontWeight: FontWeight.bold,
          ),
          CustomFormLabelWidget(label: value.toString()),
        ],
      ),
    );
  }
}
