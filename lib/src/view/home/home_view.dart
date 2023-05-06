import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_total/src/view_model/services/auth/auth_services.dart';

import '../../res/routes/routes_name.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Center(
              child: Text(
            'Home page',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          )),
          InkWell(
            onTap: () {
              AuthService().signOut(context);
            },
            child: Icon(Icons.logout),
          ),
          SizedBox(
            width: 50,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RouteName.movieScreen);
            },
            child: Icon(Icons.navigate_next),
          )
        ],
      ),
    );
  }
}
