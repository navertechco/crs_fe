import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../index.dart';

class CustomTourInformationForm extends StatelessWidget {
  const CustomTourInformationForm(
      {Key? key, this.formKey, this.profile, this.ctrl})
      : super(key: key);
  final formKey;
  final bool? profile;
  final TourController? ctrl;

  @override
  Widget build(BuildContext context) {
    var state = ctrl!.state;
    var tour = getContext("tour");
    var readonly = validateData(tour);
    var destinationCountry = processCatalog("destination_country");
    var purpose = processCatalog("purpose");
    var accomodationType = processCatalog("budget");
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.18,
        left: MediaQuery.of(context).size.width * 0.54,
      ),
      child: SizedBox(
        child: Column(children: [
          const CustomTitleWidget(
            width: 0.3,
            fontWeight: FontWeight.bold,
            label: "  Agent 1",
          ),
          const CustomTitleWidget(
              width: 0.225,
              fontWeight: FontWeight.bold,
              label: "  Tour information"),
          CustomFormDropDownFieldWidget(
            value: getValue(tour, "country", def: "9999"),
            disabled: readonly,
            onSaved: (value) {
              state.country = value!;
            },
            onChanged: (value) {
              state.country = value!;
            },
            label: "Destination Country",
            data: destinationCountry,
          ),
          CustomFormDropDownFieldWidget(
            value: getValue(tour, "purpose", def: "9999"),
            disabled: readonly,
            onSaved: (value) {
              state.purpose = value!;
            },
            onChanged: (value) {
              state.purpose = value!;
            },
            label: "Purpose                        ",
            data: purpose,
          ),
          CustomFormDropDownFieldWidget(
            value: getValue(tour, "accomodation_type", def: "9999"),
            disabled: readonly,
            onSaved: (value) {
              state.accomodation_type = value!;
            },
            onChanged: (value) {
              state.accomodation_type = value!;
            },
            label: "Accomodation Type",
            data: accomodationType,
          ),
          const CustomTitleWidget(
              width: 0.2,
              fontWeight: FontWeight.bold,
              label: "  Date                              "),
          CustomFormDateFieldWidget(
              initialValue: getValue(tour, "arrival_date", def: DateTime.now()),
              label: "Arrival Date               "),
          CustomFormDateFieldWidget(
              initialValue: getValue(tour, "arrival_date", def: DateTime.now()),
              label: "Departure Date       "),
          CustomFormTextFieldWidget(
              disabled: validateData(tour),
              value: getValue(tour, "passengers", def: "0"),
              onSaved: (value) {
                state.passengers = value!;
              },
              keyboardType: TextInputType.number,
              label: "Passengers                  ",
              width: 0.20),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.2,
              left: MediaQuery.of(context).size.width * 0.022,
            ),
            child: CustomKeypadWidget(
                width: 0.265,
                onPrevious: () {
                  Get.back();
                },
                onNext: () {
                  ctrl!.saveTour();
                }),
          ),
        ]),
      ),
    );
  }
}
