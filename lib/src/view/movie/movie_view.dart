import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_total/src/res/colors/app_colors.dart';

class MovieView extends StatefulWidget {
  const MovieView({super.key});

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        child: Stack(children: [
          Container(
            height: 400,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('asset/images/m2.jfif'),
                fit: BoxFit.fill,
              ),
            ),
          ),

          Positioned(
            top: 130.h,
            left: 130.w,
            child: Container(
              height: 50.h,
              width: 100.w,
              // color: Colors.red,
              child: Column(children: [
                Icon(
                  Icons.play_circle,
                  size: 35,
                ),
                Text(
                  'Play Trailer',
                  style: TextStyle(
                      color: AppColor.primaryTextColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500),
                ),
              ]),
            ),
          ),

          // Second part
          Positioned(
            bottom: 0,
            child: Container(
              height: 450,
              // width: double.maxFinite,
              width: 360.w,
              decoration: const BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                ),
              ),
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 280.w,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            'Puspa: The Rise',
                            style: TextStyle(
                                fontSize: 27.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite_outlined,
                              color: Colors.red,
                            ))
                      ]),
                ),

                // release date and rating

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 14.w),
                      height: 60.h,
                      width: 220.w,
                      // color: Colors.red,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Release Date',
                              style: TextStyle(
                                  color: AppColor.secondaryTextColor,
                                  fontSize: 17.sp),
                            ),
                            Text(
                              '12-November-2021',
                              style: TextStyle(
                                color: AppColor.primaryTextColor,
                                fontSize: 20.sp,
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 14.w),
                      height: 60.h,
                      width: 120.w,
                      // color: Colors.yellow,
                      child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rating',
                              style: TextStyle(
                                  color: AppColor.secondaryTextColor,
                                  fontSize: 17.sp),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star_rate,
                                  color: Colors.yellow,
                                  size: 28,
                                ),
                                SizedBox(
                                  width: 6.w,
                                ),
                                Text(
                                  '6.4/10',
                                  style: TextStyle(
                                    color: AppColor.primaryTextColor,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    )
                  ],
                ),
                // SizedBox(
                //   height: 10,
                // ),
                Padding(
                  padding: EdgeInsets.only(left: 14.w),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Description',
                        style: TextStyle(
                          color: AppColor.secondaryTextColor,
                          fontSize: 18.sp,
                        ),
                      )),
                ),
                Container(
                  padding: EdgeInsets.all(14.w),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      maxLines: 7,
                      overflow: TextOverflow.ellipsis,
                      'Pushpa: The Rise – Part 01 (simply known as Pushpa: The Rise) is a 2021 Indian Telugu-language action drama film[17] written and directed by Sukumar. It stars Allu Arjun as the titular character alongside Fahadh Faasil (his Telugu debut), and Rashmika Mandanna while Jagadeesh Prathap Bandari, Sunil, Raj Tirandasu, Rao Ramesh, Dhananjaya, Anasuya Bharadwaj, Ajay and Ajay Ghosh play supporting roles. It is produced by Mythri Movie Makers in association with Muttamsetty Media. The first of two cinematic parts, the film depicts the rise of a low wage laborer Pushpa Raj in the smuggling syndicate of red sandalwood, a rare wood that grows only in the Seshachalam Hills of Chittoor in Andhra Pradesh state.',
                      style: TextStyle(
                        color: AppColor.primaryTextColor,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
