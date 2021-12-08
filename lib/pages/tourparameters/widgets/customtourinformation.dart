


import 'package:flutter/material.dart';
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
        child: Column(children: const [
          CustomTitleWidget(
            width: 0.3,
            fontWeight: FontWeight.bold,
            label: "  Agent 1",
          ),
          CustomTitleWidget(
              width: 0.225,
              fontWeight: FontWeight.bold,
              label: "  Tour information"),
          CustomFormDropDownFieldWidget(
            label: "Destination Country",
            data: [
              {"code": "1", "description": "Ecuador"},
              // {"code": "2", "description": "hola 2"},
            ],
          ),
          CustomFormDropDownFieldWidget(
            label: "Purpose                        ",
            data: [
              {"code": "1", "description": "AVENTURE"},
              {"code": "2", "description": "CULLINARY"},
            ],
          ),
          CustomFormDropDownFieldWidget(
            label: "Accomodation Type",
            data: [
              {"code": "1", "description": "5 STARS"},
              {"code": "2", "description": "4 STARS"},
            ],
          ),
          CustomFormDropDownFieldWidget(
            label: "Destination                  ",
            data: [
              {"code": "1", "description": "NORTH HIGHLANDS"},
              {"code": "2", "description": "SOUTH HIGHLANDS"},
              {"code": "3", "description": "COAST"},
              {"code": "4", "description": "GALAPAGOS"},
              {"code": "5", "description": "AMAZON"},
            ],
          ),
          CustomTitleWidget(
              width: 0.2,
              fontWeight: FontWeight.bold,
              label: "  Date                              "),
          CustomFormDateFieldWidget(label: "Arrival Date                 "),
          CustomFormDateFieldWidget(label: "Departure Date         "),
          CustomFormDropDownFieldWidget(
            label: "Passengers                 ",
            data: [
              {"code": "1", "description": "1"},
              {"code": "2", "description": "2"},
              {"code": "3", "description": "3-5"},
              {"code": "4", "description": "6-10"},
              {"code": "5", "description": "11-20"},
              {"code": "6", "description": "21-30"},
            ],
          ),
          CustomKeypadWidget(),
        ]),
      ),
    );
  }
}
