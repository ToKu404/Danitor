import 'package:danitor/core/routes/route_names.dart';
import 'package:danitor/core/themes/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late int numInit;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInit();
    });
  }

  _checkInit() async {
    String routeName = HOME_ROUTE_NAME;
    final prefs = await SharedPreferences.getInstance();
    numInit = prefs.getInt('init') ?? -2;
    if (numInit == -2) {
      routeName = DESTINATION_ROUTE_NAME;
    }
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushNamedAndRemoveUntil(
          context, routeName, (route) => false,
          arguments: routeName == DESTINATION_ROUTE_NAME ? true : numInit),
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
            SizedBox(
              width: 200,
              height: 200,
              child: SvgPicture.asset(
                'assets/logo.svg',
                color: kWhite,
                width: 200,
                height: 200,
              ),
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
