import 'package:danitor/core/themes/color_const.dart';
import 'package:danitor/presentations/providers/select_location_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../core/routes/route_names.dart';
import '../providers/get_info_location_notifier.dart';
import '../providers/target_image_notifier.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future.microtask(() {
      Provider.of<SelectLocationHandler>(context, listen: false).initId(1);
      if (1 != -1) {
        Provider.of<GetInfoLocationNotifier>(context, listen: false)
            .getInfoLocation(1);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isPicked = false;

    return Consumer<TargetImageNotifier>(builder: (context, state, child) {
      if (state.image != null && isPicked) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, FULL_SCREEN_IMAGE_ROUTE_NAME,
              arguments: state.image);
        });
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarHome(),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Color(0xFFE9EAEA),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BuildTitle(
                        title: 'Pilih Tempat Wisata',
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, DESTINATION_ROUTE_NAME,
                            arguments: false),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            children: [
                              Image.network(
                                'https://d3p0bla3numw14.cloudfront.net/news-content/img/2021/05/03112735/Tempat-Tinggal-Terbaik-di-Bali.jpg',
                                height: 180,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black,
                                        Colors.black.withOpacity(.45),
                                        Colors.transparent
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  padding: EdgeInsets.all(12),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.location_on_rounded,
                                          color: kGreen,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Builder(builder: (context) {
                                          final provider = context
                                              .watch<SelectLocationHandler>();
                                          final name = provider.locationName;
                                          return Text(
                                              '${name[0].toUpperCase()}${name.substring(1, name.length)}',
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: kWhite,
                                              ));
                                        })
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 24,
                    left: 16,
                    right: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BuildTitle(
                        title: 'Deteksi Hewan Berbahaya',
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      BuildDetectionCard(
                        title: 'Ambil Gambar',
                        subtitle: 'Potret hewan secara langsung',
                        icon: SvgPicture.asset(
                          'assets/icons/camera.svg',
                        ),
                        onTap: () async {
                          state.onImageButtonPressed(ImageSource.camera);
                          isPicked = true;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      BuildDetectionCard(
                        title: 'Pilih dari Galeri',
                        subtitle: 'Pilih foto hewan dari galeri anda',
                        icon: SvgPicture.asset(
                          'assets/icons/file.svg',
                        ),
                        onTap: () async {
                          state.onImageButtonPressed(ImageSource.gallery);
                          isPicked = true;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                // Todo : Kondisi jika tidak kosong
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: BuildTitle(
                        title: 'Riwayat Deteksi',
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.height,
                      height: 140,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(right: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Stack(
                                children: [
                                  Image.network(
                                    'https://www.zubludiving.com/images/Mabul-blueringed-octopus-banner.jpg',
                                    width: 240,
                                    height: 140,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    width: 240,
                                    height: 140,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                          Colors.black,
                                          Colors.transparent
                                        ],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter)),
                                  ),
                                  Positioned(
                                    bottom: 8,
                                    left: 8,
                                    right: 8,
                                    child: SizedBox(
                                      width: 224,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Blue Ring Octopus',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: kWhite,
                                            ),
                                          ),
                                          Text(
                                            'Akurasi 90%',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              height: 1.2,
                                              color: kGreen,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    left: 8,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: kGreyDark,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.location_on_rounded,
                                            color: kWhite,
                                            size: 12,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            'Denpasar, Bali',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              height: 1.2,
                                              color: kWhite,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                )
              ],
            ),
          ))
        ],
      );
    });
  }
}

class BuildDetectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final SvgPicture icon;
  final VoidCallback onTap;
  const BuildDetectionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1, color: Color(0xFFD9D9D9))),
        child: Row(
          children: [
            Container(
              width: 50,
              padding: EdgeInsets.all(8),
              child: Center(
                child: InkWell(
                  child: Container(
                    height: 30,
                    width: 30,
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: kGreen,
                      shape: BoxShape.circle,
                    ),
                    child: icon,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        height: 1,
                        color: kGreyDark,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Color(0xFF858C98),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BuildTitle extends StatelessWidget {
  final String title;
  const BuildTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
          fontSize: 16,
          height: 1,
          color: kGreyDark,
          fontWeight: FontWeight.w500),
    );
  }
}

class AppBarHome extends StatelessWidget {
  const AppBarHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xFFE9EAEA),
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Color(0xFFDFDFDF),
          ),
        ),
      ),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/logo.svg',
                height: 30,
                color: kGreen,
              ),
              Text(
                'Danitor',
                style: GoogleFonts.poppins(
                    fontSize: 18, color: kGreen, fontWeight: FontWeight.bold),
              )
            ],
          ),
          // InkWell(
          //   onTap: () {},
          //   child: Container(
          //     height: 30,
          //     width: 30,
          //     padding: EdgeInsets.all(6),
          //     decoration: BoxDecoration(
          //       color: kGreen,
          //       shape: BoxShape.circle,
          //     ),
          //     child: SvgPicture.asset('assets/icons/notif.svg'),
          //   ),
          // )
        ],
      ),
    );
  }
}
