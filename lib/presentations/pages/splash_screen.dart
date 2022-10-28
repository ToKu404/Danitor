import 'package:danitor/core/routes/route_names.dart';
import 'package:danitor/core/themes/color_const.dart';
import 'package:danitor/core/common/auth_helper.dart';
import 'package:danitor/presentations/providers/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Provider.of<AuthNotifier>(context)..checkLoginStatus();
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushNamedAndRemoveUntil(
        context,
        WRAPPER_ROUTE_NAME,
        (route) => false,
      ),
    );
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   final provider = context.read<AuthNotifier>();
    //   provider.checkLoginStatus();
    //   if (provider.isLogin || provider.isAnonymous) {
    //     Future.delayed(
    //       const Duration(seconds: 3),
    //       () => Navigator.pushNamedAndRemoveUntil(
    //         context,
    //         MAIN_ROUTE_NAME,
    //         (route) => false,
    //       ),
    //     );
    //   } else {
    //     Future.delayed(
    //       const Duration(seconds: 3),
    //       () => Navigator.pushNamedAndRemoveUntil(
    //         context,
    //         LOGIN_ROUTE_NAME,
    //         (route) => false,
    //       ),
    //     );
    //   }
    // });
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
