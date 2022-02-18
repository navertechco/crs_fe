class CatalogDto {
  int? code;
  String? description;
  dynamic value;

  CatalogDto(List? data, {this.code, this.description, this.value}) {
    if (data != null && data.isNotEmpty) {
      code = data[0];
      description = data[1];
      value = data[2];
    }
  }
}
