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
            padding: EdgeInsets.all(10),
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
                                  index: snapshot.data!.docs[index]['index'],
                                  category: snapshot
                                      .data!.docs[index]['category']
                                      .toString()),
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
                                    snapshot.data!.docs[index]['img']
                                        .toString(),
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
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Text(
                                    snapshot.data!.docs[index]['title']
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
                                            '${snapshot.data!.docs[index]['rating'].toString()}/10',
                                            style: const TextStyle(
                                                fontSize: 19,
                                                color: AppColor
                                                    .secondaryTextColor),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                                'Release Date: ${snapshot.data!.docs[index]['releaseDate'].toString()}')),
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
