import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_total/src/res/colors/app_colors.dart';

class SigninButton extends StatelessWidget {
  final Function()? onTap;
  final bool cirInd;
  final text;
  const SigninButton({super.key, required this.cirInd,required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.w),
      child: InkWell(
        onTap: onTap,
        child: Container(
          // color: Colors.orange,
          padding: EdgeInsets.all(10),
          // margin: EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          width: double.infinity,
          // height: 38,
          decoration: BoxDecoration(
            color: AppColor.primaryButtonColor,
            border: Border.all(),
            borderRadius: BorderRadius.circular(
              22.r,
            ),
          ),
          child: cirInd?Center(child: CircularProgressIndicator()):Text(
            text,
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryTextColor),
          ),
        ),
      ),
    );
  }
}
