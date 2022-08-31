import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:danitor/core/themes/color_const.dart';
import 'package:danitor/presentations/providers/detection_helper_notifier.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../data/models/detection.dart';

class FullScreenImagePage extends StatefulWidget {
  final File fileImage;
  const FullScreenImagePage({Key? key, required this.fileImage})
      : super(key: key);

  @override
  State<FullScreenImagePage> createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DetectionHelperNotifier>();

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: FileImage(widget.fileImage),
                fit: BoxFit.cover,
              )),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(widget.fileImage),
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      width: 80,
                      height: 70,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: kWarning)),
                    )
                  ],
                ),
              ),
            ),
            provider.isStartDetect
                ? DraggableScrollableSheet(
                    initialChildSize: 0.30,
                    minChildSize: 0.21,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      final provid = context.watch<DetectionHelperNotifier>();
                      return Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          color: kWhite,
                        ),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    child: Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: kWhite,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(Icons.arrow_back_rounded),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: kWhite,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        'Hasil Deteksi',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: kGreyDark,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  InkWell(
                                    child: Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: kWhite,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(Icons.arrow_forward_rounded),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width -
                                    (16 * 2),
                                child: Text(
                                  animalClassEncode(
                                      provid.listObject[0].objectDetectedClass),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    height: 1,
                                    fontWeight: FontWeight.bold,
                                    color: kGreen,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: kWarning),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.warning,
                                            size: 14,
                                            color: kWhite,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            'Berbahaya',
                                            style: GoogleFonts.poppins(
                                              color: kWhite,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: kPoison),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.skull,
                                            size: 14,
                                            color: kWhite,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            'Beracun',
                                            style: GoogleFonts.poppins(
                                              color: kWhite,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: kGreyDark,
                                      ),
                                      child: Column(
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.tooth,
                                            color: kWhite,
                                            size: 14,
                                          ),
                                          Text(
                                            'Menggigit',
                                            style: GoogleFonts.poppins(
                                                fontSize: 12, color: kWhite),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: kGreyDark,
                                      ),
                                      child: Column(
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.forumbee,
                                            color: kWhite,
                                            size: 14,
                                          ),
                                          Text(
                                            'Menyengat',
                                            style: GoogleFonts.poppins(
                                                fontSize: 12, color: kWhite),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: kGreyDark,
                                      ),
                                      child: Column(
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.octopusDeploy,
                                            color: kWhite,
                                            size: 14,
                                          ),
                                          Text(
                                            'Menyembur',
                                            style: GoogleFonts.poppins(
                                                fontSize: 12, color: kWhite),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text('Description'),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Positioned(
                    bottom: 24,
                    left: (MediaQuery.of(context).size.width - 200) / 2,
                    child: InkWell(
                      onTap: () {
                        provider.startDetect(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 60,
                        width: 200,
                        decoration: BoxDecoration(
                          color: kGreen,
                          border: Border.all(width: 1, color: kWhite),
                          borderRadius: BorderRadius.circular(80),
                        ),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Positioned(
                              left: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: Icon(
                                  Icons.keyboard_arrow_right_outlined,
                                  size: 28,
                                  color: kGreen,
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Text(
                                  "Start Detect",
                                  style: GoogleFonts.poppins(
                                      color: kWhite,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
            Positioned(
              top: 18,
              left: 18,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kGreyDark,
                    border: Border.all(width: 1, color: kWhite),
                  ),
                  child: Center(
                      child: Icon(
                    Icons.close,
                    color: kWhite,
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String animalClassEncode(int objectDetectedClass) {
    switch (objectDetectedClass) {
      case 0:
        return 'any_other_kind_of_starfish';
      case 1:
        return 'blue_ringed_octopus';
      case 2:
        return 'crown_of_thorns_starfish';
      default:
        return 'unknown';
    }
  }
}
