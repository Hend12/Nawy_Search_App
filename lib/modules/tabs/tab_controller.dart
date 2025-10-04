import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nawy_search_app/modules/favorite/favorite_screen.dart';
import 'package:nawy_search_app/modules/more/more_screen.dart';
import 'package:nawy_search_app/modules/tabs/home/home_screen.dart';
import 'package:nawy_search_app/modules/updates/updates_screen.dart';
enum HomeTabsEnum {
  HomeTab,
  UpdatesTab,
  FavoriteTab,
  MoreTab,
}

class TabsController extends GetxController{
  int currentIndex=0;

 @override
  void onInit() {
    // Get.put(FavoritesController()); //permanent: true
    // Get.find<HomeController>().initializeHomeData();
    currentIndex = 0;
    super.onInit();
  }
  void changeIndex(int index) {
    print("changeIndex - $index");
    currentIndex = index;

    update();
  }
  Widget getCurrentScreen() {
    return tabsScreensList[HomeTabsEnum.values[currentIndex]]!;
  }
  final Map<HomeTabsEnum, Widget> tabsScreensList = {
    HomeTabsEnum.HomeTab: HomeScreen(),
    HomeTabsEnum.UpdatesTab: UpdatesScreen(),
    HomeTabsEnum.FavoriteTab: FavoriteScreen(),
    HomeTabsEnum.MoreTab: MoreScreen()
  };

}
