import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';

class CruiseCalendarWidget extends StatelessWidget {
  CruiseCalendarWidget({
    Key? key,
    this.ctx,
  }) : super(key: key);
  final ctx;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    filterCruises(context);

    return Form(
      key: formKey,
      child: CruiseFiltersWidget(ctx: ctx),
    );
  }
}

class CruiseFiltersWidget extends StatelessWidget {
  const CruiseFiltersWidget({
    Key? key,
    required this.ctx,
  }) : super(key: key);

  final ctx;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() => Column(children: [
            CustomFormLabelWidget(
                label: "Required Filters",
                fontWeight: FontWeight.bold,
                fontSize: 12),
            Row(children: [
              CustomFormDropDownFieldWidget(
                width: 0.16,
                height: 0.05,
                validator: CustomRequiredValidator(
                    errorText: "Cruise Category is required ", ctx: ctx),
                value: getFormValue(
                    globalctx.memory, "logistic", "cruise_category", "0"),
                onSaved: (value) {},
                onChanged: (value) {
                  cruiseCategory.value = getCatalogDescription(
                      getMemoryCatalogChild(
                        "cruises",
                        "value",
                        "cruise_category",
                      ),
                      value);
                  setFormValue(
                      globalctx.memory, "logistic", "cruise_category", value);
                  filterCruises(context);
                },
                hintText: "Category",
                data: getMemoryCatalogChild(
                  "cruises",
                  "value",
                  "cruise_category",
                ),
              ),
              CustomFormDropDownFieldWidget(
                width: 0.16,
                height: 0.05,
                validator: CustomRequiredValidator(
                    errorText: "Cruise Modality is required ", ctx: ctx),
                value: getFormValue(
                    globalctx.memory, "logistic", "cruise_modality", "0"),
                onSaved: (value) {},
                onChanged: (value) {
                  cruiseModality.value = getCatalogDescription(
                      getMemoryCatalogChild("cruises", "value", "modality",
                          condition: (element) {
                        var rule = true;
                        return rule;
                      }),
                      value);
                  setFormValue(
                      globalctx.memory, "logistic", "cruise_modality", value);
                  filterCruises(context);
                },
                hintText: "Modality    ",
                data: getMemoryCatalogChild("cruises", "value", "modality",
                    condition: (element) {
                  var rule = true;
                  return rule;
                }),
              ),
              CustomFormDropDownFieldWidget(
                width: 0.16,
                height: 0.05,
                validator: CustomRequiredValidator(
                    errorText: "Cruise Days is required ", ctx: ctx),
                value: getFormValue(
                    globalctx.memory, "logistic", "cruise_days", "0"),
                onSaved: (value) {},
                onChanged: (value) {
                  cruiseDay.value = getCatalogDescription(
                      getMemoryCatalogChild("cabine", "value", "days"), value);
                  setFormValue(
                      globalctx.memory, "logistic", "cruise_days", value);
                  filterCruises(context);
                },
                hintText: "Days    ",
                data: getMemoryCatalogChild("cabine", "value", "days"),
              ),
              CustomFormMultiDropDownFieldWidget(
                height: 0.05,
                // validator: CustomRequiredValidator(
                //     errorText: "Itinerary Format is required ", ctx: ctx),
                value: getFormValue(globalctx.memory, "logistic",
                    "cruise_itinerary_format", <String>[]),
                onSaved: (values) {
                  if (values == null) return;
                  saveMultiDropDown(
                      [
                        globalctx.memory,
                        "logistic",
                        "cruise_itinerary_format",
                      ],
                      getMemoryCatalogChild(
                          "itinerary", "value", "itinerary_format",
                          filter: {
                            "catalog": "cabine",
                            "key": "days",
                            "value": cruiseDay.value,
                            "relation": ["cruise_id", "days"]
                          }),
                      values,
                      10);
                  cruiseItinerary.value = getFormValue(globalctx.memory,
                      "logistic", "cruise_itinerary_format", <String>[]);
                  filterCruises(context);
                },
                onChanged: (value) {},
                hintText: "itinerary Format    ",
                data: getMemoryCatalogChild(
                    "itinerary", "value", "itinerary_format",
                    filter: {
                      "catalog": "cabine",
                      "key": "days",
                      "value": cruiseDay.value,
                      "relation": ["cruise_id", "days"]
                    }),
              ),
            ]),
            if (moreFilters.value)
              Column(
                children: [
                  CustomFormLabelWidget(
                      label: "More Filters",
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                  Row(children: [
                    CustomFormDropDownFieldWidget(
                      width: 0.16,
                      height: 0.05,
                      validator: CustomRequiredValidator(
                          errorText: "Cabine Type is required ", ctx: ctx),
                      value: getFormValue(globalctx.memory, "logistic",
                          "cruise_cabine_type", "0"),
                      onSaved: (value) {},
                      onChanged: (value) {
                        setFormValue(globalctx.memory, "logistic",
                            "cruise_cabine_type", value);
                        cruiseCabine.value = getCatalogDescription(
                            getMemoryCatalogChild(
                                "cabine", "value", "cabine_type",
                                condition: (element) {
                              var rule = true;
                              rule = rule &&
                                  cruiseResults.value.where((cruise) {
                                    return element["value"]["cruise_id"]
                                            .toString() ==
                                        cruise["value"]["cruise_id"].toString();
                                  }).isNotEmpty;

                              rule = rule &&
                                  element["value"]["days"].toString() ==
                                      cruiseDay.value.toString();
                              return rule;
                            }),
                            value);
                        filterCruises(context);
                      },
                      hintText: "Cabine Type    ",
                      data: getMemoryCatalogChild(
                          "cabine", "value", "cabine_type",
                          condition: (element) {
                        var rule = true;
                        rule = rule &&
                            cruiseResults.value.where((cruise) {
                              return element["value"]["cruise_id"].toString() ==
                                  cruise["value"]["cruise_id"].toString();
                            }).isNotEmpty;

                        rule = rule &&
                            element["value"]["days"].toString() ==
                                cruiseDay.value.toString();
                        return rule;
                      }),
                    ),
                    CustomFormDropDownFieldWidget(
                      width: 0.16,
                      height: 0.05,
                      validator: CustomRequiredValidator(
                          errorText: "Cabine Location is required ", ctx: ctx),
                      value: getFormValue(globalctx.memory, "logistic",
                          "cruise_cabine_location", "0"),
                      onSaved: (value) {},
                      onChanged: (value) {
                        cruiseCabineLocation.value = getCatalogDescription(
                            getMemoryCatalogChild(
                                "cabine", "value", "cabine_location",
                                filter: {
                                  "catalog": "itinerary",
                                  "key": "itinerary_format",
                                  "value": cruiseItinerary.value,
                                  "relation": ["cruise_id", "days"]
                                }),
                            value);
                        setFormValue(globalctx.memory, "logistic",
                            "cruise_cabine_location", value);
                        filterCruises(context);
                      },
                      hintText: "Cabine Location    ",
                      data: getMemoryCatalogChild(
                          "cabine", "value", "cabine_location",
                          condition: (element) {
                        var rule = true;
                        rule = rule &&
                            cruiseResults.value.where((cruise) {
                              return element["value"]["cruise_id"].toString() ==
                                  cruise["value"]["cruise_id"].toString();
                            }).isNotEmpty;

                        rule = rule &&
                            element["value"]["days"].toString() ==
                                cruiseDay.value.toString();
                        return rule;
                      }),
                    ),
                    CustomFormDropDownFieldWidget(
                      width: 0.16,
                      height: 0.05,
                      validator: CustomRequiredValidator(
                          errorText: "Cruise Type is required ", ctx: ctx),
                      value: getFormValue(
                          globalctx.memory, "logistic", "cruise_type", "0"),
                      onSaved: (value) {},
                      onChanged: (value) {
                        cruiseType.value = getCatalogDescription(
                            getMemoryCatalogChild(
                                "cruises", "value", "cruise_type",
                                condition: (element) {
                              var rule = true;
                              rule = rule &&
                                  cruiseResults.value.where((cruise) {
                                    return element["value"]["cruise_id"]
                                            .toString() ==
                                        cruise["value"]["cruise_id"].toString();
                                  }).isNotEmpty;

                              return rule;
                            }),
                            value);
                        setFormValue(
                            globalctx.memory, "logistic", "cruise_type", value);
                        filterCruises(context);
                      },
                      hintText: "Cruise Type    ",
                      data: getMemoryCatalogChild(
                          "cruises", "value", "cruise_type",
                          condition: (element) {
                        var rule = true;
                        // rule = rule &&
                        //     cruiseResults.value.where((cruise) {
                        //       return element["value"]["cruise_id"].toString() ==
                        //           cruise["value"]["cruise_id"].toString();
                        //     }).isNotEmpty;

                        return rule;
                      }),
                    ),
                    CustomFormDropDownFieldWidget(
                      width: 0.16,
                      height: 0.05,
                      validator: CustomRequiredValidator(
                          errorText: "Cruise Port is required ", ctx: ctx),
                      value: getFormValue(
                          globalctx.memory, "logistic", "cruise_port", "0"),
                      onSaved: (value) {},
                      onChanged: (value) {
                        cruisePort.value = getCatalogDescription(
                            getMemoryCatalogChild(
                                "cruises", "value", "cruise_port",
                                condition: (element) {
                              var rule = true;
                              rule = rule &&
                                  cruiseResults.value.where((cruise) {
                                    return element["value"]["cruise_id"]
                                            .toString() ==
                                        cruise["value"]["cruise_id"].toString();
                                  }).isNotEmpty;

                              return rule;
                            }),
                            value);
                        setFormValue(
                            globalctx.memory, "logistic", "cruise_port", value);
                        filterCruises(context);
                      },
                      hintText: "Cruise Port    ",
                      data: getMemoryCatalogChild(
                          "cruises", "value", "cruise_port",
                          condition: (element) {
                        var rule = true;
                        rule = rule &&
                            cruiseResults.value.where((cruise) {
                              return element["value"]["cruise_id"].toString() ==
                                  cruise["value"]["cruise_id"].toString();
                            }).isNotEmpty;

                        return rule;
                      }),
                    ),
                  ]),
                ],
              ),
          ])),
    );
    //
  }
}

