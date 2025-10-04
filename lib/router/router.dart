
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:nawy_search_app/modules/Search/search_result_screen.dart';
import 'package:nawy_search_app/modules/more/more_screen.dart';
import 'package:nawy_search_app/modules/tabs/home/home_screen.dart';
import 'package:nawy_search_app/modules/tabs/tab_screen.dart';
import 'package:nawy_search_app/modules/updates/updates_screen.dart';
import 'package:nawy_search_app/router/bindings.dart';
import 'package:nawy_search_app/router/routes_constants.dart';

import '../modules/favorite/favorite_screen.dart';

class AppRouter {
static final routes=[
  GetPage(
  name: RoutesConstants.searchResultScreen,
  page: () => SearchResultScreen(),
  binding: SearchResultBinding(),
  transition: Transition.fade,
),
  GetPage(
    name: RoutesConstants.homeScreen,
    page: () => HomeScreen(),
    binding: HomeBinding(),
    transition: Transition.fade,
  ),
  GetPage(
    name: RoutesConstants.tabsScreen,
    page: () => TabScreen(),
    binding: TabsBinding(),
    transition: Transition.fade,
  ),
  GetPage(
    name: RoutesConstants.updatesScreen,
    page: () => UpdatesScreen(),
    binding: UpdatesBinding(),
    transition: Transition.fade,
  ),
  GetPage(
    name: RoutesConstants.favoriteScreen,
    page: () => FavoriteScreen(),
    binding: FavoriteBinding(),
    transition: Transition.fade,
  ),
  GetPage(
    name: RoutesConstants.moreScreen,
    page: () => MoreScreen(),
    binding: MoreBinding(),
    transition: Transition.fade,
  )

];}
