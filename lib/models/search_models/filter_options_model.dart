class FilterOptionsModel {
  int? minBedrooms;
  int? maxBedrooms;
  List<dynamic>? minPriceList;
  List<dynamic>? maxPriceList;

  FilterOptionsModel({
    this.minBedrooms,
    this.maxBedrooms,
    this.minPriceList,
    this.maxPriceList,
  });

  FilterOptionsModel.fromjson(Map<String, dynamic> json) {
    minBedrooms = json['min_bedrooms'];
    maxBedrooms = json['max_bedrooms'];
    minPriceList = json['min_price_list'] as List<dynamic>?;
    maxPriceList = json['max_price_list'] as List<dynamic>?;
  }
}
