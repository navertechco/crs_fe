import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../index.dart';
import '../../validators.dart';

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
    return Obx(() => Column(children: [
          Row(children: [
            CustomFormDropDownFieldWidget(
              width: 0.1,
              height: 0.05,
              validator: CustomRequiredValidator(
                  errorText: "Cruise Category is required ", ctx: ctx),
              value: "0",
              onSaved: (value) {},
              onChanged: (value) {
                if (value == "0") {
                  cruiseReset();
                } else {
                  cruiseCategory.value = getCatalogDescription(
                      findMemoryChildCatalog(
                          "cruises", "value", "cruise_category"),
                      value);
                  filterCruises(context);
                }
              },
              hintText: "Category    ",
              data:
                  findMemoryChildCatalog("cruises", "value", "cruise_category"),
            ),
            if (cruiseCategory.value.isNotEmpty)
              CustomFormDropDownFieldWidget(
                width: 0.15,
                height: 0.05,
                validator: CustomRequiredValidator(
                    errorText: "Cruise Modality is required ", ctx: ctx),
                value: "0",
                onSaved: (value) {},
                onChanged: (value) {
                  cruiseModality.value = getCatalogDescription(
                      findMemoryChildCatalog("cruises", "value", "modality",
                          filter: {
                            "catalog": "cruises",
                            "key": "cruise_category",
                            "value": cruiseCategory.value,
                            "relation": ["cruise_category"]
                          }),
                      value);
                  filterCruises(context);
                },
                hintText: "Modality    ",
                data: findMemoryChildCatalog("cruises", "value", "modality",
                    filter: {
                      "catalog": "cruises",
                      "key": "cruise_category",
                      "value": cruiseCategory.value,
                      "relation": ["cruise_category"]
                    }),
              ),
            if (cruiseCategory.value.isNotEmpty)
              if (cruiseModality.value.isNotEmpty)
                CustomFormDropDownFieldWidget(
                  width: 0.15,
                  height: 0.05,
                  validator: CustomRequiredValidator(
                      errorText: "Cruise Type is required ", ctx: ctx),
                  value: "0",
                  onSaved: (value) {},
                  onChanged: (value) {
                    cruiseType.value = getCatalogDescription(
                        findMemoryChildCatalog(
                            "cruises", "value", "cruise_type",
                            filter: {
                              "catalog": "cruises",
                              "key": "modality",
                              "value": cruiseModality.value,
                              "relation": ["cruise_category", "modality"]
                            }),
                        value);
                    filterCruises(context);
                  },
                  hintText: "Cruise Type    ",
                  data: findMemoryChildCatalog(
                      "cruises", "value", "cruise_type",
                      filter: {
                        "catalog": "cruises",
                        "key": "modality",
                        "value": cruiseModality.value,
                        "relation": ["cruise_category", "modality"]
                      }),
                ),
            if (cruiseCategory.value.isNotEmpty)
              if (cruiseModality.value.isNotEmpty)
                if (cruiseType.value.isNotEmpty)
                  CustomFormDropDownFieldWidget(
                    width: 0.15,
                    height: 0.05,
                    validator: CustomRequiredValidator(
                        errorText: "Cruise Port is required ", ctx: ctx),
                    value: "0",
                    onSaved: (value) {},
                    onChanged: (value) {
                      cruisePort.value = getCatalogDescription(
                          findMemoryChildCatalog(
                              "cruises", "value", "cruise_port",
                              filter: {
                                "catalog": "cruises",
                                "key": "cruise_type",
                                "value": cruiseType.value,
                                "relation": [
                                  "cruise_category",
                                  "modality",
                                  "cruise_type"
                                ]
                              }),
                          value);
                      filterCruises(context);
                    },
                    hintText: "Cruise Port    ",
                    data: findMemoryChildCatalog(
                        "cruises", "value", "cruise_port",
                        filter: {
                          "catalog": "cruises",
                          "key": "cruise_type",
                          "value": cruiseType.value,
                          "relation": [
                            "cruise_category",
                            "modality",
                            "cruise_type"
                          ]
                        }),
                  ),
          ]),
          if (cruiseCategory.value.isNotEmpty)
            if (cruiseModality.value.isNotEmpty)
              if (cruiseType.value.isNotEmpty)
                if (cruisePort.value.isNotEmpty)
                  Row(children: [
                    CustomFormDropDownFieldWidget(
                      width: 0.1,
                      height: 0.05,
                      validator: CustomRequiredValidator(
                          errorText: "Cruise Days is required ", ctx: ctx),
                      value: "0",
                      onSaved: (value) {},
                      onChanged: (value) {
                        cruiseDay.value = getCatalogDescription(
                            findMemoryChildCatalog("cabine", "value", "days",
                                filter: {
                                  "catalog": "cruises",
                                  "key": "cruise_port",
                                  "value": cruisePort.value,
                                  "relation": ["cruise_id"]
                                }),
                            value);
                        filterCruises(context);
                      },
                      hintText: "Days    ",
                      data: findMemoryChildCatalog("cabine", "value", "days",
                          filter: {
                            "catalog": "cruises",
                            "key": "cruise_port",
                            "value": cruisePort.value,
                            "relation": ["cruise_id"]
                          }),
                    ),
                    CustomFormDropDownFieldWidget(
                      width: 0.15,
                      height: 0.05,
                      validator: CustomRequiredValidator(
                          errorText: "Itinerary Format is required ", ctx: ctx),
                      value: "0",
                      onSaved: (value) {},
                      onChanged: (value) {
                        cruiseItinerary.value = getCatalogDescription(
                            findMemoryChildCatalog(
                                "itinerary", "value", "itinerary_format",
                                filter: {
                                  "catalog": "cabine",
                                  "key": "days",
                                  "value": cruiseDay.value,
                                  "relation": ["cruise_id", "days"]
                                }),
                            value);
                        filterCruises(context);
                      },
                      hintText: "itinerary Format    ",
                      data: findMemoryChildCatalog(
                          "itinerary", "value", "itinerary_format",
                          filter: {
                            "catalog": "cabine",
                            "key": "days",
                            "value": cruiseDay.value,
                            "relation": ["cruise_id", "days"]
                          }),
                    ),
                    CustomFormDropDownFieldWidget(
                      width: 0.15,
                      height: 0.05,
                      validator: CustomRequiredValidator(
                          errorText: "Cabine Type is required ", ctx: ctx),
                      value: "0",
                      onSaved: (value) {},
                      onChanged: (value) {
                        cruiseCabine.value = getCatalogDescription(
                            findMemoryChildCatalog(
                                "cabine", "value", "cabine_type",
                                filter: {
                                  "catalog": "itinerary",
                                  "key": "itinerary_format",
                                  "value": cruiseItinerary.value,
                                  "relation": ["cruise_id", "days"]
                                }),
                            value);
                        filterCruises(context);
                      },
                      hintText: "Cabine Type    ",
                      data: findMemoryChildCatalog(
                          "cabine", "value", "cabine_type",
                          filter: {
                            "catalog": "itinerary",
                            "key": "itinerary_format",
                            "value": cruiseItinerary.value,
                            "relation": ["cruise_id", "days"]
                          }),
                    ),
                    CustomFormDropDownFieldWidget(
                      width: 0.15,
                      height: 0.05,
                      validator: CustomRequiredValidator(
                          errorText: "Cruise Animals is required ", ctx: ctx),
                      value: "0",
                      onSaved: (value) {},
                      onChanged: (value) {
                        cruiseAnimal.value = getCatalogDescription(
                            findMemoryChildCatalog(
                                "animals", "description", ""),
                            value);
                        filterCruises(context);
                      },
                      hintText: "Animals    ",
                      data:
                          findMemoryChildCatalog("animals", "description", ""),
                    ),
                  ]),
        ]));
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
              left: MediaQuery.of(context).size.width * 0.5),
          child: Row(
            children: [
              TextButton(
                onPressed: () {
                  cruiseReset();
                },
                child: Text('Reset',
                    style: KTextSytle(
                            context: context,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)
                        .getStyle()),
              ),
              if (cruiseCabine.value.isNotEmpty)
                TextButton(
                  onPressed: () {
                    showCustomDialog(context, CruiseResultWidget(), "Close",
                        backgroundColor: Colors.white);
                  },
                  child: Text('Process',
                      style: KTextSytle(
                              context: context,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)
                          .getStyle()),
                ),
              if (cruiseCabine.value.isNotEmpty)
                TextButton(
                  onPressed: () {
                    moreFilters.value = !moreFilters.value;
                  },
                  child: Text(
                      !moreFilters.value ? 'More Filters' : 'Less Filters',
                      style: KTextSytle(
                              context: context,
                              fontSize: 10,
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
        if (cruiseCategory.value.isNotEmpty)
          if (cruiseModality.value.isNotEmpty)
            if (cruiseIslet.value.isNotEmpty)
              if (cruiseType.value.isNotEmpty)
                if (cruiseStarts.value.isNotEmpty)
                  if (cruiseEnds.value.isNotEmpty)
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
                                Expanded(
                                  child: Text(
                                    "Cruise Name",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Itinerary",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  "Actions",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                              ],
                            ),
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Stack(
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.0,
                                      left: MediaQuery.of(context).size.width *
                                          0.03,
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
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 204, 164, 61),
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
