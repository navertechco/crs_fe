// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

// ignore: mixin_inherits_from_not_object
class Context with PropertyChangeNotifier<String> {
  RxBool value = true.obs;
  RxList<dynamic> destinationlist = [].obs;
  RxList<dynamic> experiencelist = [].obs;
  Rx<Map<String, dynamic>> context = Rx({
    "index": 0.obs,
    "icons": {}.obs,
    "session": {"avatar": "".obs},
    "data": {
      "client": [
        {
          "code": "customer_type",
          "description": "Customer Type",
          "value": "Legal"
        },
        {
          "code": "legal_name",
          "description": "Legal Name",
          "value": "British Bank"
        },
        {
          "code": "contact_name",
          "description": "Contact Name",
          "value": "Mr. Frank Stevens"
        },
        {
          "code": "id_number",
          "description": "Identification Number",
          "value": "15261548"
        },
        {
          "code": "brith_date",
          "description": "Birth Date",
          "value": "10/10/1950"
        },
        {
          "code": "email",
          "description": "e-Mail",
          "value": "frank.stevens@gmail.com"
        },
        {
          "code": "passengers",
          "description": "Passengers Number",
          "value": "10"
        }
      ],
      "tour": [
        {
          "code": "destination_country",
          "description": "Destination Country",
          "value": "Ecuador"
        },
        {
          "code": "purpouse",
          "description": "Trip Purpose",
          "value": "ADVENTURE"
        },
        {
          "code": "accomodation_type",
          "description": "Accomodation Type",
          "value": "5 STARS"
        },
        {
          "code": "arrival_date",
          "description": "Arrival Date",
          "value": "09/10/2022"
        },
        {
          "code": "departure_date",
          "description": "Departure Date",
          "value": "14/10/2022"
        },
        {
          "code": "contact_agent",
          "description": "Contact Agent",
          "value": "Jose Cuevas"
        },
      ],
      "arrival": {"port": "Quito", "date": "09-01-2022"},
      "departure": {"port": "Guayaquil", "date": "14-01-2022"},
      "destinations": [
        {
          "destination_name": "cuenca",
          "destination_description": "Cuenca",
          "days": [
            {
              "description": "lorem ipsum dolor sit amet, consectetur",
              "date": "10-01-2022",
              "experiences": [
                {
                  "code": "Visit to plaza",
                  "description": "this visit is the most......",
                },
                {
                  "code": "Visit to Restaruant",
                  "description": "this visit is the most......",
                },
              ]
            },
            {
              "description": "lorem ipsum dolor sit amet, consectetur",
              "date": "11-01-2022",
              "experiences": [
                {
                  "code": "Visit to Museum",
                  "description": "lorem ipsum dolor sit amet, consectetur",
                },
              ]
            },
            {
              "description": "lorem ipsum dolor sit amet, consectetur",
              "date": "12-01-2022",
              "experiences": [
                {
                  "code": "Visit to disco",
                  "description": "lorem ipsum dolor sit amet, consectetur",
                },
                {
                  "code": "Visit to Restaurant",
                  "description": "lorem ipsum dolor sit amet, consectetur",
                },
              ]
            },
            {
              "description": "lorem ipsum dolor sit amet, consectetur",
              "date": "13-01-2022",
              "experiences": [
                {
                  "code": "Ceremony",
                  "description": "lorem ipsum dolor sit amet, consectetur",
                },
              ]
            }
          ]
        },
        {
          "destination_name": "otavalo",
          "destination_description": "Otavalo",
          "days": [
            {
              "description": "lorem ipsum dolor sit amet, consectetur",
              "date": "10-01-2022",
              "experiences": [
                {
                  "code": "Visit to plaza",
                  "description": "this visit is the most......",
                },
                {
                  "code": "Visit to Restaruant",
                  "description": "this visit is the most......",
                },
              ]
            },
            {
              "description": "lorem ipsum dolor sit amet, consectetur",
              "date": "11-01-2022",
              "experiences": [
                {
                  "code": "Visit to Museum",
                  "description": "lorem ipsum dolor sit amet, consectetur",
                },
              ]
            },
            {
              "description": "lorem ipsum dolor sit amet, consectetur",
              "date": "12-01-2022",
              "experiences": [
                {
                  "code": "Visit to disco",
                  "description": "lorem ipsum dolor sit amet, consectetur",
                },
                {
                  "code": "Visit to Restaurant",
                  "description": "lorem ipsum dolor sit amet, consectetur",
                },
              ]
            },
            {
              "description": "lorem ipsum dolor sit amet, consectetur",
              "date": "13-01-2022",
              "experiences": [
                {
                  "code": "Ceremony",
                  "description": "lorem ipsum dolor sit amet, consectetur",
                },
              ]
            }
          ]
        }
      ]
    },
    "experiences": {
      "northern": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Northern Highlands",
        "assets/custom/img/1x/Recurso_309mdpi.png",
        "assets/custom/img/1x/Recurso_308mdpi.png"
      ],
      "southern": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Southern Highlands",
        "assets/custom/img/1x/Recurso_300mdpi.png",
        "assets/custom/img/1x/Recurso_225mdpi.png"
      ],
      "galapagos": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Galápagos",
        "assets/custom/img/1x/Recurso_565mdpi.png",
        "assets/custom/img/1x/Recurso_564mdpi.png"
      ],
      "volcano": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Volcano ",
        "assets/custom/img/1x/Recurso_304mdpi.png",
        "assets/custom/img/1x/Recurso_303mdpi.png"
      ],
      "amazon": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Amazon ",
        "assets/custom/img/1x/Recurso_293mdpi.png",
        "assets/custom/img/1x/Recurso_292mdpi.png"
      ],
      "quito": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Quito",
        "assets/custom/img/1x/Recurso_216mdpi.png",
        "assets/custom/img/1x/Recurso_215mdpi.png"
      ],
      "guayaquil": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Quayaquil",
        "assets/custom/img/1x/Recurso_214mdpi.png",
        "assets/custom/img/1x/Recurso_213mdpi.png"
      ],
      "cuenca": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Cuenca",
        "assets/custom/img/1x/Recurso_204mdpi.png",
        "assets/custom/img/1x/Recurso_203mdpi.png"
      ],
      "otavalo": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Otavalo",
        "assets/custom/img/1x/Recurso_202mdpi.png",
        "assets/custom/img/1x/Recurso_201mdpi.png"
      ],
      "coast": [
        "assets/custom/img/1x/Recurso_191mdpi.png",
        "Coast",
        "assets/custom/img/1x/Recurso_374mdpi.png",
        "assets/custom/img/1x/Recurso_192mdpi.png"
      ],
    },
    "destinations": {
      "northern": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Northern Highlands",
        "assets/custom/img/1x/Recurso_309mdpi.png",
        "assets/custom/img/1x/Recurso_308mdpi.png"
      ],
      "southern": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Southern Highlands",
        "assets/custom/img/1x/Recurso_300mdpi.png",
        "assets/custom/img/1x/Recurso_225mdpi.png"
      ],
      "galapagos": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Galápagos",
        "assets/custom/img/1x/Recurso_565mdpi.png",
        "assets/custom/img/1x/Recurso_564mdpi.png"
      ],
      "volcano": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Volcano ",
        "assets/custom/img/1x/Recurso_304mdpi.png",
        "assets/custom/img/1x/Recurso_303mdpi.png"
      ],
      "amazon": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Amazon ",
        "assets/custom/img/1x/Recurso_293mdpi.png",
        "assets/custom/img/1x/Recurso_292mdpi.png"
      ],
      "quito": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Quito",
        "assets/custom/img/1x/Recurso_216mdpi.png",
        "assets/custom/img/1x/Recurso_215mdpi.png"
      ],
      "guayaquil": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Quayaquil",
        "assets/custom/img/1x/Recurso_214mdpi.png",
        "assets/custom/img/1x/Recurso_213mdpi.png"
      ],
      "cuenca": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Cuenca",
        "assets/custom/img/1x/Recurso_204mdpi.png",
        "assets/custom/img/1x/Recurso_203mdpi.png"
      ],
      "otavalo": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Otavalo",
        "assets/custom/img/1x/Recurso_202mdpi.png",
        "assets/custom/img/1x/Recurso_201mdpi.png"
      ],
      "coast": [
        "assets/custom/img/1x/Recurso_318mdpi.png",
        "Coast",
        "assets/custom/img/1x/Recurso_193mdpi.png",
        "assets/custom/img/1x/Recurso_192mdpi.png"
      ],
    }
  }.obs);

  void set_context(key, value) {
    context.value[key] = value;
    notifyListeners(key);
  }

  dynamic get_context(key) {
    return context.value[key];
  }
}

Context globalctx = Context();
setContext(key, value) {
  globalctx.set_context(key, value);
}

getContext(key) {
  return globalctx.get_context(key);
}
