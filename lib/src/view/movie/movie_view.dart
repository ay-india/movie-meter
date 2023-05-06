import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_total/src/model/trending_movie_model.dart';
import 'package:movie_total/src/res/colors/app_colors.dart';
import 'package:movie_total/src/view_model/services/api_services.dart';

class MovieView extends StatefulWidget {
  final int index;
  const MovieView({super.key, required this.index});

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  ApiServices client = ApiServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        child: FutureBuilder(
          future: client.fetchTopRatedMovie(),
          builder: (context, AsyncSnapshot<TrendingMovie> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Stack(children: [
                Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://image.tmdb.org/t/p/original${snapshot.data!.results![widget.index].posterPath.toString()}',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

                //back button
                Positioned(
                  top: 16.h,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColor.whiteColor,
                      )),
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
                        color: AppColor.whiteColor,
                      ),
                      Text(
                        'Play Trailer',
                        style: TextStyle(
                            color: AppColor.whiteColor,
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
                      color: AppColor.backgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22),
                        topRight: Radius.circular(22),
                      ),
                    ),
                    child: SingleChildScrollView(
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
                                    snapshot.data!.results![widget.index].title
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 27.sp,
                                        fontWeight: FontWeight.bold),
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
                              width: 150.w,
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
                                      snapshot.data!.results![widget.index]
                                          .releaseDate
                                          .toString(),
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
                              width: 190.w,
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
                                        const Icon(
                                          Icons.star_rate,
                                          color: Colors.yellow,
                                          size: 28,
                                        ),
                                        SizedBox(
                                          width: 6.w,
                                        ),
                                        Text(
                                          '${snapshot.data!.results![widget.index].voteAverage.toString()}/10  (${snapshot.data!.results![widget.index].voteCount.toString()})',
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
                              // maxLines: 7,
                              // overflow: TextOverflow.ellipsis,
                              snapshot.data!.results![widget.index].overview
                                  .toString(),
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
                ),
              ]);
            }
          },
        ),
      ),
    );
  }
}
