import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../index.dart';

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
    return Obx(
      () => Column(
        children: [
          Row(
            children: [
              CustomFormDropDownFieldWidget(
                  width: 0.15,
                  height: 0.05,
                  validator: CustomRequiredValidator(
                      errorText: "Cruise Islet is required ", ctx: ctx),
                  value: "0",
                  onSaved: (value) {},
                  onChanged: (value) {
                    cruiseIslet.value =
                        getCatalogDescription(findCatalog("galapagos"), value);
                    filterCruises(context);
                  },
                  hintText: "Islet     ",
                  data: findCatalog("galapagos")),
              if (cruiseIslet.value.isNotEmpty)
                CustomFormDropDownFieldWidget(
                  width: 0.15,
                  height: 0.05,
                  validator: CustomRequiredValidator(
                      errorText: "Cruise Category is required ", ctx: ctx),
                  value: "0",
                  onSaved: (value) {},
                  onChanged: (value) {
                    cruiseCategory.value = getCatalogDescription(
                        findMemoryChildCatalog("cruises", "", "cruise_category",
                            included: true,
                            filter: {
                              "key": "cruise_itinerary",
                              "value": cruiseIslet.value
                            }),
                        value);
                    filterCruises(context);
                  },
                  hintText: "roomcategory     ",
                  data: findMemoryChildCatalog("cruises", "", "cruise_category",
                      included: true,
                      filter: {
                        "key": "cruise_itinerary",
                        "value": cruiseIslet.value
                      }),
                ),
              if (cruiseCategory.value.isNotEmpty)
                CustomFormDropDownFieldWidget(
                  width: 0.11,
                  height: 0.05,
                  validator: CustomRequiredValidator(
                      errorText: "Cruise Modality is required ", ctx: ctx),
                  value: "0",
                  onSaved: (value) {},
                  onChanged: (value) {
                    cruiseModality.value = getCatalogDescription(
                        findMemoryChildCatalog("cruises", "", "modality",
                            filter: {
                              "key": "cruise_category",
                              "value": cruiseCategory.value
                            }),
                        value);
                    filterCruises(context);
                  },
                  hintText: "roomcategory     ",
                  data: findMemoryChildCatalog("cruises", "", "modality",
                      filter: {
                        "key": "cruise_category",
                        "value": cruiseCategory.value
                      }),
                ),
            ],
          ),
          Row(
            children: [
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
                          findMemoryChildCatalog("cruises", "", "cruise_type",
                              filter: {
                                "key": "modality",
                                "value": cruiseModality.value
                              },
                              included: true),
                          value);
                      filterCruises(context);
                    },
                    hintText: "Type             ",
                    data: findMemoryChildCatalog("cruises", "", "cruise_type",
                        filter: {
                          "key": "modality",
                          "value": cruiseModality.value
                        })),
              if (cruiseType.value.isNotEmpty)
                CustomFormDropDownFieldWidget(
                  width: 0.15,
                  height: 0.05,
                  validator: CustomRequiredValidator(
                      errorText: "Starts is required ", ctx: ctx),
                  value: "0",
                  onSaved: (value) {},
                  onChanged: (value) {
                    cruiseStarts.value = getCatalogDescription(
                        findMemoryChildCatalog("cruises", "", "cruise_format",
                            included: true, catalog: findCatalog("week_day"),
                            condition: (mem, item) {
                          var attr =
                              mem["cruise_format"].toString().split("/")[0];
                          return attr == item["description"];
                        }, filter: {
                          "key": "cruise_type",
                          "value": cruiseType.value
                        }),
                        value);
                    filterCruises(context);
                  },
                  hintText: "Sails at:",
                  data: findMemoryChildCatalog("cruises", "", "cruise_format",
                      included: true,
                      catalog: findCatalog("week_day"), condition: (mem, item) {
                    var attr = mem["cruise_format"].toString().split("/")[0];
                    return attr == item["description"];
                  }, filter: {"key": "cruise_type", "value": cruiseType.value}),
                ),
              if (cruiseStarts.value.isNotEmpty)
                CustomFormDropDownFieldWidget(
                  width: 0.15,
                  height: 0.05,
                  validator: CustomRequiredValidator(
                      errorText: "End is required ", ctx: ctx),
                  value: "0",
                  onSaved: (value) {},
                  onChanged: (value) {
                    cruiseEnds.value = getCatalogDescription(
                        findMemoryChildCatalog("cruises", "", "cruise_format",
                            included: true, catalog: findCatalog("week_day"),
                            condition: (mem, item) {
                          var attr =
                              mem["cruise_format"].toString().split("/")[1];
                          return attr == item["description"];
                        }, filter: {
                          "key": "cruise_type",
                          "value": cruiseType.value
                        }),
                        value);
                    filterCruises(context);
                  },
                  hintText: "Slips at:",
                  data: findMemoryChildCatalog("cruises", "", "cruise_format",
                      included: true,
                      catalog: findCatalog("week_day"), condition: (mem, item) {
                    var attr = mem["cruise_format"].toString().split("/")[1];
                    return attr == item["description"];
                  }, filter: {"key": "cruise_type", "value": cruiseType.value}),
                ),
            ],
          ),
          if (moreFilters.value)
            Row(
              children: [
                CustomFormDropDownFieldWidget(
                  width: 0.15,
                  height: 0.05,
                  validator: CustomRequiredValidator(
                      errorText: "Cabine Type is required ", ctx: ctx),
                  value: "0",
                  onSaved: (value) {},
                  onChanged: (value) {
                    cruiseEnds.value = getCatalogDescription(
                        findMemoryChildCatalog(
                            "cruises", "cabins", "cabine_type"),
                        value);
                    filterCruises(context);
                  },
                  hintText: "Cabine Type",
                  data: findMemoryChildCatalog(
                      "cruises", "cabins", "cabine_type"),
                ),
                CustomFormDropDownFieldWidget(
                  width: 0.15,
                  height: 0.05,
                  validator: CustomRequiredValidator(
                      errorText: "PAX is required ", ctx: ctx),
                  value: "0",
                  onSaved: (value) {},
                  onChanged: (value) {
                    cruiseCategory.value = getCatalogDescription(
                        findMemoryChildCatalog("cruises", "", "pax", filter: {
                          "key": "cruise_type",
                          "value": cruiseType.value
                        }),
                        value);
                    filterCruises(context);
                  },
                  hintText: "PAX     ",
                  data: findMemoryChildCatalog("cruises", "", "pax", filter: {
                    "key": "cruise_type",
                    "value": cruiseType.value
                  }),
                ),
              ],
            ),
        ],
      ),
    );
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
                  cruiseCategory.value = "";
                  cruiseModality.value = "";
                  cruiseIslet.value = "";
                  cruiseType.value = "";
                  cruiseStarts.value = "";
                  cruiseEnds.value = "";
                  moreFilters.value = false;
                },
                child: Text('Reset',
                    style: KTextSytle(
                            context: context,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)
                        .getStyle()),
              ),
              if (cruiseStarts.value.isNotEmpty)
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
              if (cruiseStarts.value.isNotEmpty)
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
