import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_total/src/res/colors/app_colors.dart';

import 'package:movie_total/src/utils/utils.dart';
import 'package:movie_total/src/view/login/widgets/sign_in_button.dart';
import 'package:movie_total/src/view/login/widgets/user_auth_input.dart';

import '../../res/routes/routes_name.dart';
import '../../view_model/services/auth/auth_services.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  bool circularind = false;
  final passwordController = TextEditingController();

  void signUserIn() async {
// trying sign in
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((value) {
        Utils.toastMessage('Login Successfully');
        circularind = false;
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.homeScreen, (route) => false);
      }).onError((error, stackTrace) {
        circularind = false;
        Utils.toastMessage('   Wrong Email/Password !  ');
      });
    } on FirebaseAuthException catch (e) {
      //wrong email
      if (e.code == 'user-not-found')
        Utils.toastMessage("Incorrect Mail");

      //wrong password

      else if (e.code == 'wrong-password')
        Utils.toastMessage("Incorrect Password");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // login ui image
            Container(
              height: 230.h,
              width: 330.w,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/images/login.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 28..sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),

            //email
            UserAuthInput(
                hintText: 'Email',
                obscureText: false,
                controller: emailController,
                passwordVisibleIcon: false),

            //password

            UserAuthInput(
                hintText: 'Password',
                obscureText: true,
                controller: passwordController,
                passwordVisibleIcon: true),
            SizedBox(
              height: 10.h,
            ),

            // login button

            SigninButton(
              text: 'Login',
              onTap: () {
                circularind = true;
                signUserIn();
                setState(() {});
              },
              cirInd: circularind,
            ),

            //
            SizedBox(
              height: 18.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Divider(
                    indent: 35.w,
                    thickness: 1.h,
                  ),
                ),
                const Text(' or '),
                Expanded(
                  child: Divider(
                    endIndent: 35.w,
                    thickness: 1.h,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            // Google sigin in
            Center(
              child: InkWell(
                onTap: () {
                  AuthService().signInWithGoogle(context);
                  // Timer(Duration(seconds: 4),
                  //     () => AuthService().isLogin(context));

                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Container(
                  // clipBehavior: Clip.antiAlias,
                  width: 260,
                  padding: EdgeInsets.fromLTRB(1, 6, 1, 6),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1.5.sp),
                      borderRadius: BorderRadius.circular(13.sp)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'asset/images/google.png',
                        width: 35.34.w,
                        // height: 50,
                      ),
                      Text(
                        "Login in with Google",
                        style: TextStyle(
                          color: AppColor.secondaryTextColor,
                          fontSize: 16.sp,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
//
//

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 18.h),
              child: Row(
                children: [
                  Text(
                    "Not a member yet,",
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, RouteName.signUpPage, (route) => false);
                    },
                    child: Text(
                      'Create an Account',
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
