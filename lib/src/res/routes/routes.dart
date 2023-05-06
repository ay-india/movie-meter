import 'package:flutter/material.dart';
import 'package:movie_total/src/res/routes/routes_name.dart';

import 'package:movie_total/src/view/home/home_view.dart';
import 'package:movie_total/src/view/login/login_view.dart';
import 'package:movie_total/src/view/movie/movie_view.dart';

import '../../view/login/register_view.dart';


class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (context) => const  HomeScreen());
      case RouteName.signInPage:
        return MaterialPageRoute(builder: (context) => const  SignInScreen());
        case RouteName.signUpPage:
        return MaterialPageRoute(builder: (context) => const  SignUpScreen());
        case RouteName.movieScreen:
        return MaterialPageRoute(builder: (context) => const  MovieView());
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(child: Text('No route defined')),
          );
        });
    }
  }
}