import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nawy_search_app/models/search_models/area_model.dart';
import 'package:nawy_search_app/models/search_models/compounds_model.dart';
import 'package:nawy_search_app/models/search_models/filter_options_model.dart';
import 'package:nawy_search_app/router/routes_constants.dart';
import 'package:nawy_search_app/services/api_services/search_api.dart';

class HomeController extends GetxController {
  TextEditingController searchController = TextEditingController();
  final searchService = Get.put<SearchApi>(SearchApiImp());
  List<CompoundModel> compoundList = <CompoundModel>[];
  List<CompoundModel> suggestionCompoundList = <CompoundModel>[];
  CompoundModel? selectedCompound;
  AreaModel? selectedArea;
  bool isCompound = true;
  bool showSuggestion = false;
  List<dynamic> minPrice = [], maxPrice = [];
  int minBedRoom = 0, maxBedRoom = 1;

  List<AreaModel> AreaList = <AreaModel>[];
  List<AreaModel> suggestionAreaList = <AreaModel>[];
  RangeValues roomRange = RangeValues(0, 0);
  RangeValues priceRange = RangeValues(0, 0);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDate();
      update();
    });
  }

  getDate() async {
    getFilterProperties();
    getCompounds();
    getAreas();
  }

  Future<void> getCompounds() async {
    final result = await searchService.getCompounds();
    result.fold(
      ifLeft: (String value) {},
      ifRight: (List<CompoundModel> value) {
        compoundList = value;
      },
    );
    update();
  }

  Future<void> getAreas() async {
    final result = await searchService.getAreas();
    result.fold(
      ifLeft: (String value) {},
      ifRight: (List<AreaModel> value) {
        AreaList = value;
      },
    );
    update();
  }

  Future<void> getFilterProperties() async {
    final result = await searchService.getFilterOptions();
    result.fold(
      ifLeft: (String value) {},
      ifRight: (FilterOptionsModel value) {
        minBedRoom = value.minBedrooms ?? 0;
        maxBedRoom = value.maxBedrooms ?? 0;
        roomRange = RangeValues(minBedRoom.toDouble(), maxBedRoom.toDouble());
        minPrice = value.minPriceList ?? [];
        maxPrice = value.maxPriceList ?? [];
        print("${minBedRoom}");
      },
    );
    update();
  }

  void searchResult() {
    Get.toNamed(
      RoutesConstants.searchResultScreen,
      arguments: {
        "selectedCompound": selectedCompound,
        "selectedArea": selectedArea,
        "rangeRooms": roomRange,
      },
    );
  }

  onSearchTextChange(String value) {
    print("update");
    if (value.isNotEmpty) {
      showSuggestion = true;
      suggestionCompoundList = compoundList
          .where((e) => e.name!.contains(value))
          .toList();
      suggestionAreaList = AreaList.where(
        (e) => e.name!.contains(value),
      ).toList();
      print("${suggestionCompoundList.length}");
      update();
    } else {
      showSuggestion = false;
      selectedCompound = null;
      selectedArea = null;
      update();
    }
  }
}
