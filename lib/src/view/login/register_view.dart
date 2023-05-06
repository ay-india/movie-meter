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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool circularind = false;
  final emailController = TextEditingController();
  final nameController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserUp() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((value) {
        circularind = false;
        Utils.toastMessage('Successfully Registered');
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.signInPage, (route) => false);
      }).onError((error, stackTrace) {
        circularind = false;
        Utils.toastMessage("Wrong Formatted Email");
      });
    } on FirebaseAuthException catch (e) {
      Utils.toastMessage(e.toString());
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
              height: 270,
              width: 370,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/images/register.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Sign Up',
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

            //name
            UserAuthInput(
                hintText: 'Name',
                obscureText: false,
                controller: nameController,
                passwordVisibleIcon: false),

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
                text: 'Register',
                onTap: () {
                  circularind = true;
                  signUserUp();
                  setState(() {
                    
                  });
                },
                cirInd: circularind),

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

//
//

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 18.h),
              child: Row(
                children: [
                  Text(
                    "Already have an account,",
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, RouteName.signInPage, (route) => false);
                    },
                    child: Text(
                      'Login here',
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
