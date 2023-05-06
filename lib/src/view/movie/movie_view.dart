import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_total/src/model/trending_movie_model.dart';
import 'package:movie_total/src/res/colors/app_colors.dart';
import 'package:movie_total/src/utils/utils.dart';
import 'package:movie_total/src/view_model/services/api_services.dart';

class MovieView extends StatefulWidget {
  final bool isfavourite;
  final int id;
  final int index;
  final String category;
  const MovieView(
      {super.key,
      required this.id,
      required this.index,
      required this.category,
      required this.isfavourite});

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  late String? userEmail;
  bool tap = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tap = widget.isfavourite;
    userEmail = FirebaseAuth.instance.currentUser!.email;
    // checkFavourite();
  }

  late CollectionReference<Map<String, dynamic>> firestore =
      FirebaseFirestore.instance.collection(userEmail!);

  // late Stream<QuerySnapshot<Map<String, dynamic>>> ref = FirebaseFirestore
  //     .instance
  //     .collection(FirebaseAuth.instance.currentUser!.email!)
  //     .snapshots();

  ApiServices client = ApiServices();

  late DocumentReference _documentReference = FirebaseFirestore.instance
      .collection(userEmail!)
      .doc(widget.id.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        child: FutureBuilder(
          future: widget.category == 'top_rated'
              ? client.fetchTopRatedMovie()
              : client.fetchPopularMovie(),
          builder: (context, AsyncSnapshot<TrendingMovie> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Stack(children: [
                Container(
                  height: 330.h,
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
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColor.whiteColor,
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
                        size: 32.sp,
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
                    height: 380.h,
                    // width: double.maxFinite,
                    width: 360.w,
                    decoration: BoxDecoration(
                      color: AppColor.backgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22.r),
                        topRight: Radius.circular(22.r),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.all(13.sp),
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
                                    onPressed: () {
                                      tap = !tap;
                                      if (tap) {
                                        firestore
                                            .doc(snapshot
                                                .data!.results![widget.index].id
                                                .toString())
                                            .set({
                                              'releaseDate': snapshot
                                                  .data!
                                                  .results![widget.index]
                                                  .releaseDate
                                                  .toString(),
                                              'rating': snapshot
                                                  .data!
                                                  .results![widget.index]
                                                  .voteAverage
                                                  .toString(),
                                              'img':
                                                  'https://image.tmdb.org/t/p/original${snapshot.data!.results![widget.index].posterPath.toString()}',
                                              'title': snapshot.data!
                                                  .results![widget.index].title
                                                  .toString(),
                                              'index': widget.index,
                                              'category': widget.category,
                                              'id': snapshot.data!
                                                  .results![widget.index].id
                                                  .toString()
                                            })
                                            .then((value) => Utils.toastMessage(
                                                "Added to favourite List"))
                                            .onError(
                                              (error, stackTrace) =>
                                                  Utils.toastMessage(
                                                error.toString(),
                                              ),
                                            );
                                      } else {
                                        _documentReference.delete();
                                      }
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      Icons.favorite_outlined,
                                      color: tap ? Colors.red : Colors.white,
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
                                        Icon(
                                          Icons.star_rate,
                                          color: Colors.yellow,
                                          size: 26.sp,
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
