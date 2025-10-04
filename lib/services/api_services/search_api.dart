import 'dart:convert' as convert;

import 'package:dart_either/dart_either.dart';
import 'package:http/http.dart' as http;
import 'package:nawy_search_app/core/api_contants.dart';
import 'package:dio/dio.dart' as dio;
import 'package:nawy_search_app/models/search_models/area_model.dart';
import 'package:nawy_search_app/models/search_models/compounds_model.dart';
import 'package:nawy_search_app/models/search_models/filter_options_model.dart';
import 'package:nawy_search_app/models/search_models/search_properties.dart';

abstract class SearchApi {
  Future<Either<String, List<CompoundModel>>> getCompounds();

  Future<Either<String, List<AreaModel>>> getAreas();

  Future<Either<String, FilterOptionsModel>> getFilterOptions();

  Future<Either<String, List<SearchResultModel>>> getSearchResults();
}

class SearchApiImp implements SearchApi {
  final ApiConstants apiConstants = ApiConstants();

  @override
  Future<Either<String, List<CompoundModel>>> getCompounds() async {
    String _url = apiConstants.getCompoundsUrl;
    final response = await http.get(Uri.parse(_url));
    if (response != null && response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print("${jsonResponse}");
      // List<CompoundModel> returnCompounds = jsonResponse.map((e) => CompoundModel.fromjson(e)).toList();
      List<CompoundModel>? returnCompounds = (jsonResponse as List?)
          ?.map(
            (dynamic e) => CompoundModel.fromjson(e as Map<String, dynamic>),
          )
          .toList();

      //CompoundModel.fromjson(jsonResponse);
      return Either.right(returnCompounds ?? []);
    }
    return Either.left("error");
  }

  @override
  Future<Either<String, List<AreaModel>>> getAreas() async {
    String _url = apiConstants.getAreasUrl;
    final response = await http.get(Uri.parse(_url));
    if (response != null && response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      // List<AreaModel> returnAreas = jsonResponse.map((dynamic e) => AreaModel.fromjson(e as Map<String, dynamic>)).toList();
      List<AreaModel>? returnAreas = (jsonResponse as List?)
          ?.map((dynamic e) => AreaModel.fromjson(e as Map<String, dynamic>))
          .toList();

      return Either.right(returnAreas ?? []);
    }
    return Either.left("error");
  }

  Future<Either<String, FilterOptionsModel>> getFilterOptions() async {
    String _url = apiConstants.getFilterData;
    final response = await http.get(Uri.parse(_url));
    if (response != null && response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;

      FilterOptionsModel returnfilterOptionsModel = FilterOptionsModel.fromjson(
        jsonResponse,
      );
      return Either.right(returnfilterOptionsModel);
    }
    return Either.left("error");
  }

  @override
  Future<Either<String, List<SearchResultModel>>> getSearchResults() async {
    String _url = apiConstants.GetSearchResult;
    final response = await http.get(Uri.parse(_url));
    if (response != null && response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;

      SearchResultResponseModel returnModel =
          SearchResultResponseModel.fromJson(jsonResponse);
      return Either.right(returnModel.searchList ?? []);
    }
    return Either.left("error");
  }

  // TODO: implement getSearchResults
}
