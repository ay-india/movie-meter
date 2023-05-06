import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_total/src/res/colors/app_colors.dart';
import 'package:movie_total/src/view_model/services/api_services.dart';

import '../../model/trending_movie_model.dart';
import '../movie/movie_view.dart';

class FavouriteView extends StatefulWidget {
  const FavouriteView({super.key});

  @override
  State<FavouriteView> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> firestore = FirebaseFirestore
      .instance
      .collection(FirebaseAuth.instance.currentUser!.email!)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: Row(children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                'Favourite',
                style: TextStyle(
                  fontSize: 19.sp,
                  color: AppColor.primaryTextColor,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]),
          ),
          //
          //
          // fetching data from firestore

          StreamBuilder<QuerySnapshot>(
            stream: firestore,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Text('Some error');
              }

              return Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieView(
                                isfavourite: true,
                                  id: int.parse(
                                      snapshot.data!.docs[index]['id']),
                                  index: snapshot.data!.docs[index]['index'],
                                  category: snapshot
                                      .data!.docs[index]['category']
                                      .toString()),
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
                            borderRadius: BorderRadius.circular(19.sp),
                          ),
                          child: Row(children: [
                            Container(
                              margin: EdgeInsets.all(5.sp),
                              height: 130.h,
                              width: 110.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18.sp),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    snapshot.data!.docs[index]['img']
                                        .toString(),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 13.sp,
                                    right: 8.sp,
                                    left: 8.sp,
                                    bottom: 8.sp,
                                  ),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.sp),
                                  // height: 50,
                                  width: 200.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18.sp),
                                  ),
                                  child: Text(
                                    snapshot.data!.docs[index]['title']
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
                                            '${snapshot.data!.docs[index]['rating'].toString()}/10',
                                            style: TextStyle(
                                                fontSize: 17.sp,
                                                color: AppColor
                                                    .secondaryTextColor),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 8.0.sp, right: 10.sp),
                                        child: Align(
                                            alignment: Alignment.topRight,
                                            child: IconButton(
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection(FirebaseAuth
                                                          .instance
                                                          .currentUser!
                                                          .email!)
                                                      .doc(snapshot.data!
                                                          .docs[index]['id'])
                                                      .delete();
                                                },
                                                icon: Icon(Icons.delete))),
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
            },
          )
        ]),
      ),
    );
  }
}
