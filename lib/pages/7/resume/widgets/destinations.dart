import 'package:flutter/material.dart';

import '../../../index.dart';
import 'customformdestination.dart';

class Destinations extends StatelessWidget {
  const Destinations({
    Key? key,
    required this.data,
  }) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    List<Widget> destinations = [];
    var memory = globalctx.memory.value;
    var detsdata = getValue(memory, "destinations", def: []);
    if (data != null) {
      for (var i = 0; i < detsdata.length; i++) {
        var key = GlobalKey();
        globalctx.keys["destination-$i"] = key;
        destinations.add(CustomFormDestination(data: data, index: i));
      }
    }
    return Column(
      children: destinations,
    );
  }
}
