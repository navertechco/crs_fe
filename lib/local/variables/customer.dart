
import 'package:get/get.dart';

import '../../index.dart';

Rx<DateTime> birthDate =
    Rx(DateTime.parse(globalctx.memory["customer"]["birth_date"]));
var customerTypeCatalog = findCatalog("legal_client_type");
var client = globalctx.memory["customer"];
var translator = false.obs;
