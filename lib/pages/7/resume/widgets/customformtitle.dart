import 'package:flutter/material.dart';

import 'custompadingtitle.dart';

class CustomFormTitleWidget extends StatelessWidget {
  const CustomFormTitleWidget({
    Key? key,
    this.label = "",
    this.level = 1,
  }) : super(key: key);
  final String label;
  final int level;

  @override
  Widget build(BuildContext context) {
    var columnlabel = (() {
      var title = "";

      var titlearray = label.split("#");
      if (titlearray.length > 1) {
        for (var i = 0; i < titlearray.length; i++) {
          title += titlearray[i] + ("\t" * 7);
        }
        return title;
      }
      title = label;
      return title;
    })();

    var identlabel = (() {
      var ident = "";
      if (level > 1) {
        for (var i = 1; i <= level; i++) {
          ident += "\t";
        }
      }
      return ident;
    })();

    var customlabel = identlabel + columnlabel;

    return Column(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: const Divider(color: Color.fromARGB(255, 0, 0, 0))),
        CustomPadingTitleWidget(
            customlabel: customlabel, fontWeight: FontWeight.bold),
        // SizedBox(
        //     width: MediaQuery.of(context).size.width * 0.7,
        //     child: const Divider(color: Color.fromARGB(255, 0, 0, 0))),
      ],
    );
  }
}
