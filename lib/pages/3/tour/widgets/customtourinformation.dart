import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:sweetalert/sweetalert.dart';

import '../../../index.dart';

class CustomTourInformationForm extends StatelessWidget {
  CustomTourInformationForm({Key? key, this.profile, this.ctrl})
      : super(key: key);

  final bool? profile;
  final TourController? ctrl;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var tourdata = getContext("tour");
    var tour = getValue(tourdata, "tour");
    var readonly = validateData(tour);
    var destinationCountry = processCatalog("destination_country");
    var purpose = processCatalog("purpose");
    var accomodationType = processCatalog("budget");

    return Form(
      key: _formKey,
      child: Padding(
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
              value: getValue(tour, "country", def: "1"),
              disabled: readonly,
              validator: CustomRequiredValidator(
                  errorText: "country is required ", ctx: context),
              onSaved: (value) {
                ctrl!.state.country = value!;
              },
              onChanged: (value) {
                ctrl!.state.country = value!;
              },
              label: "Destination Country ",
              data: destinationCountry,
            ),
            CustomFormDropDownFieldWidget(
              validator: CustomRequiredValidator(
                  errorText: "Purpose is required ", ctx: context),
              value: getValue(tour, "purpose", def: "1"),
              disabled: readonly,
              onSaved: (value) {
                ctrl!.state.purpose = value!;
              },
              onChanged: (value) {
                ctrl!.state.purpose = value!;
              },
              label: "Purpose                         ",
              data: purpose,
            ),
            CustomFormDropDownFieldWidget(
              value: getValue(tour, "accomodation_type", def: "1"),
              disabled: readonly,
              onSaved: (value) {
                ctrl!.state.accomodation_type = value!;
              },
              onChanged: (value) {
                ctrl!.state.accomodation_type = value!;
              },
              validator: CustomRequiredValidator(
                  errorText: "Accomodation type is required ", ctx: context),
              label: "Accomodation Type",
              data: accomodationType,
            ),
            const CustomTitleWidget(
                width: 0.2,
                fontWeight: FontWeight.bold,
                label: "  Date                              "),
            CustomFormDateFieldWidget(
              initialValue:
                  getValue(tour, "arrival_date", def: DateTime(2022, 01, 31)),
              validator: (date) {
                CustomDatetimeRequiredValidator(date,
                    context: context, errorText: "Arrival Text is Required");
              },
              label: "Arrival Date               ",
              onSaved: (value) {
                ctrl!.state.arrivalDate = value!;
              },
              onChanged: (value) {
                ctrl!.state.arrivalDate = value!;
              },
            ),
            CustomFormDateFieldWidget(
              initialValue:
                  getValue(tour, "departure_date", def: DateTime(2022, 02, 07)),
              validator: (date) {
                CustomDatetimeRequiredValidator(date,
                    context: context, errorText: "Departure Text is Required");
              },
              label: "Departure Date       ",
              onSaved: (value) {
                ctrl!.state.departureDate = value!;
              },
              onChanged: (value) {
                ctrl!.state.departureDate = value!;
              },
            ),
            CustomFormTextFieldWidget(
                disabled: validateData(tour),
                value: getValue(tour, "passengers", def: "10"),
                validator: CustomRequiredValidator(
                    errorText: "Passengers is required ", ctx: context),
                onSaved: (value) {
                  ctrl!.state.passengers = value!;
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
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      ctrl!.saveTour();
                    }
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}
