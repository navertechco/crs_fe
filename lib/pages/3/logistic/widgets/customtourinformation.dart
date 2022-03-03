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
    var arrivalPortCatalog = processCatalog("airport");
    var departurePortCatalog = processCatalog("airport"); 
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
              value: arrivalPort.value,
              disabled: readonly,
              onSaved: (value) {
                ctrl!.state.arrival_port = value!;
                setFormValue(
                    globalctx.memory, "logistic", "arrival_port", value);
                arrivalPort.value = value;
              },
              onChanged: (value) {
                ctrl!.state.arrival_port = value!;
              },
              validator: CustomRequiredValidator(
                  errorText: "Arrival Port is required ", ctx: context),
              label: "Arrival Port\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t",
              data: arrivalPortCatalog,
            ),
            Obx(() {
              return CustomFormDateFieldWidget(
                disabled: readonly,
                initialValue: arrivalDate.value,
                validator: CustomDatetimeGreaterValidator(
                    context: context,
                    compare: departureDate.value,
                    errorText: "There is a problem with the Departure Date"),
                label: "Arrival Date               ",
                onSaved: (value) {
                  ctrl!.state.arrivalDate = value!;
                  arrivalDate.value = value;
                },
                onChanged: (value) {
                  value ??= DateTime.now();
                  ctrl!.state.arrivalDate = value;
                  arrivalDate.value = value;
                },
              );
            }),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            const CustomTitleWidget(
                width: 0.225,
                fontWeight: FontWeight.bold,
                label: "  Departure information"),
            CustomFormDropDownFieldWidget(
              value: departurePort.value,
              disabled: readonly,
              onSaved: (value) {
                ctrl!.state.departure_port = value!;
                setFormValue(
                    globalctx.memory, "logistic", "departure_port", value);
                departurePort.value = value;
              },
              onChanged: (value) {
                ctrl!.state.departure_port = value!;
              },
              validator: CustomRequiredValidator(
                  errorText: "Departure Port is required ", ctx: context),
              label: "Departure Port            ",
              data: departurePortCatalog,
            ),
            Obx(() {
              return CustomFormDateFieldWidget(
                disabled: readonly,
                initialValue: departureDate.value,
                validator: CustomDatetimeGreaterValidator(
                    context: context,
                    compare: arrivalDate.value,
                    errorText: "There is a problem with the Arrival Date",
                    invert: true),
                label: "Departure Date       ",
                onSaved: (value) {
                  ctrl!.state.departureDate = value!;
                  departureDate.value = value;
                },
                onChanged: (value) {
                  value ??= DateTime.now();
                  ctrl!.state.departureDate = value;
                  departureDate.value = value;
                },
              );
            }),
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
