class CatalogDto {
  int? code;
  int? order;
  String? description;
  dynamic value;
  dynamic relation;
  dynamic catalog;
  // ignore: prefer_function_declarations_over_variables
  Function toJson = () {};

  CatalogDto(List? data,
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
        "order": order,
        "description": description,
        "value": value,
        "relation": relation,
        "catalog": catalog
      };
    };
  }
} 