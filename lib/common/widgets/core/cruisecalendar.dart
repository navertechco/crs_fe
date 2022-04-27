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
          return Column(
            children: [
              Row(
                children: [
                  CustomFormDropDownFieldWidget(
                      width: 0.15,
                      height: 0.05,
                      validator: CustomRequiredValidator(
                          errorText: "Cruise Type is required ", ctx: ctx),
                      value: "0",
                      onSaved: (value) {},
                      onChanged: (value) {
                        cruiseType.value = setMemoryDescription(
                            findMemoryCatalog("cruises", "cruise_type"), value);
                        filterCruises(context);
                      },
                      label: "Type             ",
                      data: findMemoryCatalog("cruises", "cruise_type")),
                  CustomFormDropDownFieldWidget(
                      width: 0.15,
                      height: 0.05,
                      validator: CustomRequiredValidator(
                          errorText: "Cruise Category is required ", ctx: ctx),
                      value: "0",
                      onSaved: (value) {},
                      onChanged: (value) {
                        cruiseCategory.value = setMemoryDescription(
                            findMemoryCatalog("cruises", "cruise_category"),
                            value);
                        filterCruises(context);
                      },
                      label: "Category             ",
                      data: findMemoryCatalog("cruises", "cruise_category")),
                ],
              ),
              Row(
                children: [
                  CustomFormDropDownFieldWidget(
                      width: 0.15,
                      height: 0.05,
                      validator: CustomRequiredValidator(
                          errorText: "Cruise Modality is required ", ctx: ctx),
                      value: "0",
                      onSaved: (value) {},
                      onChanged: (value) {
                        cruiseModality.value = setMemoryDescription(
                            findMemoryCatalog("cruises", "modality"), value);
                        filterCruises(context);
                      },
                      label: "Modality     ",
                      data: findMemoryCatalog("cruises", "modality")),
                ],
              ),
              Row(
                children: [
                  CustomFormDropDownFieldWidget(
                      width: 0.15,
                      height: 0.05,
                      validator: CustomRequiredValidator(
                          errorText: "Arrival is required ", ctx: ctx),
                      value: "0",
                      onSaved: (value) {
                        cruiseArrival.value = setMemoryDescription(
                            findCatalog("week_day"), value);
                        filterCruises(context);
                      },
                      onChanged: (value) {
                        cruiseArrival.value = setMemoryDescription(
                            findCatalog("week_day"), value);
                        filterCruises(context);
                      },
                      label: "Arrival\t\t\t\t\t\t\t",
                      data: findCatalog("week_day")),
                  CustomFormDropDownFieldWidget(
                      width: 0.15,
                      height: 0.05,
                      validator: CustomRequiredValidator(
                          errorText: "Departure is required ", ctx: ctx),
                      value: "0",
                      onSaved: (value) {},
                      onChanged: (value) {
                        cruiseDeparture.value = setMemoryDescription(
                            findCatalog("week_day"), value);
                        filterCruises(context);
                      },
                      label: "Departure",
                      data: findCatalog("week_day")),
                ],
              ),
              // CustomFormDropDownFieldWidget(
              //     width: 0.3,
              //     height: 0.05,
              //     validator: CustomRequiredValidator(
              //         errorText: "Cruise Format is required ", ctx: ctx),
              //     value: "0",
              //     onSaved: (value) {},
              //     onChanged: (value) {
              //       cruiseFormat.value = setMemoryDescription(
              //           findMemoryCatalog("cruises", "cruise_format"), value);
              //       filterCruises(context);
              //     },
              //     label: "Format        ",
              //     data: findMemoryCatalog("cruises", "cruise_format")),
              Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          if (cruiseResults.value.isNotEmpty)
                            cruiseTable.value
                          else
                            Text("No Cruises Found"),
                        ],
                      )))
            ],
          );
        }));
  }
}
