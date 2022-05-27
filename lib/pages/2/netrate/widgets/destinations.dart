import 'package:flutter/material.dart';

import '../../../index.dart';
import 'customformdestination.dart';

// ignore: must_be_immutable
class Destinations extends StatelessWidget {
  const Destinations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> destinations = [];
    Map<String, dynamic> data = memory;
    if (data != null && promotedDestinations.isNotEmpty) {
      var i = 0;
      for (var dest in promotedDestinations) {
        // var destData = getDestinationById(dest);
        var key = GlobalKey();
        globalctx.keys["destination-$i"] = key;
        destinations.add(CustomFormDestination(index: i, destination: dest[0]));
        i++;
      }
    }
    return Column(
      children: destinations,
    );
  }
}
