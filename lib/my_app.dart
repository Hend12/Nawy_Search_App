import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'router/router.dart';
import 'router/routes_constants.dart';

//Alice alice = Alice(showNotification: false);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, widget) {
        //add this line
        // ScreenUtil.setContext(context);
        return MediaQuery(
          //Setting font does not change with systeRm font size
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: ScreenUtilInit(
              designSize: Size(420, 770),
              useInheritedMediaQuery: true,
              builder: (_, child) {
                return Stack(
                  children: [
                    GetMaterialApp(
                      //navigatorKey: alice.getNavigatorKey(),
                      //  key: _appkey,
                     // fallbackLocale: LocalizationService.fallbackLocale,
                     //  localizationsDelegates: [
                     //    GlobalMaterialLocalizations.delegate,
                     //    GlobalWidgetsLocalizations.delegate,
                     //    GlobalCupertinoLocalizations.delegate,
                     //  ],
                      supportedLocales: [
                        const Locale('en', 'US'),
                        const Locale('ar', 'EG'),
                      ],
                      //translations: LocalizationService(),
                      title: "Nawy",
                      debugShowCheckedModeBanner: false,
                     // theme: AppThemeData.lightTheme,
                     // darkTheme: AppThemeData.lightTheme,
                     // themeMode: ThemeService().theme,
                      initialRoute: RoutesConstants.tabsScreen,

                      getPages: AppRouter.routes,
                    ),
                    // Align(
                    //   alignment: Alignment.topCenter,
                    //   child: CustomButton(
                    //       title: "show alice",
                    //       onPressed: () {
                    //         alice.showInspector();
                    //       }),
                    // )
                  ],
                );
              }),
        );
      },
    );
  }
}
