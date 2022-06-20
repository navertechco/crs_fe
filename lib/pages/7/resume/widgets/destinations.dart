import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'customformdestination.dart';

// ignore: must_be_immutable
class Destinations extends StatelessWidget {
  const Destinations({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> destinations = [];
    if (globalctx.promotedDestinations.isNotEmpty) {
      for (var i = 0; i < globalctx.promotedDestinations.length; i++) {
        var dest = globalctx.promotedDestinations[i];
        var key = GlobalKey();
        globalctx.keys["destination-$i"] = key;
        destinations.add(CustomFormDestination(index: i, destination: dest));
      }
    }
    return Column(
      children: destinations,
    );
  }
}
