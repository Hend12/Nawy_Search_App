import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nawy_search_app/core/color_constants.dart';
import 'package:get/get.dart';
import 'package:nawy_search_app/modules/Search/search_result_controller.dart';

import '../../models/search_models/search_properties.dart';

class SearchResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GetBuilder<SearchResultController>(
        init: SearchResultController(),
        builder: (searchResultController) {
          return Scaffold(
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.only(top: 45.h),
                  decoration: BoxDecoration(color: ColorConstants.white),

                  child: Column(
                    children: [
                      appBarWidget(title: "Results"),
                      SizedBox(
                        height: 25.h,
                        child: ListView.builder(
                          itemCount: searchResultController.list.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (c, i) {
                            return defaultBtnWidget(
                              onTap: () {},
                              btnText: searchResultController.list[i],
                            );
                          },
                        ),
                      ),
                      tabBarRowWidget(
                        tab1title: "PROPERTIES",
                        tab2title: "COMPOUNDS",
                        onTap: (index) => searchResultController
                            .updateTabBarIndex(index: index),
                        controller: searchResultController.tabController,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.veryLightGrayColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //no of result
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                            left: 15,
                            right: 10,
                            bottom: 0,
                          ),
                          child: Text(
                            "${searchResultController.searchResultFilteredList.length} results",
                            style: TextStyle(
                              color: ColorConstants.lightColor,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        resultList(searchResultController),
                      ],
                    ),
                  ),
                ),
                //resultList(searchResultController),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget appBarWidget({required String title}) {
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 19.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => {Get.back()},
                child: Container(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: ColorConstants.lightColor,
                    size: 12,
                  ),
                ),
              ),

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => {},
                child: Opacity(
                  opacity: .6,
                  child: Icon(
                    Icons.filter_alt,
                    color: ColorConstants.lightColor,
                    size: 16,
                  ),
                ),
              ),
              SizedBox(width: 20),
              InkWell(
                onTap: () => {},
                child: Container(
                  child: Opacity(
                    opacity: .6,
                    child: Icon(
                      Icons.sort,
                      color: ColorConstants.lightColor,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget tabBarRowWidget({
    required String tab1title,
    required String tab2title,
    required TabController controller,
    required Function(int)? onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      child: TabBar(
        controller: controller,
        onTap: onTap,
        indicatorColor: ColorConstants.blueColor,
        indicatorPadding: EdgeInsets.only(top: 20),
        dividerColor: Colors.white,
        labelColor: Colors.white,
        // labelPadding:EdgeInsets.zero ,
        padding: EdgeInsets.zero,
        tabs: [
          Text(
            "$tab1title",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: controller.index == 0
                  ? ColorConstants.blueColor
                  : ColorConstants.lightColor,
              fontStyle: FontStyle.normal,
              fontFamily: "Roboto",
            ),
          ),
          Text(
            "$tab2title",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: controller!.index == 1
                  ? ColorConstants.blueColor
                  : ColorConstants.lightColor,
              fontStyle: FontStyle.normal,
              fontFamily: "Roboto",
            ),
          ),
        ],
      ),
    );
  }

  Widget resultList(SearchResultController searchController) {
    return Expanded(
      child: ListView.builder(
        itemCount: searchController.searchResultFilteredList.length,
        padding: EdgeInsets.only(bottom: 20.h, top: 10.h),
        shrinkWrap: true,
        itemBuilder: (_, int index) {
          return buildCardResultItem(
            searchController.searchResultFilteredList[index]//,
           // searchController.saveFavoriteSearchToCache(
             // searchController.searchResultList[index],
            //),
          );
        },
      ),
    );
  }

  Widget buildCardResultItem(
    SearchResultModel model,
   // Function(SearchResultModel) onTapFavorite,
  ) {
    return SizedBox(
      width: 300,
      //height: 400,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.r),
        child: Card(
          color: Colors.white,
          elevation: 0,
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            children: [
              Image.network(
                "${model.imagePath}",
                fit: BoxFit.fill,
                width: double.infinity,
                loadingBuilder:
                    (
                      BuildContext context,
                      Widget child,
                      ImageChunkEvent? loadingProgress,
                    ) {
                      if (loadingProgress == null) return child;
                      return Center(child: CircularProgressIndicator());
                    },
              ),
              Padding(
                padding: EdgeInsets.all(8.r),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            "${model.name}",
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: TextStyle(
                              color: ColorConstants.navyColor,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        Text(
                          "Delivery ${model.minReadyBy}",
                          style: TextStyle(
                            color: ColorConstants.GrayColor,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    //price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${model.currency}",
                              style: TextStyle(
                                color: ColorConstants.orangeColor,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                fontSize: 20.sp,
                              ),
                            ),
                            Text(
                              "${model.maxPrice}",
                              style: TextStyle(
                                color: ColorConstants.orangeColor,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                fontSize: 20.sp,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => {},
                          child: Icon(
                            Icons.favorite_border,
                            color: ColorConstants.blueGrayColor,
                            size: 24.r,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),

                    //price per month
                    Row(
                      children: [
                        Text(
                          "${model.minPrice}" + " EGP/month",
                          style: TextStyle(
                            color: ColorConstants.GrayColor,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          " over ${model.maxInstallmentMonths} years",
                          style: TextStyle(
                            color: ColorConstants.GrayColor,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    //Compound
                    Row(
                      children: [
                        Text(
                          "${model.compound!.name}",
                          style: TextStyle(
                            color: ColorConstants.darkGrayColor,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            fontSize: 16.sp,
                          ),
                        ),
                        Text(
                          "",
                          style: TextStyle(
                            color: ColorConstants.darkGrayColor,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    //Area location
                    Text(
                      "${model.area!.name}",
                      style: TextStyle(
                        color: ColorConstants.darkGrayColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    //properties
                    Row(
                      children: [
                        //rooms
                        Row(
                          children: [
                            Icon(
                              Icons.bed_rounded,
                              color: ColorConstants.navyColor,
                              size: 24,
                            ),
                            Text(
                              " ${model.numberBedrooms}",
                              style: TextStyle(
                                color: ColorConstants.navyColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10.w),

                        //bath
                        Row(
                          children: [
                            Icon(
                              Icons.bathtub_outlined,
                              color: ColorConstants.navyColor,
                              size: 24,
                            ),
                            Text(
                              " ${model.numberBathrooms}",
                              style: TextStyle(
                                color: ColorConstants.navyColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10.w),
                        //area
                        Row(
                          children: [
                            Icon(
                              Icons.area_chart,
                              color: ColorConstants.navyColor,
                              size: 14,
                            ),
                            Text(
                              "${model.minUnitArea}-${model.maxUnitArea ?? '0'} m^2",
                              style: TextStyle(
                                color: ColorConstants.navyColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Btns
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        btnWidget(
                          onTap: () {},
                          icon: FontAwesomeIcons.video,
                          btnText: "Zoom",
                        ),
                        SizedBox(width: 8.w),

                        btnWidget(
                          onTap: () {},
                          icon: FontAwesomeIcons.phone,
                          btnText: "Call",
                        ),
                        SizedBox(width: 8.w),
                        btnWidget(
                          onTap: () {},
                          icon: FontAwesomeIcons.whatsapp,
                          btnText: "Whatsapp",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget defaultBtnWidget({
    required Function() onTap,
    required String btnText,
  }) {
    return GestureDetector(
      onTap: () => onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        margin: EdgeInsets.symmetric(horizontal: 2),
        height: 36.h,
        width: 165.w,
        decoration: BoxDecoration(
          color: ColorConstants.blueColor,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "$btnText",
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

  Widget btnWidget({
    required Function() onTap,
    required IconData icon,
    required btnText,
  }) {
    return GestureDetector(
      onTap: () => onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        // margin: EdgeInsets.all(20),
        height: 32.h,
        width: 110.w,
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: ColorConstants.blueColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(icon, color: ColorConstants.blueColor, size: 15),
            SizedBox(width: 10),
            Text(
              "$btnText",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorConstants.blueColor,
                fontWeight: FontWeight.w700,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 12.sp,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
