import 'package:flutter/material.dart';
import 'package:naver_crs/common/index.dart';

class CustomStarDestinationForm extends StatelessWidget {
  const CustomStarDestinationForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0,
        left: MediaQuery.of(context).size.width * 0,
      ),
      child: SizedBox(
        child: Column(children: const [
          CustomTitleWidget(
            width: 0.3,
            fontWeight: FontWeight.bold,
            label: "Destination 1",
          ),
          CustomFormDropDownFieldWidget(
            label: "Exploration Days       ",
            data: [
              {"code": "1", "description": "1"},
              {"code": "2", "description": "2"},
              {"code": "3", "description": "3"},
              {"code": "4", "description": "4"},
              {"code": "5", "description": "5"},
              // {"code": "2", "description": "hola 2"},
            ],
          ),
          CustomTitleWidget(
              width: 0.225,
              fontWeight: FontWeight.bold,
              label: "  Exploration Mode"),
          CustomFormDropDownFieldWidget(
            label: "    Purpose                    ",
            data: [
              {"code": "1", "description": "AVENTURE"},
              {"code": "2", "description": "CULLINARY"},
            ],
          ),
          CustomTitleWidget(
              width: 0.2,
              fontWeight: FontWeight.bold,
              label: "  Destination options           "),
          CustomTitleWidget(
              width: 0.2,
              fontWeight: FontWeight.bold,
              label: "  Travel Rithm           "),
          Divider(color: Color.fromARGB(255, 0, 0, 0)),
        ]),
      ),
    );
  }
}
