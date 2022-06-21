import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../index.dart';

Map<String, dynamic> states = {
  "selected": globalctx.selectedExperiences,
  "suggested": globalctx.suggestedExperiences,
  "promoted": globalctx.promotedExperiences
};
Map experienceDto = {
  "destination": '',
  "day": '',
  "title": '',
  "description": '',
  "next": '',
  "previous": '',
  "experience_id": '',
  "photo": ''
};
var experiencePromotedDragData = Rx(<Widget>[]);
List filteredExperiences = [];
var experiences = findCatalog("experiences");
List expList = findCatalog("experiences").toList();
var experienceSelectedDragData = Rx(<Widget>[]);

