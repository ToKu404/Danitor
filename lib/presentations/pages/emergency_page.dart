import 'package:danitor/core/themes/color_const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Butuh Bantuan?',
              style: GoogleFonts.poppins(
                fontSize: 24,
                height: 1.2,
                fontWeight: FontWeight.bold,
                color: kGreyDark,
              ),
            ),
            Text(
              'Geser tombol panggilan darurat dibawah',
              style: GoogleFonts.poppins(
                fontSize: 14,
                height: 1.2,
                color: kGreyDark,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            EmergencySwipeButton(),
          ],
        ),
      ),
    );
  }
}

class EmergencySwipeButton extends StatefulWidget {
  const EmergencySwipeButton({super.key});

  @override
  State<EmergencySwipeButton> createState() => _EmergencySwipeButtonState();
}

class _EmergencySwipeButtonState extends State<EmergencySwipeButton> {
  double _posX = 0.0;
  Color colorEmergency = kGreen;

  @override
  Widget build(BuildContext context) {
    final double buttonContainerWidth = MediaQuery.of(context).size.width / 2;
    final double buttonWidth = MediaQuery.of(context).size.width / 5;

    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Container(
        width: buttonContainerWidth,
        height: buttonWidth + 20,
        decoration: BoxDecoration(
          color: kGreyDark,
          border: Border.all(
            width: 2,
            color: colorEmergency,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Positioned(
              right: 50,
              child: Icon(Icons.arrow_forward_rounded,
                  color: kWhite.withOpacity(.75)),
            ),
            Positioned(
              left: _posX,
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (_posX >= buttonContainerWidth - buttonWidth - 30) {
                    launchUrlString("tel://+6285172065497");
                  }
                  _posX = 0;
                  colorEmergency = kGreen;

                  setState(() {});
                },
                onHorizontalDragUpdate: (details) {
                  final double delta = details.delta.dx;
                  if (_posX < buttonContainerWidth - buttonWidth - 26 &&
                      _posX >= 0) {
                    _posX = _posX + delta;
                  } else if (_posX >= buttonContainerWidth - buttonWidth - 30) {
                    colorEmergency = Color(0xFF962525);
                  }
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  width: buttonWidth,
                  height: buttonWidth,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: colorEmergency,
                  ),
                  child: Icon(
                    Icons.call,
                    size: 24,
                    color: kWhite,
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
