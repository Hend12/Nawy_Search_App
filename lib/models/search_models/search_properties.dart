import 'package:nawy_search_app/models/search_models/area_model.dart';
import 'package:nawy_search_app/models/search_models/compounds_model.dart';

class SearchResultResponseModel {
  int? totalCompounds;
  List<SearchResultModel>? searchList;

  SearchResultResponseModel({this.totalCompounds, this.searchList});

  SearchResultResponseModel.fromJson(Map<String, dynamic> json) {
    totalCompounds = json['total_compounds'] as int?;

    searchList = (json['values'] as List?)
        ?.map(
          (dynamic e) => SearchResultModel.fromjson(e as Map<String, dynamic>),
        )
        .toList();
  }
}

class SearchResultModel {
  int? id;
  String? name;
  CompoundModel? compound;
  AreaModel? area;
  String? currency;
  String? maxInstallmentMonths;
  int? numberBathrooms;
  int? numberBedrooms;
  String? minReadyBy;
  String? imagePath;
  int? minUnitArea;
  int? maxUnitArea;
  int? minPrice;
  int? maxPrice;

  SearchResultModel({
    this.id,
    this.name,
    this.compound,
    this.area,
    this.currency,
    this.maxInstallmentMonths,
    this.numberBathrooms,
    this.numberBedrooms,
    this.minReadyBy,
    this.imagePath,
    this.minPrice,
    this.maxPrice,
    this.minUnitArea,
    this.maxUnitArea,
  });

  SearchResultModel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    compound = CompoundModel.fromjson(json['compound']);
    area = AreaModel.fromjson(json['area']);
    imagePath = json['image'];
    currency = json['currency'];
    maxInstallmentMonths = json['max_installment_years_months'];
    numberBathrooms = json['number_of_bathrooms'];
    numberBedrooms = json['number_of_bedrooms'];
    minReadyBy = json['min_ready_by'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    minUnitArea = json['min_unit_area'];
    minUnitArea = json['max_unit_area'];
  }
}
