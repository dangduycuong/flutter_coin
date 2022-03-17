import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:styled_widget/styled_widget.dart';

Center loadingData(BuildContext context, String message) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/loading_default.json',
          repeat: true,
          reverse: false,
          animate: true,
          width: 100.w,
          height: 100.h,
        ).backgroundColor(Colors.transparent),
        Text(
          message,
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}
