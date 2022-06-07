import 'package:flutter/material.dart';
import '../../index.dart';

class LocalContext extends Context {
  LocalContext() {
    loadDummyData("countries");
  }
}



List destinationlist = [];
List<Widget> destinationDragData = <Widget>[];
bool value = true;
bool reset = false;
Map<String, dynamic> destinations = <String,dynamic>{};
Map<String, dynamic> services = <String,dynamic>{};
List experiences = [];
List experiencelist = [];
List servicelist = [];
List promotedDestinations = [];
List promotedDays = [];
List selectedDestinations = [];
Map<String, dynamic> promotedExperiences = <String,dynamic>{};
Map<String, dynamic> selectedExperiences = <String,dynamic>{};
Map<String, dynamic> suggestedExperiences = <String,dynamic>{};
Map<String, dynamic> states = {
  "services": <String,dynamic>{},
  "experiences": <String,dynamic>{},
  "destinations": <String,dynamic>{},
};
Map<String, dynamic> payload = <String,dynamic>{};
Map<String, dynamic> memory = {
  "catalogs": <String,dynamic>{},
  "tour": <String,dynamic>{},
  "logistic": <String,dynamic>{},
  "customer": <String,dynamic>{},
  "destinations": <String,dynamic>{},
  "destinationDay": [],
  "days": <String,dynamic>{},
  "experiences": <String,dynamic>{},
  "services": <String,dynamic>{},
  "promoted": <String,dynamic>{},
  "days_left": 0
};
int counter = 0;
Map<String, GlobalKey<State<StatefulWidget>>> keys = <String, GlobalKey<State<StatefulWidget>>>{};

 

Map<String, dynamic> context = ({
  "index": 0,
  "icons": <String,dynamic>{},
  "countries": <String,dynamic>{},
  "session": {"avatar": ''},
  "catalogs": <String,dynamic>{}
});

