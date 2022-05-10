class CatalogDto {
  dynamic code;
  dynamic order;
  dynamic description;
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
      order = data[1];
      description = data[2];
      code = data[3];
      value = data[4];
      relation = data[5];
    }

    toJson = () {
      return {
        "catalog": catalog,
        "order": order,
        "description": description,
        "code": code,
        "value": value,
        "relation": relation,
      };
    };
  }
}
