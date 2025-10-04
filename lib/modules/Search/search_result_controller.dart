import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:nawy_search_app/models/search_models/area_model.dart';
import 'package:nawy_search_app/models/search_models/compounds_model.dart';
import 'package:nawy_search_app/services/api_services/search_api.dart';

import '../../models/search_models/search_properties.dart';

class SearchResultController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final searchService = Get.put<SearchApi>(SearchApiImp());
  List<SearchResultModel> searchResultList = <SearchResultModel>[];
  List<SearchResultModel> searchResultFilteredList = <SearchResultModel>[];

  List<String> list = <String>[];
  CompoundModel? selectedCompound;
  AreaModel? selectedArea;
  RangeValues roomRange = RangeValues(0, 0);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
     list = ["City, Governorate", "Compound name", "Apartment"];
    if (Get.arguments != null) {
      selectedCompound = Get.arguments['selectedCompound'];
      selectedArea = Get.arguments["selectedArea"];
      roomRange = Get.arguments["rangeRooms"];
      //if (selectedCompound != null) list.add(selectedCompound!.name ?? "");
      //if (selectedArea != null) list.add(selectedArea!.name ?? "");
      //if(list.length==0)
  //list = ["City, Governorate", "Compound name", "Apartment"];

    }

    getSearchResult();
  }

  void updateTabBarIndex({required int index}) {
    tabController.index = index;
    update();
  }

  saveFavoriteSearchToCache(SearchResultModel model) async {
    //  SharedPreferences sharedPref = await SharedPreferences.getInstance();
    //  //check if favorite already exit
    //
    //  String resultList = jsonEncode(SearchResultModel.fromjson(model as Map<String,dynamic>));
    //   sharedPref.setString('resultList', resultList);//storing
  }

  Future<void> getSearchResult() async {
    final result = await searchService.getSearchResults();
    result.fold(
      ifLeft: (String value) {},
      ifRight: (List<SearchResultModel> value) {
        searchResultList = value;
        searchResultFilteredList = searchResultList
            .where(
              (e) =>
                  e.compound!.id == selectedCompound?.id ||
                  e.area?.id == selectedArea?.id ||
                  (e.numberBedrooms! >= roomRange.start &&
                      e.numberBedrooms! <= roomRange.end),
            )
            .toList();
        if (searchResultFilteredList.length == 0)
          searchResultFilteredList = searchResultList;
        print("${searchResultFilteredList.length}");
      },
    );
    update();
  }
}
