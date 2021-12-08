import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';

class CustomCustomerDataForm extends StatelessWidget {
  const CustomCustomerDataForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.4,
                left: MediaQuery.of(context).size.width * 0.08,
              ),
              child: SizedBox(
                child: Column(children: [
                  const CustomTitleWidget(
                      width: 0.225,
                      fontWeight: FontWeight.bold,
                      label: " Basic information"),
                  const CustomFormDropDownFieldWidget(
                    label: "Customer Type          ",
                    data: [
                      {"code": "1", "description": "Ecuador"},
                      // {"code": "2", "description": "hola 2"},
                    ],
                  ),
                  const CustomFormTextFieldWidget(
                      hintText: "Names                          ", width: 0.36),
                  const CustomFormTextFieldWidget(
                      hintText: "Surnames                          ",
                      width: 0.36),
                  const CustomFormTextFieldWidget(
                    label: "DNI/PASSPORT             ",
                  ),
                  Row(
                    children: const [
                      CustomFormTextFieldWidget(hintText: "Age", width: 0.1),
                      CustomFormTextFieldWidget(
                          label: "Date of Birth ", width: 0.15),
                    ],
                  ),
                  // CustomKeypadWidget(),
                ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.4,
                left: MediaQuery.of(context).size.width * 0.08,
              ),
              child: SizedBox(
                child: Column(children: [
                  const CustomTitleWidget(
                      width: 0.225, fontWeight: FontWeight.bold, label: "  "),
                  const CustomFormTextFieldWidget(
                      hintText: "Address                          ",
                      width: 0.36),
                  const CustomFormTextFieldWidget(
                      hintText: "e-Mail                          ",
                      width: 0.36),
                  Row(
                    children: const [
                      CustomFormTextFieldWidget(
                          hintText: "Lead Passenger                  ",
                          width: 0.2),
                      CustomFormTextFieldWidget(
                          hintText: "Travel Code                ", width: 0.15),
                    ],
                  ),
                  const CustomFormDropDownFieldWidget(
                    label: "Passengers Number",
                    data: [
                      {"code": "1", "description": "1"},
                      {"code": "2", "description": "2"},
                      {"code": "3", "description": "3-5"},
                      {"code": "4", "description": "6-10"},
                      {"code": "5", "description": "11-20"},
                      {"code": "6", "description": "21-30"},
                    ],
                  ),
                  const CustomFormDateFieldWidget(
                      hintText: "Time of Travel", width: 0.355),
                ]),
              ),
            ),
          ],
        ),
        Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.7),
          child: GestureDetector(
            onTap: () {
              Get.toNamed("/Destination");
            },
            child: const CustomTitleWidget(
                width: 0.1,
                fontWeight: FontWeight.bold,
                label:
                    " \n                                                 Next >"),
          ),
        ),
      ],
    );
  }
}
