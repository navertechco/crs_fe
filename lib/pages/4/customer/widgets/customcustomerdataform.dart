import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../index.dart';

class CustomCustomerDataForm extends StatelessWidget {
  const CustomCustomerDataForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rx<List<Map<String, dynamic>>> citylist = Rx([]);
    RxString customerType = "".obs;
    RxString country = "".obs;
    RxString city = "".obs;
    List<Map<String, dynamic>> countrylist = [];
    // ignore: prefer_function_declarations_over_variables
    Function cityData = (cities) {
      var index = 0;
      citylist.value = [];

      for (var city in cities) {
        citylist.value.add({
          "code": "$index",
          "description": city,
        });
        index++;
      }
    };
    var countries = getContext("countries");
    Rx<List<Map<String, dynamic>>> countrydata = Rx((() {
      // print("Countries: $countries\n\n");
      countrylist = [];
      var index = 0;
      if (countries != null) {
        for (var country in countries.keys) {
          countrylist.add({
            "code": "$index",
            "description": country,
          });
          index++;
        }
      }

      // print("CountryList: $countrylist");
      return countrylist;
    })());

    var customerTypeCatalog = processCatalog("legal_client_type");

    return SingleChildScrollView(
      child: Expanded(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.45,
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
                              // print(value);
                            },
                            onSaved: (value) {
                              customerType.value = value!;
                              // print(value);
                            },
                            data: customerTypeCatalog,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Obx(() {
                            if (customerType.value == "1") {
                              return   CustomFormTextFieldWidget(
                                  keyboardType: TextInputType.number,
                                  hintText:
                                      "Tax Id                            ",
                                  width: 0.1);
                            } else {
                              return Text("");
                            }
                          }),
                          Obx(() {
                            if (customerType.value == "1") {
                              return   CustomFormTextFieldWidget(
                                  keyboardType: TextInputType.name,
                                  hintText: "Legal Contact  Name  ",
                                  width: 0.24);
                            } else {
                              return Text("");
                            }
                          }),
                          Obx(() {
                            if (customerType.value != "1") {
                              return   CustomFormTextFieldWidget(
                                  keyboardType: TextInputType.number,
                                  label: "DNI/PASSPORT         ",
                                  width: 0.24);
                            } else {
                              return Text("");
                            }
                          }),
                        ],
                      ),
                      Row(
                        children:   [
                          CustomFormTextFieldWidget(
                              keyboardType: TextInputType.name,
                              hintText: "Names                          ",
                              width: 0.17),
                          CustomFormTextFieldWidget(
                              keyboardType: TextInputType.name,
                              hintText: "Surnames                          ",
                              width: 0.17),
                        ],
                      ),

                      Row(
                        children: const [
                          CustomFormDateFieldWidget(
                              width: 0.35,
                              hintText: "Birth Day               "),
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
                          width: 0.225,
                          fontWeight: FontWeight.bold,
                          label: "  "),
                      Row(
                        children: [
                          Obx(() {
                            return CustomFormDropDownFieldWidget(
                              width: country.value == "" ? 0.2 : 0.1,
                              label: "Country          ",
                              onChanged: (value) {
                                country.value = value!;
                                cityData(countries[countrylist[int.parse(value)]
                                    ["description"]]);
                                // print("CHANGED: $value");
                              },
                              onSaved: (value) {
                                country.value = value!;
                                cityData(countries[countrylist[int.parse(value)]
                                    ["description"]]);
                                // print("SAVED: $value");
                              },
                              data: countrydata.value,
                            );
                          }),
                          Obx(() {
                            if (country.value != "") {
                              return CustomFormDropDownFieldWidget(
                                width: 0.1,
                                hintText: "City          ",
                                onChanged: (value) {
                                  city.value = value!;
                                  // print(value);
                                },
                                onSaved: (value) {
                                  city.value = value!;
                                  // print(value);
                                },
                                data: citylist.value,
                              );
                            } else {
                              return Text("");
                            }
                          }),
                        ],
                      ),
                        CustomFormTextFieldWidget(
                          keyboardType: TextInputType.streetAddress,
                          hintText: "Address Line                        ",
                          width: 0.36),
                        CustomFormTextFieldWidget(
                          keyboardType: TextInputType.emailAddress,
                          hintText: "e-Mail                          ",
                          width: 0.36),
                      Row(
                        children:   [
                          CustomFormTextFieldWidget(
                              keyboardType: TextInputType.name,
                              hintText: "Lead Passenger                  ",
                              width: 0.2),
                          CustomFormTextFieldWidget(
                              keyboardType: TextInputType.number,
                              hintText: "Travel Code                ",
                              width: 0.15),
                        ],
                      ),
                    ]),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.7),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed("/Destination");
                },
                child: const CustomTitleWidget(
                    width: 0.1,
                    fontWeight: FontWeight.normal,
                    label:
                        " \n                                                 Next >"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
