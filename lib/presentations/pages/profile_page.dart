import 'package:danitor/core/routes/route_names.dart';
import 'package:danitor/core/themes/color_const.dart';
import 'package:danitor/core/common/auth_helper.dart';
import 'package:danitor/presentations/providers/auth_notifier.dart';
import 'package:danitor/presentations/providers/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<UserNotifier>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: kWhite,
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Color(0xFFDFDFDF),
                        ),
                      ),
                    ),
                    height: 50,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Profil Pengguna',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: kGreen,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: kGreyDark,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama',
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: kWhite, height: 1),
                        ),
                        Text(
                          provider.userEntity!.name,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: kWhite,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Email',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: kWhite,
                            height: 1,
                          ),
                        ),
                        Text(
                          provider.userEntity!.username,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: kWhite,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kGreen,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: () async {
                            final provider = context.read<AuthNotifier>();
                            provider.logout();
                            Navigator.pushNamedAndRemoveUntil(
                                context, WRAPPER_ROUTE_NAME, (route) => false);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text(
                              'Keluar',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
