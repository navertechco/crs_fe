class ServiceDto {
  int? code;
  int? order;
  String? description;
  dynamic value;
  dynamic relation;
  dynamic catalog;
  // ignore: prefer_function_declarations_over_variables
  Function toJson = () {};

  ServiceDto(List? data,
      {this.code,
      this.order,
      this.description,
      this.value,
      this.relation,
      this.catalog}) {
    if (data != null && data.isNotEmpty) {
      catalog = data[0];
      code = data[1];
      description = data[2];
      order = data[3];
      value = data[4];
      relation = data[5];
    }

    toJson = () {
      return {
        "code": code,
        "description": description,
        "value": value,
        "relation": relation,
        "catalog": catalog
      };
    };
  }
}

class CatalogDto {
  int? code;
  String? description;
  dynamic value;
  dynamic relation;
  // ignore: prefer_function_declarations_over_variables
  Function toJson = () {};

  CatalogDto(List? data,
      {this.code, this.description, this.value, this.relation}) {
    if (data != null && data.isNotEmpty) {
      code = data[0];
      description = data[1];
      value = data[2];
      relation = data[3];
    }

    toJson = () {
      return {
        "code": code,
        "description": description,
        "value": value,
        "relation": relation
      };
    };
  }
}
