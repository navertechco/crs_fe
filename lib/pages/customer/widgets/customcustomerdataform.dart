import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';

class CustomCustomerDataForm extends StatelessWidget {
  const CustomCustomerDataForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rx<List<Map<String, dynamic>>> citylist = Rx([]);
    RxString customerType = "".obs;

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
                  Row(
                    children: [
                      CustomFormDropDownFieldWidget(
                        width: 0.2,
                        label: "Customer Type          ",
                        onChanged: (value) {
                          customerType.value = value!;
                          print(value);
                        },
                        onSaved: (value) {
                          customerType.value = value!;
                          print(value);
                        },
                        data: const [
                          {"code": "1", "description": "Legal"},
                          {"code": "2", "description": "Natural"},
                        ],
                      ),
                    ],
                  ),
                  Obx(() {
                    if (customerType.value == "1") {
                      return const CustomFormTextFieldWidget(
                          label: "Tax Id                            ",
                          width: 0.2);
                    } else {
                      return Text("");
                    }
                  }),

                  Row(
                    children: const [
                      CustomFormTextFieldWidget(
                          hintText: "Names                          ",
                          width: 0.17),
                      CustomFormTextFieldWidget(
                          hintText: "Surnames                          ",
                          width: 0.17),
                    ],
                  ),
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
                  Row(
                    children: [
                      CustomFormDropDownFieldWidget(
                        width: 0.24,
                        hintText: "Country",
                        onSaved: (value) {
                          setContext("country", value);
                          var cities = getContext("cities")[value];
                          var index = 1;
                          citylist.value = [];
                          for (var city in cities) {
                            citylist.value.add({
                              "description": city,
                              "code": "$index",
                            });
                            index++;
                          }
                        },
                        data: (() {
                          List<Map<String, dynamic>> list = [];
                          var index = 1;
                          for (var country in getContext("countries").keys) {
                            list.add({
                              "description": country,
                              "code": "$index",
                            });
                            index++;
                          }
                          return list;
                        })(),
                      ),
                      if (true)
                        Obx(() {
                          return CustomFormDropDownFieldWidget(
                            width: 0.10,
                            hintText: "City",
                            onSaved: (value) {},
                            data: citylist.value,
                          );
                        }),
                    ],
                  ),
                  const CustomFormTextFieldWidget(
                      hintText: "Address Line                        ",
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
                  CustomFormDropDownFieldWidget(
                    label: "Passengers Number",
                    onSaved: (value) {},
                    data: const [
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
