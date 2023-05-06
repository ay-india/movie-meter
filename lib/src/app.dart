import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_total/src/res/colors/app_colors.dart';
import 'package:movie_total/src/res/routes/routes.dart';
import 'package:movie_total/src/view/splash_screen.dart';

import 'view_model/services/auth/auth_services.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Movie Meter',
          theme: ThemeData.light(useMaterial3: true).copyWith(
              scaffoldBackgroundColor: AppColor.whiteColor,
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColor.whiteColor,
              )),
          // theme: ThemeData(
          //   primarySwatch: Colors.blue,
          //   textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          // ),
          // home: child,
          home: SplashScreen(),
          // initialRoute: AuthService().handleAuthState(),
          onGenerateRoute: Routes.generateRoute,
        );
      },
      child: Scaffold(),
    );
  }
}
