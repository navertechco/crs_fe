import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/validators.dart';
import '../../../index.dart';
import '../index.dart';

class CustomLogisticInformationForm extends StatelessWidget {
  CustomLogisticInformationForm({Key? key, this.profile, this.ctrl})
      : super(key: key);

  final bool? profile;
  final LogisticController? ctrl;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var tourdata = globalctx.memory;
    var logistic = getValue(tourdata, "logistic");
    var readonly = getContext("readonly") ?? false;
    var arrivalPort = processCatalog("airport");
    var departurePort = processCatalog("airport");

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
              label: "Logistic Information",
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            const CustomTitleWidget(
                width: 0.225,
                fontWeight: FontWeight.bold,
                label: "  Arrival information"),
            CustomFormDropDownFieldWidget(
              value: getValue(logistic, "arrival_port", def: "1"),
              disabled: readonly,
              onSaved: (value) {
                ctrl!.state.arrival_port = value!;
              },
              onChanged: (value) {
                ctrl!.state.arrival_port = value!;
              },
              validator: CustomRequiredValidator(
                  errorText: "Arrival Port is required ", ctx: context),
              label: "Arrival Port\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t",
              data: arrivalPort,
            ),
            CustomFormDateFieldWidget(
              disabled: readonly,
              initialValue: getDateValue(logistic, "arrival_date",
                  def: DateTime(2022, 01, 31)),
              validator: (date) {
                CustomDatetimeRequiredValidator(date,
                    context: context, errorText: "Arrival Text is Required");
              },
              label: "Arrival Date               ",
              onSaved: (value) {
                ctrl!.state.arrivalDate = value.toString();
              },
              onChanged: (value) {
                ctrl!.state.arrivalDate = value.toString();
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            const CustomTitleWidget(
                width: 0.225,
                fontWeight: FontWeight.bold,
                label: "  Departure information"),
            CustomFormDropDownFieldWidget(
              value: getValue(logistic, "departure_port", def: "1"),
              disabled: readonly,
              onSaved: (value) {
                ctrl!.state.departure_port = value!;
              },
              onChanged: (value) {
                ctrl!.state.departure_port = value!;
              },
              validator: CustomRequiredValidator(
                  errorText: "Departure Port is required ", ctx: context),
              label: "Departure Port            ",
              data: departurePort,
            ),
            CustomFormDateFieldWidget(
              disabled: readonly,
              initialValue: getDateValue(logistic, "departure_date",
                  def: DateTime(2022, 02, 02)),
              validator: (date) {
                CustomDatetimeRequiredValidator(date,
                    context: context, errorText: "Departure Text is Required");
              },
              label: "Departure Date       ",
              onSaved: (value) {
                if (value != null) {
                  ctrl!.state.departureDate = value.toString();
                }
              },
              onChanged: (value) {
                if (value != null) {
                  ctrl!.state.departureDate = value.toString();
                }
              },
            ),
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
                      ctrl!.saveLogistic();
                      selectedIndex++;
                    }
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}
