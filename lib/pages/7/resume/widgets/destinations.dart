import 'package:flutter/material.dart';

import '../../../index.dart';
import 'customformdestination.dart';

// ignore: must_be_immutable
class Destinations extends StatelessWidget {
  Destinations({
    Key? key,
    required this.data,
  }) : super(key: key);

  var data;

  @override
  Widget build(BuildContext context) {
    List<Widget> destinations = [];
    Map<String, dynamic> data = memory;
    if (data != null && globalctx.promotedDestinations.isNotEmpty) {
      var i = 0;
      for (var dest in globalctx.promotedDestinations) {
        // var destData = getDestinationById(dest);
        var key = GlobalKey();
        globalctx.keys["destination-$i"] = key;
        destinations.add(
            CustomFormDestination(data: data, index: i, destination: dest));
        i++;
      }
    }
    return Column(
      children: destinations,
    );
  }
}
