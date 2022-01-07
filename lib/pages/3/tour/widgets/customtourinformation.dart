import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../index.dart';

class CustomTourInformationForm extends StatelessWidget {
  CustomTourInformationForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            onSaved: (value) {},
            onChanged: (value) {},
            label: "Destination Country",
            data: destinationCountry,
          ),
          CustomFormDropDownFieldWidget(
            onSaved: (value) {},
            onChanged: (value) {},
            label: "Purpose                        ",
            data: purpose,
          ),
          CustomFormDropDownFieldWidget(
            onSaved: (value) {},
            onChanged: (value) {},
            label: "Accomodation Type",
            data: accomodationType,
          ),
          const CustomTitleWidget(
              width: 0.2,
              fontWeight: FontWeight.bold,
              label: "  Date                              "),
          const CustomFormDateFieldWidget(label: "Arrival Date               "),
          const CustomFormDateFieldWidget(label: "Departure Date       "),
          CustomFormTextFieldWidget(
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
                  Get.toNamed("/Customer");
                }),
          ),
        ]),
      ),
    );
  }
}
