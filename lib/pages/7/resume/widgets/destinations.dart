import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'customformdestination.dart';

// ignore: must_be_immutable
class Destinations extends StatelessWidget {
  const Destinations({
    Key? key,
    required this.data,
  }) : super(key: key);

  final data;

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
