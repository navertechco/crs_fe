import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'customformdestination.dart';

// ignore: must_be_immutable
class Destinations extends StatelessWidget {
  const Destinations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> dests = [];
    var tour = globalctx.memory["tour"];
    var destinations = tour["destinations"];
    if (destinations.isNotEmpty) {
      var i = 0;
      for (var dest in destinations.entries) {
        // var destData = getDestinationById(dest);
        var key = GlobalKey();
        globalctx.keys["destination-$i"] = key;
        dests.add(CustomFormDestination(index: i, destination: dest));
        i++;
      }
    }
    return Column(
      children: dests,
    );
  }
}
