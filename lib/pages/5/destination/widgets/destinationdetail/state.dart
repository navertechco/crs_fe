import 'package:get/get.dart';

import '../../../../index.dart';

class DestinationDetailState extends GetXState {
  final localDestination = Rx(getContext('destinationdata'));
  var memory = {};

  @override
  void initState() { 
    super.initState();
  }
}
