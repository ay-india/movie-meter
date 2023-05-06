import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_total/src/view_model/services/auth/auth_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  void initState() {
    super.initState();
    AuthService().handleAuthState();
    controller =
        new AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..forward();
    animation = new CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AuthService().handleAuthState())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200.h,
              width: 200.w,
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                image: const DecorationImage(
                    image: AssetImage('asset/images/splash.png'),
                    fit: BoxFit.cover),
              ),
            ),
            Text(
              'Movie Meter',
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSplashScreen(
//       duration: 3000,
//       splash: Column(
//         children: [
//           Container(
//             height: 57,
//             width: 100,
//             decoration: const BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//               image: DecorationImage(
//                   image: AssetImage('asset/images/splash.png'),
//                   fit: BoxFit.cover),
//             ),
//           ),
//           Text(
//             'Movie Meter',
//             style: TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.bold,
//             ),
//           )
//         ],
//       ),
//       nextScreen: AuthService().handleAuthState(),
//       splashTransition: SplashTransition.fadeTransition,
//       // pageTransitionType: PageTransitionType.scale,
//     );
//   }
// }
