import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserAuthInput extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final controller;
  final bool passwordVisibleIcon;
  const UserAuthInput(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller,
      required this.passwordVisibleIcon});

  @override
  State<UserAuthInput> createState() => _UserAuthInputState();
}

class _UserAuthInputState extends State<UserAuthInput> {
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 25.w, left: 25.w, top: 5.h, bottom: 7.h),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          fillColor: Color.fromARGB(255, 245, 244, 244),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 216, 214, 209),
              width: 2.w,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(20.r),
          ),
          hintText: widget.hintText,
          suffixIcon: widget.passwordVisibleIcon
              ? IconButton(
                  icon: Icon(passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(
                      () {
                        passwordVisible = !passwordVisible;
                      },
                    );
                  },
                )
              : const Text(''),
        ),
        obscureText: widget.obscureText == false ? false : !passwordVisible,
      ),
    );
  }
}
