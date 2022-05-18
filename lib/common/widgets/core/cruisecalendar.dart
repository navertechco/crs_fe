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
        child: Obx(() {
          var t = arrivalDate.value;
          return Column(
            children: [
              CruiseKeyPadWidget(),
              CruiseFiltersWidget(ctx: ctx),
            ],
          );
        }));
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
    return Column(
      children: [
        Row(
          children: [
            CustomFormDropDownFieldWidget(
                width: 0.15,
                height: 0.05,
                validator: CustomRequiredValidator(
                    errorText: "Cruise Category is required ", ctx: ctx),
                value: "0",
                onSaved: (value) {},
                onChanged: (value) {
                  cruiseCategory.value = getCatalogDescription(
                      findMemoryCatalog("cruises", "cruise_category"), value);
                  filterCruises(context);
                },
                label: "Category             ",
                data: findMemoryCatalog("cruises", "cruise_category")),
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
                        findMemoryCatalog("cruises", "modality"), value);
                    filterCruises(context);
                  },
                  label: "Modality     ",
                  data: findMemoryCatalog("cruises", "modality")),
          ],
        ),
        if (cruiseCategory.value.isNotEmpty)
          if (cruiseModality.value.isNotEmpty)
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
                label: "Islet     ",
                data: findCatalog("galapagos")),
        if (cruiseCategory.value.isNotEmpty)
          if (cruiseModality.value.isNotEmpty)
            if (cruiseIslet.value.isNotEmpty)
              CustomFormDropDownFieldWidget(
                  width: 0.15,
                  height: 0.05,
                  validator: CustomRequiredValidator(
                      errorText: "Cruise Type is required ", ctx: ctx),
                  value: "0",
                  onSaved: (value) {},
                  onChanged: (value) {
                    cruiseType.value = getCatalogDescription(
                        findMemoryCatalog("cruises", "cruise_type"), value);
                    filterCruises(context);
                  },
                  label: "Type             ",
                  data: findMemoryCatalog("cruises", "cruise_type")),
        Row(
          children: [
            if (cruiseCategory.value.isNotEmpty)
              if (cruiseModality.value.isNotEmpty)
                if (cruiseIslet.value.isNotEmpty)
                  if (cruiseType.value.isNotEmpty)
                    CustomFormDropDownFieldWidget(
                        width: 0.15,
                        height: 0.05,
                        validator: CustomRequiredValidator(
                            errorText: "Starts is required ", ctx: ctx),
                        value: "0",
                        onSaved: (value) {
                          cruiseStarts.value = getCatalogDescription(
                              findCatalog("week_day"), value);
                          filterCruises(context);
                        },
                        onChanged: (value) {
                          cruiseStarts.value = getCatalogDescription(
                              findCatalog("week_day"), value);
                          filterCruises(context);
                        },
                        label: "Starts\t\t\t\t\t\t\t",
                        data: findCatalog("week_day")),
            if (cruiseCategory.value.isNotEmpty)
              if (cruiseModality.value.isNotEmpty)
                if (cruiseIslet.value.isNotEmpty)
                  if (cruiseType.value.isNotEmpty)
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
                                findCatalog("week_day"), value);
                            filterCruises(context);
                          },
                          label: "End",
                          data: findCatalog("week_day")),
          ],
        ),
        if (moreFilters.value)
          Row(
            children: [
              CustomFormDropDownFieldWidget(
                  width: 0.15,
                  height: 0.05,
                  validator: CustomRequiredValidator(
                      errorText: "End is required ", ctx: ctx),
                  value: "0",
                  onSaved: (value) {},
                  onChanged: (value) {
                    cruiseEnds.value =
                        getCatalogDescription(findCatalog("week_day"), value);
                    filterCruises(context);
                  },
                  label: "End",
                  data: findCatalog("week_day")),
              CustomFormDropDownFieldWidget(
                  width: 0.15,
                  height: 0.05,
                  validator: CustomRequiredValidator(
                      errorText: "End is required ", ctx: ctx),
                  value: "0",
                  onSaved: (value) {},
                  onChanged: (value) {
                    cruiseEnds.value =
                        getCatalogDescription(findCatalog("week_day"), value);
                    filterCruises(context);
                  },
                  label: "End",
                  data: findCatalog("week_day")),
            ],
          ),
        if (moreFilters.value)
          Row(
            children: [
              CustomFormDropDownFieldWidget(
                  width: 0.15,
                  height: 0.05,
                  validator: CustomRequiredValidator(
                      errorText: "End is required ", ctx: ctx),
                  value: "0",
                  onSaved: (value) {},
                  onChanged: (value) {
                    cruiseEnds.value =
                        getCatalogDescription(findCatalog("week_day"), value);
                    filterCruises(context);
                  },
                  label: "End",
                  data: findCatalog("week_day")),
              CustomFormDropDownFieldWidget(
                  width: 0.15,
                  height: 0.05,
                  validator: CustomRequiredValidator(
                      errorText: "End is required ", ctx: ctx),
                  value: "0",
                  onSaved: (value) {},
                  onChanged: (value) {
                    cruiseEnds.value =
                        getCatalogDescription(findCatalog("week_day"), value);
                    filterCruises(context);
                  },
                  label: "End",
                  data: findCatalog("week_day")),
            ],
          ),
        if (moreFilters.value)
          Row(
            children: [
              CustomFormDropDownFieldWidget(
                  width: 0.15,
                  height: 0.05,
                  validator: CustomRequiredValidator(
                      errorText: "End is required ", ctx: ctx),
                  value: "0",
                  onSaved: (value) {},
                  onChanged: (value) {
                    cruiseEnds.value =
                        getCatalogDescription(findCatalog("week_day"), value);
                    filterCruises(context);
                  },
                  label: "End",
                  data: findCatalog("week_day")),
              CustomFormDropDownFieldWidget(
                  width: 0.15,
                  height: 0.05,
                  validator: CustomRequiredValidator(
                      errorText: "End is required ", ctx: ctx),
                  value: "0",
                  onSaved: (value) {},
                  onChanged: (value) {
                    cruiseEnds.value =
                        getCatalogDescription(findCatalog("week_day"), value);
                    filterCruises(context);
                  },
                  label: "End",
                  data: findCatalog("week_day")),
            ],
          ),
      ],
    );
  }
}

class CruiseKeyPadWidget extends StatelessWidget {
  const CruiseKeyPadWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            cruiseCategory.value = "";
            cruiseModality.value = "";
            cruiseIslet.value = "";
            cruiseType.value = "";
            cruiseStarts.value = "";
            cruiseEnds.value = "";
          },
          child: Text(
            'Reset',
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return CruiseResultWidget();
                });
          },
          child: Text(
            'Process',
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () {
            moreFilters.value = !moreFilters.value;
          },
          child: Text(
            !moreFilters.value ? 'More Filters' : 'Less Filters',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
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
