import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nawy_search_app/core/color_constants.dart';
import 'package:get/get.dart';
import 'package:nawy_search_app/modules/tabs/tab_controller.dart';

class TabScreen extends StatelessWidget {
  final _tabsController = Get.find<TabsController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TabsController>(
      builder: (tabsController) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          key: Key("tabs"),
          body: WillPopScope(
            onWillPop: () {
              if (_tabsController.currentIndex != 0) {
                _tabsController.changeIndex(0);
                _tabsController.update();
                return Future.value(false);
              } else
                return Future.value(true);
            },
            child: tabsController.getCurrentScreen(),
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedLabelStyle: TextStyle(
              fontFamily: "Roboto",
              color: ColorConstants.orangeColor,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: 12,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: "Roboto",
              color: ColorConstants.lightColor.withAlpha(60),
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: 12,
            ),

            selectedItemColor: ColorConstants.orangeColor,
            unselectedItemColor: ColorConstants.lightColor,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Opacity(
                  opacity: 0.6,
                  child: Icon(Icons.search, color: ColorConstants.lightColor),
                ),
                activeIcon: Icon(
                  Icons.search,
                  color: ColorConstants.orangeColor,
                ),
                label: "Expolar",
              ),
              BottomNavigationBarItem(
                icon: Opacity(
                  opacity: 0.6,
                  child: Icon(
                    Icons.dashboard,
                    color: ColorConstants.lightColor,
                  ),
                ),
                activeIcon: Icon(
                  Icons.dashboard,
                  color: ColorConstants.orangeColor,
                ),
                label: "Updates",
              ),

              BottomNavigationBarItem(
                icon: Opacity(
                  opacity: 0.6,
                  child: Icon(
                    Icons.favorite_border,
                    color: ColorConstants.lightColor,
                  ),
                ),
                activeIcon: Icon(
                  Icons.favorite_border,
                  color: ColorConstants.orangeColor,
                ),
                label: "Favorite",
              ),
              BottomNavigationBarItem(
                icon: Opacity(
                  opacity: 0.6,
                  child: Icon(
                    Icons.more_vert,
                    color: ColorConstants.lightColor,
                  ),
                ),
                activeIcon: Icon(
                  Icons.more_vert,
                  color: ColorConstants.orangeColor,
                ),
                label: "More",
              ),
            ],
            currentIndex: tabsController.currentIndex,
            onTap: tabsController.changeIndex,
          ),
        );
      },
    );
  }
}
