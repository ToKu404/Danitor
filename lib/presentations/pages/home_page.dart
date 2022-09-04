import 'package:danitor/core/routes/route_names.dart';
import 'package:danitor/core/themes/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/target_image_notifier.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

      return Scaffold(
        backgroundColor: kGreyDark,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/logo.svg',
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Danitor',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: kWhite,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Builder(builder: (context) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 240,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/banner_home.png'),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 28,
                              ),
                              Text(
                                'apakah hewan ini',
                                style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    color: kGreyDark,
                                    height: 1,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'berbahaya?',
                                style: GoogleFonts.poppins(
                                    fontSize: 28,
                                    color: kGreen,
                                    height: 1,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'pengecek ancaman hewan sekitar berbasis gambar',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: kDisable,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kGreen,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: () async {
                            state.onImageButtonPressed(ImageSource.camera);
                            isPicked = true;
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: const Text('Ambil Gambar'),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kWhite,
                                side: BorderSide(width: 1, color: kGreyDark),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            onPressed: () async {
                              state.onImageButtonPressed(ImageSource.gallery);
                              isPicked = true;
                            },
                            child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text(
                                  'Pilih dari galery',
                                  style: TextStyle(color: kGreyDark),
                                ))),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
