import 'package:danitor/domain/entities/animal_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../core/themes/color_const.dart';

class AnimalDetailPage extends StatelessWidget {
  final AnimalDetail animalDetail;
  const AnimalDetailPage({super.key, required this.animalDetail});

  get kGreen => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 65,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  Expanded(
                      child: Text(
                    animalDetail.name,
                    maxLines: 1,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      height: 1,
                      fontWeight: FontWeight.bold,
                      color: kGreen,
                    ),
                  )),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BuildTitle(title: 'Ancaman'),
                      Builder(builder: (context) {
                        return Text(
                          animalDetail.isDangerousLabel,
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: colorDanger[
                                  int.parse(animalDetail.isDangerousId)]),
                        );
                      }),
                      Text(animalDetail.isDangerousDescription,
                          style: GoogleFonts.montserrat()),
                      const SizedBox(
                        height: 8,
                      ),
                      const BuildTitle(title: 'Racun'),
                      Builder(builder: (context) {
                        return Text(
                          animalDetail.isPoisonousLabel,
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: colorPoison[
                                  int.parse(animalDetail.isPoisonousId)]),
                        );
                      }),
                      Text(animalDetail.isPoisonousDescription,
                          style: GoogleFonts.montserrat()),
                      const SizedBox(
                        height: 8,
                      ),
                      const BuildTitle(title: 'Detail'),
                      Text(animalDetail.animalDescription,
                          style: GoogleFonts.montserrat()),
                      const SizedBox(
                        height: 8,
                      ),
                      const BuildTitle(title: 'Sumber Informasi'),
                      Text(
                          animalDetail.informationSource.substring(
                              1, animalDetail.informationSource.length - 1),
                          style: GoogleFonts.montserrat()),
                      const SizedBox(
                        height: 2,
                      ),
                      InkWell(
                        onTap: () async {
                          final String url = animalDetail.webviewLink;
                          if (await canLaunchUrlString(url)) {
                            await launchUrlString(url);
                          } else {
                            throw "Could not launch $url";
                          }
                        },
                        child: Text(
                          'Telusuri Detail',
                          style: GoogleFonts.poppins(color: Colors.blue),
                        ),
                      )
                    ],
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

class BuildTitle extends StatelessWidget {
  final String title;
  const BuildTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
            height: 10,
            width: 4,
            color: kGreen,
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                  fontSize: 15, color: kGreen, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
