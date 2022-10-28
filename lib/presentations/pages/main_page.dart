import 'package:danitor/core/routes/route_names.dart';
import 'package:danitor/core/themes/color_const.dart';
import 'package:danitor/presentations/pages/emergency_page.dart';
import 'package:danitor/presentations/pages/home_page.dart';
import 'package:danitor/presentations/pages/profile_page.dart';
import 'package:danitor/presentations/pages/sharing_page.dart';
import 'package:danitor/presentations/providers/auth_notifier.dart';
import 'package:danitor/presentations/providers/user_notifier.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = context.read<AuthNotifier>();
    if (provider.isLogin) {
      context.read<UserNotifier>()..getUserData();
    }
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Builder(builder: (context) {
          final dataUser = context.watch<UserNotifier>();
          final provider = context.read<AuthNotifier>();

          if (dataUser.userEntity == null && !provider.isAnonymous) {
            return Center(child: CircularProgressIndicator());
          }

          // final List<Widget> _pages = [
          //   HomePage(
          //     id: dataUser.userEntity!.location,
          //   ),
          //   // provider.isAnonymous ? AnonymousPage() : SharingPage(),
          //   provider.isAnonymous ? AnonymousPage() : EmergencyPage(),
          //   provider.isAnonymous ? AnonymousPage() : ProfilePage(),
          // ];
          return HomePage(
            id: provider.isAnonymous ? null : dataUser.userEntity!.location,
          );
        }),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   showSelectedLabels: false,
      //   showUnselectedLabels: false,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: SvgPicture.asset(
      //         'assets/icons/home_u.svg',
      //         color: kGreyDark,
      //       ),
      //       label: 'Home',
      //       activeIcon: SvgPicture.asset(
      //         'assets/icons/home_a.svg',
      //         color: kGreyDark,
      //       ),
      //     ),
      //     // BottomNavigationBarItem(
      //     //   icon: SvgPicture.asset(
      //     //     'assets/icons/gallery_u.svg',
      //     //     color: kGreyDark,
      //     //   ),
      //     //   label: 'Sosial',
      //     //   activeIcon: SvgPicture.asset(
      //     //     'assets/icons/gallery_a.svg',
      //     //     color: kGreyDark,
      //     //   ),
      //     // ),
      //     BottomNavigationBarItem(
      //       icon: SvgPicture.asset(
      //         'assets/icons/emergency_u.svg',
      //         color: kGreyDark,
      //       ),
      //       label: 'Bantuan',
      //       activeIcon: SvgPicture.asset(
      //         'assets/icons/emergency_a.svg',
      //         color: kGreyDark,
      //       ),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: SvgPicture.asset(
      //         'assets/icons/user_u.svg',
      //         color: kGreyDark,
      //       ),
      //       label: 'User',
      //       activeIcon: SvgPicture.asset(
      //         'assets/icons/user_a.svg',
      //         color: kGreyDark,
      //       ),
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   // selectedItemColor: kGreyDark,
      //   elevation: 1,
      //   // unselectedItemColor: kGreySoft,
      //   onTap: (int index) {
      //     setState(() {
      //       _selectedIndex = index;
      //     });
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final provider = context.read<AuthNotifier>();
          if (provider.isLogin) {
            Navigator.pushNamed(context, EMERGENCY_ROUTE_NAME);
          } else {
            Navigator.pushNamed(context, ANONYMOUS_ROUTE_NAME);
          }
        },
        backgroundColor: kWarning,
        child: SvgPicture.asset(
          'assets/icons/emergency_a.svg',
          color: kWhite,
        ),
      ),
    );
  }
}
