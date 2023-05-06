import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_total/main.dart';
import 'package:movie_total/src/model/popular_movie_model.dart';
import 'package:movie_total/src/res/colors/app_colors.dart';
import 'package:movie_total/src/view/favourite/favourite.dart';
import 'package:movie_total/src/view/home/widgets/app_bar.dart';
import 'package:movie_total/src/view/movie/movie_view.dart';
import 'package:movie_total/src/view_model/services/auth/auth_services.dart';

import '../../model/trending_movie_model.dart';
import '../../res/routes/routes_name.dart';
import '../../view_model/services/api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiServices client = ApiServices();
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 28.h,
          ),

          // Appbar
          // MyAppBar(onTap: AuthService().signOut(context)),
          Container(
            height: 45.h,
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                    child: Text(
                  'MovieMeter',
                  style: TextStyle(
                    fontSize: 21.sp,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FavouriteView()),
                        );
                      },
                      child: const Icon(Icons.favorite_border_outlined),
                    ),
                    SizedBox(
                      width: 25.w,
                    ),
                    InkWell(
                      onTap: () {
                        AuthService().signOut(context);
                      },
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
          ),

// Top Rated Movie

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 9.0.w, vertical: 7.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Top Rated",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19.sp,
                      color: Colors.black),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    "See More",
                    style: TextStyle(color: Colors.blue[300]),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 284.h,
            width: double.infinity,
            child: FutureBuilder(
              future: client.fetchTopRatedMovie(),
              builder: (context, AsyncSnapshot<TrendingMovie> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.totalResults,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MovieView(
                                      isfavourite: false,
                                          id: snapshot
                                              .data!.results![index].id!,
                                          index: index,
                                          category: 'top_rated',
                                        )));
                          },
                          child: Container(
                            margin: EdgeInsets.all(10.sp),
                            // height: 20,
                            width: 170.w,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(
                                    0.5,
                                  ),
                                  spreadRadius: 1.sp,
                                  blurRadius: 8.sp,
                                  offset: const Offset(
                                    0,
                                    3,
                                  ),
                                ),
                              ],
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(19.r),
                            ),
                            child: Column(children: [
                              Container(
                                margin: EdgeInsets.all(4.sp),
                                height: 180.h,
                                width: 220.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18.r),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      'https://image.tmdb.org/t/p/original${snapshot.data!.results![index].posterPath.toString()}',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 9.w),
                                // height: 50,
                                width: 220.w,
                                decoration: BoxDecoration(
                                  // color: Colors.white38,
                                  borderRadius: BorderRadius.circular(18.r),
                                ),
                                child: Text(
                                  snapshot.data!.results![index].title
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(3.sp),
                                // margin: EdgeInsets.all(5),
                                alignment: Alignment.bottomRight,
                                // height: 25,
                                width: 220.w,
                                // color: Colors.white54,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star_rate,
                                      color: Colors.yellow,
                                    ),
                                    Text(
                                      '${snapshot.data!.results![index].voteAverage.toString()}/10',
                                      style: const TextStyle(
                                          color: AppColor.secondaryTextColor),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        );
                      });
                }
              },
            ),
          ),

          SizedBox(
            height: 13.h,
          ),

//----------------------------------------------------------------------
          // Popular Movies

          Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1.sp,
                  blurRadius: 4.sp,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 7.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19.sp,
                      color: Colors.black),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    "See More",
                    style: TextStyle(color: Colors.blue[300]),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
                width: double.infinity,
                child: FutureBuilder(
                  future: client.fetchPopularMovie(),
                  builder: (context, AsyncSnapshot<TrendingMovie> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                            itemCount: snapshot.data!.totalResults,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieView(
                                        isfavourite: false,
                                          id: snapshot
                                              .data!.results![index].id!,
                                          index: index,
                                          category: 'trending'),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10.sp),
                                  height: 140.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(
                                          0.5,
                                        ),
                                        spreadRadius: 1.sp,
                                        blurRadius: 8.sp,
                                        offset: const Offset(
                                          0,
                                          3,
                                        ),
                                      ),
                                    ],
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(19.r),
                                  ),
                                  child: Row(children: [
                                    Container(
                                      margin: EdgeInsets.all(4.sp),
                                      height: 130.h,
                                      width: 110.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(18.r),
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                            'https://image.tmdb.org/t/p/original${snapshot.data!.results![index].posterPath.toString()}',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: 13.h,
                                            right: 7.w,
                                            left: 8.w,
                                            bottom: 7.h,
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.sp),
                                          // height: 50,
                                          width: 200.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18.r),
                                          ),
                                          child: Text(
                                            snapshot.data!.results![index].title
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(3.sp),
                                          // margin: EdgeInsets.all(5),
                                          alignment: Alignment.bottomRight,
                                          // height: 25,
                                          width: 220.w,
                                          // color: Colors.white54,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star_rate,
                                                    color: Colors.yellow,
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Text(
                                                    '${snapshot.data!.results![index].voteAverage.toString()}/10',
                                                    style: TextStyle(
                                                        fontSize: 18.sp,
                                                        color: AppColor
                                                            .secondaryTextColor),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0.sp),
                                                child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                        'Release Date: ${snapshot.data!.results![index].releaseDate.toString()}')),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ]),
                                ),
                              );
                            }),
                      );
                    }
                  },
                )),
          )
        ],
      ),
    );
  }
}
