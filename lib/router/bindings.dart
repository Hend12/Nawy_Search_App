import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:nawy_search_app/modules/Search/search_result_controller.dart';
import 'package:nawy_search_app/modules/tabs/home/home_controller.dart';
import 'package:nawy_search_app/modules/tabs/tab_controller.dart';

class SearchResultBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchResultController());
  }
}
class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
class TabsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TabsController());
  }
}
class MoreBinding implements Bindings {
  @override
  void dependencies() {
  }
}
class FavoriteBinding implements Bindings {
  @override
  void dependencies() {
  }
}
class UpdatesBinding implements Bindings {
  @override
  void dependencies() {
  }
}


