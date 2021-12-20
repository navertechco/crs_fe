import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';

class CustomTourInformationForm extends StatelessWidget {
  const CustomTourInformationForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            data: const [
              {"code": "1", "description": "Ecuador"},
              // {"code": "2", "description": "hola 2"},
            ],
          ),
          CustomFormDropDownFieldWidget(
            onSaved: (value) {},
            onChanged: (value) {},
            label: "Purpose                        ",
            data: const [
              {"code": "1", "description": "AVENTURE"},
              {"code": "2", "description": "CULLINARY"},
            ],
          ),
          CustomFormDropDownFieldWidget(
            onSaved: (value) {},
            onChanged: (value) {},
            label: "Accomodation Type",
            data: const [
              {"code": "1", "description": "5 STARS"},
              {"code": "2", "description": "4 STARS"},
            ],
          ),
          const CustomTitleWidget(
              width: 0.2,
              fontWeight: FontWeight.bold,
              label: "  Date                              "),
          const CustomFormDateFieldWidget(label: "Arrival Date               "),
          const CustomFormDateFieldWidget(label: "Departure Date       "),
          CustomFormTextFieldWidget(
              label: "Passengers                  ", width: 0.20),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.175,
              left: MediaQuery.of(context).size.width * 0.022,
            ),
            child: CustomKeypadWidget(
                width: 0.24,
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
