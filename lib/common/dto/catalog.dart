import 'dart:convert';

class CatalogDto {
  int? code;
  String? description;
  dynamic value;
  dynamic relation;
  // ignore: prefer_function_declarations_over_variables
  Function toJson = () {};

  CatalogDto(List? data, {this.code, this.description, this.value, this.relation}) {
    if (data != null && data.isNotEmpty) {
      code = data[0];
      description = data[1];
      value = data[2];
      relation = data[3];
    }

    toJson = () {
      return  {"code": code, "description": description, "value": value, "relation": relation};
    };
  }
}
