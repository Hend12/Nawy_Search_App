import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nawy_search_app/core/color_constants.dart';
import 'package:nawy_search_app/modules/tabs/home/home_controller.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (homeController) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              appBarWidget(title: "Search"),
              searchBarWidget(
                homeController,
                //() {},
                //(val) => homeController.searchResult,
              ),
              if (homeController.showSuggestion)
                suggestionResultList(homeController),
              if (!homeController.showSuggestion)
                Column(
                  children: [
                    priceWidget(
                      onTapped: () {
                        showDialog(
                          context: Get.context!,
                          builder: (BuildContext context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 200,
                                  width: 400,
                                  child: Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Price Range",
                                            style: TextStyle(
                                              color: ColorConstants.lightColor,
                                               fontWeight: FontWeight.w600,
                                              fontFamily: "Roboto",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                          RangeSlider(
                                            values: homeController.priceRange,
                                            max: 100,
                                            min: 0,
                                            divisions: 100.toInt(),
                                            activeColor: ColorConstants.blueColor,

                                            onChanged: (RangeValues value) {
                                              homeController.priceRange = RangeValues(
                                                value.start,
                                                value.end,
                                              );

                                              homeController.update();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                // RangeSlider(
                                //   values: homeController.priceRange,
                                //   max: 100,
                                //   min: 0,
                                //   divisions: 100.toInt(),
                                //   activeColor: ColorConstants.blueColor,
                                //
                                //   onChanged: (RangeValues value) {
                                //     homeController.priceRange = RangeValues(
                                //       value.start,
                                //       value.end,
                                //     );
                                //
                                //     homeController.update();
                                //   },
                                // ),
                              ],
                            );
                          },
                        );
                      },

                      title: "Price",
                      subTitle: "Any",
                    ),
                    roomWidget(
                      onChanged: (value) => {
                        homeController.roomRange = value,
                        homeController.update(),
                      },
                      onTapped: () => {},
                      title: "Rooms",
                      roomRange:
                          "${homeController.roomRange.start.toInt()} ~ ${homeController.roomRange.end.toInt()} rooms",
                      min: homeController.minBedRoom.toDouble(),
                      max: homeController.maxBedRoom.toDouble(),

                      rangeValue: RangeValues(
                        homeController.roomRange.start.toDouble(),
                        homeController.roomRange.end.toDouble(),
                      ),
                    ),
                    showResultBtn(onTap: () => homeController.searchResult()),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  Widget showResultBtn({required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        margin: EdgeInsets.all(20),
        height: 36.h,
        width: 165.w,
        decoration: BoxDecoration(
          color: ColorConstants.blueColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "SHOW RESULT",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorConstants.white,
                fontWeight: FontWeight.w500,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 14.sp,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget suggestionResultList(HomeController Controller) {
    return Expanded(
      child: ListView.builder(
        itemCount: Controller.isCompound
            ? Controller.suggestionCompoundList.length
            : Controller.suggestionAreaList.length,
        padding: EdgeInsets.only(bottom: 20.h, top: 10.h),
        shrinkWrap: true,

        // physics: NeverScrollableScrollPhysics(),
        itemBuilder: (_, int index) {
          return ClipRRect(
            child: GestureDetector(
              onTap: () {
                if (Controller.isCompound) {
                  Controller.selectedCompound =
                      Controller.suggestionCompoundList[index];
                } else {
                  Controller.selectedArea =
                      Controller.suggestionAreaList[index];
                }
              },

              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ColorConstants.white,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Text(
                  "${Controller.isCompound ? Controller.suggestionCompoundList[index].name : Controller.suggestionAreaList[index].name}",
                  style: TextStyle(
                    color: ColorConstants.darkGrayColor,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget appBarWidget({required String title}) {
    return Container(
      margin: EdgeInsets.only(left: 20.w, top: 45.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$title",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorConstants.lightColor,
              fontWeight: FontWeight.w500,
              fontFamily: "Roboto",
              fontStyle: FontStyle.normal,
              fontSize: 20.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBarWidget(
    HomeController controller,
    // Function() onTap,
    //Function(String) onChanged,
  ) {
    //return Text("mjbdjs");
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorConstants.darkGrayColor, width: 0.3),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Area, Compound, Developer",
            hintStyle: TextStyle(
              color: ColorConstants.darkGrayColor,
              fontWeight: FontWeight.w400,
              fontFamily: "Roboto",
              fontStyle: FontStyle.normal,
              fontSize: 16.sp,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            prefixIcon: const Icon(
              Icons.search,
              color: ColorConstants.blueColor,
              size: 24,
            ),
          ),
          onSubmitted: (_) => {
            controller.showSuggestion = false,
            controller.update(),
          },
          onChanged: (text) {
            controller.onSearchTextChange(text);
          },
        ),
      ),
      // SearchBar(
      //   controller: controller,
      //   backgroundColor: WidgetStatePropertyAll<Color>(ColorConstants.white),
      //   padding: const WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.all(5)),
      //   overlayColor: WidgetStatePropertyAll(ColorConstants.lightColor),
      //   onTap: onTap,
      //   keyboardType: TextInputType.text,
      //   onChanged: (value) => onChanged(value),
      //   leading: Icon(Icons.search),
      //   hintText: "Area, Compound, Developer",
      // ),
    );
  }

  Widget priceWidget({
    required Function() onTapped,
    required String title,
    required String subTitle,
  }) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          InkWell(
            onTap: onTapped,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 7.w,
                vertical: 5.h,
              ),
              // leading: Container(
              //   padding: EdgeInsets.only(top:35 ),
              //   child: Text("hghg"),
              // ),
              horizontalTitleGap: 5.w,
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: ColorConstants.lightColor,
                size: 24.r,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: ColorConstants.lightColor,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    subTitle,
                    style: TextStyle(
                      color: ColorConstants.lightColor,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Divider(
              thickness: 1,
              height: 1,
              color: Color.fromRGBO(226, 226, 226, 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget roomWidget({
    required Function() onTapped,
    required Function(RangeValues) onChanged,
    required double min,
    required double max,
    required String title,
    required String roomRange,

    required RangeValues rangeValue,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTapped,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: ColorConstants.lightColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      roomRange,
                      style: TextStyle(
                        color: ColorConstants.lightColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                RangeSlider(
                  values: rangeValue,
                  max: max,
                  min: min,
                  divisions: max.toInt(),
                  activeColor: ColorConstants.blueColor,

                  onChanged: (RangeValues value) {
                    onChanged(value);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
