import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/themes/color_const.dart';

class SharingPage extends StatelessWidget {
  const SharingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
            'Berbagi Informasi',
            style: GoogleFonts.poppins(
                fontSize: 18, color: kGreen, fontWeight: FontWeight.w700),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: 4,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(bottom: 8),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Color(0xFFDBDBDB),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'username',
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: kGreyDark,
                            fontWeight: FontWeight.w700),
                        children: [
                          TextSpan(text: ' • '),
                          TextSpan(
                            text: '27 Agustus 2022',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Color(0xFF989EAC),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: kGreen,
                          size: 14,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text('Denpasar, Bali',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: kGreyDark,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: [
                          Image.network(
                            'https://www.zubludiving.com/images/Mabul-blueringed-octopus-banner.jpg',
                            width: MediaQuery.of(context).size.width,
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 8,
                            left: 8,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: kGreyDark,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Blue Ring Octopus',
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
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                          'Halo, guys hati-hati kalau lewat daerah pekalongan tadi aku nemu hewan ini bahaya'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