class CruiseKeyPadWidget extends StatelessWidget {
  const CruiseKeyPadWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0,
              left: MediaQuery.of(context).size.width * 0.4),
          child: Wrap(
            children: [
              TextButton(
                onPressed: () {
                  cruiseReset();
                },
                child: Text('Reset',
                    style: KTextSytle(
                            context: context,
                            fontSize: isMobile * 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)
                        .getStyle()),
              ),
              // if (cruiseCabine.isNotEmpty)

              TextButton(
                onPressed: () {
                  showCustomDialog(context, CruiseResultWidget(), "Close",
                      backgroundColor: Colors.white);
                },
                child: Text('Show Results',
                    style: KTextSytle(
                            context: context,
                            fontSize: isMobile * 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)
                        .getStyle()),
              ),

              TextButton(
                onPressed: () {
                  moreFilters.value = !moreFilters.value;
                },
                child: Text(
                    !moreFilters.value ? 'More Filters' : 'Less Filters',
                    style: KTextSytle(
                            context: context,
                            fontSize: isMobile * 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)
                        .getStyle()),
              ),
              TextButton(
                onPressed: () {
                  Get.close(1);
                },
                child: Text('Promote',
                    style: KTextSytle(
                            context: context,
                            fontSize: isMobile * 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)
                        .getStyle()),
              ),
            ],
          ),
        ));
  }
}

class CruiseResultWidget extends StatelessWidget {
  const CruiseResultWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(children: [
        // if (cruiseCategory.isNotEmpty)
        //   if (cruiseModality.isNotEmpty)
        //     if (cruiseType.isNotEmpty)
        //       if (cruisePort.isNotEmpty)
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.03,
                left: MediaQuery.of(context).size.width * 0.0,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.03,
                decoration: BoxDecoration(color: Colors.grey),
                child: Row(
                  children: [
                    Spacer(),
                    SizedBox(
                      child: Text(
                        "Cruise Name",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: isMobile * 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                        child: Text(
                      "Actions",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: isMobile * 15, fontWeight: FontWeight.bold),
                    )),
                    Spacer(),
                  ],
                ),
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.0,
                          left: MediaQuery.of(context).size.width * 0.03,
                        ),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              if (cruiseResults.value.isNotEmpty &&
                                  searcherHeader.value.isNotEmpty)
                                cruiseTable.value
                              else
                                Text(
                                  "No Cruises Found",
                                  style: KTextSytle(
                                    context: context,
                                    fontSize: isMobile * 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 204, 164, 61),
                                  ).getStyle(),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ]),
    );
  }
}
