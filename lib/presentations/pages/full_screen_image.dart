import 'dart:io';
import 'dart:ui';
import 'package:danitor/core/routes/route_names.dart';
import 'package:danitor/core/themes/color_const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              ),
            ),
            Positioned(
              bottom: 24,
              left: (MediaQuery.of(context).size.width - 200) / 2,
              child: InkWell(
                onTap: () async {
                  Navigator.pushReplacementNamed(
                    context,
                    RESULT_DETECTION_ROUTE_NAME,
                    arguments: widget.fileImage,
                  );
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
                              shape: BoxShape.circle, color: Colors.white),
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
                            "Mulai Deteksi",
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
}
