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
            height: 35,
          ),

          // Appbar
          // MyAppBar(onTap: AuthService().signOut(context)),
          Container(
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
                      width: 15.w,
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
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Top Rated",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
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
                                          index: index,
                                          category: 'top_rated',
                                        )));
                          },
                          child: Container(
                            margin: EdgeInsets.all(12),
                            // height: 20,
                            width: 200,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(
                                    0.5,
                                  ),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: const Offset(
                                    0,
                                    3,
                                  ),
                                ),
                              ],
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(19),
                            ),
                            child: Column(children: [
                              Container(
                                margin: const EdgeInsets.all(5),
                                height: 180.h,
                                width: 230,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      'https://image.tmdb.org/t/p/original${snapshot.data!.results![index].posterPath.toString()}',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                // height: 50,
                                width: 230,
                                decoration: BoxDecoration(
                                  // color: Colors.white38,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Text(
                                  snapshot.data!.results![index].title
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(3),
                                // margin: EdgeInsets.all(5),
                                alignment: Alignment.bottomRight,
                                // height: 25,
                                width: 230,
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

          const SizedBox(
            height: 15,
          ),

//----------------------------------------------------------------------
          // Popular Movies

          Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Popular",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
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
                                          index: index, category: 'trending'),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(12),
                                  height: 140.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(
                                          0.5,
                                        ),
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: const Offset(
                                          0,
                                          3,
                                        ),
                                      ),
                                    ],
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(19),
                                  ),
                                  child: Row(children: [
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      height: 130.h,
                                      width: 110.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(18),
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
                                          margin: const EdgeInsets.only(
                                            top: 15,
                                            right: 8,
                                            left: 8,
                                            bottom: 8,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          // height: 50,
                                          width: 200.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                          child: Text(
                                            snapshot.data!.results![index].title
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(3),
                                          // margin: EdgeInsets.all(5),
                                          alignment: Alignment.bottomRight,
                                          // height: 25,
                                          width: 230,
                                          // color: Colors.white54,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star_rate_outlined,
                                                    color: Colors.yellow,
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Text(
                                                    '${snapshot.data!.results![index].voteAverage.toString()}/10',
                                                    style: const TextStyle(
                                                        fontSize: 19,
                                                        color: AppColor
                                                            .secondaryTextColor),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
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
