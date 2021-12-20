import 'package:flutter/material.dart';

import '../../../../index.dart';

class CustomLeftOptionsWidget extends StatelessWidget {
  const CustomLeftOptionsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.3,
          left: MediaQuery.of(context).size.width * 0.05),
      child: Column(
        children: [
          CustomTitleWidget(
            fontWeight: FontWeight.bold,
            label: "Day 2: Options",
          ),
          Divider(color: Color.fromARGB(255, 0, 0, 0)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomFormMultiDropDownFieldWidget(
                      // label: "Exploration Days",
                      value: const [],
                      onSaved: (value) {},
                      onChanged: (value) {},
                      hintText: "                  Services",
                      data: const [
                        {"code": "1", "description": "Translator"},
                        {"code": "2", "description": "Transport"},
                        {"code": "3", "description": "Guide"},
                        // {"code": "2", "description": "hola 2"},
                      ],
                    ),
                    CustomFormDropDownFieldWidget(
                      // label: "Exploration Days",
                      onSaved: (value) {},
                      onChanged: (value) {},
                      hintText: "Travel Options",
                      data: const [
                        {"code": "1", "description": "All included"},
                        {"code": "2", "description": "Leisure Time"},
                        {"code": "3", "description": "Foods Included"},
                        {"code": "4", "description": "Open Credit"},
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}