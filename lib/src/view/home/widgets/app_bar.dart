import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppBar extends StatelessWidget {
  final Function()? onTap;
  const MyAppBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.only(left: 10.w, right: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Center(
              child: Text(
            'MovieMeter',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {},
                child: const Icon(Icons.favorite_border_outlined),
              ),
              SizedBox(
                width: 15.w,
              ),
              InkWell(
                onTap: 
                  onTap
                ,
                child: const Icon(Icons.logout),
              ),

              // InkWell(
              //   onTap: () {
              //     Navigator.pushNamed(context, RouteName.movieScreen);
              //   },
              //   child: Icon(Icons.navigate_next),
              // )
            ],
          )
        ],
      ),
    );
  }
}
