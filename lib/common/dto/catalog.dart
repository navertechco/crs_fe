class CatalogDto {
  int? code;
  String? description;
  dynamic value;

  CatalogDto(List data, {this.code, this.description, this.value}) {
    code = data[0] ?? code;
    description = data[1] ?? description;
    value = data[2] ?? value;
  }
}
