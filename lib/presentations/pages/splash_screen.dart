import 'package:danitor/core/routes/route_names.dart';
import 'package:danitor/core/themes/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushNamedAndRemoveUntil(
          context, HOME_ROUTE_NAME, (route) => false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/logo.svg',
              color: kWhite,
            ),
            Text(
              'Danitor',
              style: GoogleFonts.poppins(
                  fontSize: 24, color: kWhite, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
