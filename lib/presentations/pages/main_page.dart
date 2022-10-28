import 'package:danitor/core/routes/route_names.dart';
import 'package:danitor/core/themes/color_const.dart';
import 'package:danitor/presentations/pages/emergency_page.dart';
import 'package:danitor/presentations/pages/home_page.dart';
import 'package:danitor/presentations/pages/profile_page.dart';
import 'package:danitor/presentations/pages/sharing_page.dart';
import 'package:danitor/presentations/providers/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthNotifier>();

    final List<Widget> _pages = [
      HomePage(),
      provider.isAnonymous ? AnonymousPage() : SharingPage(),
      provider.isAnonymous ? AnonymousPage() : EmergencyPage(),
      provider.isAnonymous ? AnonymousPage() : ProfilePage(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home_u.svg',
              color: kGreyDark,
            ),
            label: 'Home',
            activeIcon: SvgPicture.asset(
              'assets/icons/home_a.svg',
              color: kGreyDark,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/gallery_u.svg',
              color: kGreyDark,
            ),
            label: 'Sosial',
            activeIcon: SvgPicture.asset(
              'assets/icons/gallery_a.svg',
              color: kGreyDark,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/emergency_u.svg',
              color: kGreyDark,
            ),
            label: 'Bantuan',
            activeIcon: SvgPicture.asset(
              'assets/icons/emergency_a.svg',
              color: kGreyDark,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/user_u.svg',
              color: kGreyDark,
            ),
            label: 'User',
            activeIcon: SvgPicture.asset(
              'assets/icons/user_a.svg',
              color: kGreyDark,
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: kGreyDark,
        elevation: 1,
        // unselectedItemColor: kGreySoft,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class AnonymousPage extends StatelessWidget {
  const AnonymousPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 100,
                width: 100,
                child: SvgPicture.asset('assets/empty.svg')),
            SizedBox(
              height: 16,
            ),
            Text(
              'Fitur Tidak Tersedia',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold, color: kGreyDark),
            ),
            Text(
              'Harap login terlebih dahulu',
              style: GoogleFonts.poppins(fontSize: 14, color: kGreyDark),
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
                provider.setAnonymous(false);
                Navigator.pushNamedAndRemoveUntil(
                    context, WRAPPER_ROUTE_NAME, (route) => false);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  'Masuk',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
