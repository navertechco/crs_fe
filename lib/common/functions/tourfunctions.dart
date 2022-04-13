// ignore_for_file: prefer_function_declarations_over_variables
import '../index.dart';

Function sendTour = () async {
  var memory = globalctx.memory;
  await fetchhandler(kDefaultSchema, kDefaultServer, kDefaultServerPort,
      kDefaultTourEdit, 'POST', {
    "state": "www",
    "data": {
       "tour":memory["tour"],
       "customer":memory["customer"],
       "logistics":memory["logistics"],
       "destinations": memory["destinations"],
       "days": memory["days"]
    }
  });
};
