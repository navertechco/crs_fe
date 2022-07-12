import 'package:flutter/material.dart';

import '../../../../../index.dart';

class HotelWidget extends StatelessWidget {
  const HotelWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomTitleWidget(
            width: 0.225,
            fontWeight: FontWeight.bold,
            label: "  Hotel Information  "),
        FormField(validator: (value) {
          CustomRequiredValidator(
              errorText: "Cruise Days is required ",
              ctx: context)(value.toString());
        }, builder: (context) {
          return RoundedFormButton(
            color: Colors.grey,
            label: getFormValue(globalctx.memory["destinations"],
                globalDestinationIndex, "hotelName", 'Select'),
            height: 0.05,
            fontSize: 8,
            fontWeight: FontWeight.bold,
            textColor: Colors.black,
            onPressed: () async {
              showHotelResultDialog(context, id: 0, index: index);
            },
          );
        })
      ],
    );
  }
}
