import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_total/src/view/home/home_view.dart';
import 'package:movie_total/src/view/login/login_view.dart';

import '../../../utils/routes_name.dart';
import '../../../utils/utils.dart';


class AuthService {
  //handle auth  state

  handleAuthState() {

    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const SignInScreen();
          }
        });
  }

  // sigin in with google
  signInWithGoogle(BuildContext context) async {
    //trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    //obtain the auth details from the request

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // once signed in , return the user credential

    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) {
      Navigator.pushNamedAndRemoveUntil(
          context, RouteName.homeScreen, (route) => false);
      Utils.toastMessage(
          '${FirebaseAuth.instance.currentUser!.email!} is logged in successfully');
    }).onError((error, stackTrace) {
      Utils.toastMessage(error.toString());
    });
  }

  // Sign out
  signOut(BuildContext context) async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signOut();
    // await googleUser.signOut();
    FirebaseAuth.instance.signOut().then((value) {
      
      Navigator.pushNamedAndRemoveUntil(
          context, RouteName.signInPage, (route) => false);
      Utils.toastMessage('Logged out successfully');
    }).onError((error, stackTrace) {
      Utils.toastMessage(error.toString());
    });
  }

  signInWithEmailAndPassword(BuildContext context,String email, String password) async {
    
// trying sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Navigator.pop(context);
      //wrong email
      if (e.code == 'user-not-found')
        Utils.toastMessage("Incorrect Mail");

      //wrong password

      else if (e.code == 'wrong-password') Utils.toastMessage("Incorrect Password");
    }


  }
}

/*
class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage())));
    }
    // else {
    //   Timer(
    //       Duration(seconds: 3),
    //       () => Navigator.push(
    //           context, MaterialPageRoute(builder: (context) => SignInPage())));
    // }
  }
}
*/