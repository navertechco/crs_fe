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

    if (data != null) {
      var i = 0;
      for (var destination in promotedDestinations) {
        var key = GlobalKey();
        globalctx.keys["destination-$i"] = key;
        destinations.add(CustomFormDestination(
            data: data, index: i, destination: destination));
        i++;
      }
    }
    return Column(
      children: destinations,
    );
  }
}