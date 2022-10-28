import 'package:danitor/core/routes/route_names.dart';
import 'package:danitor/core/themes/color_const.dart';
import 'package:danitor/presentations/providers/select_location_handler.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelectDestinationPage extends StatefulWidget {
  final bool isInit;
  const SelectDestinationPage({super.key, required this.isInit});

  @override
  State<SelectDestinationPage> createState() => _SelectDestinationPageState();
}

class _SelectDestinationPageState extends State<SelectDestinationPage> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SelectLocationHandler>();

    return Scaffold(
      backgroundColor: kGreyDark,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
              child: widget.isInit
                  ? Container()
                  : InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.only(left: 12),
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
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Pilih destinasi wisata',
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: kWhite,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextField(
                        style: GoogleFonts.poppins(
                          color: kWhite,
                        ),
                        autofocus: false,
                        onChanged: (c) {
                          c.isEmpty
                              ? provider.clearDestionation()
                              : provider.changePrefixLocation(c);
                        },
                        controller: controller,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(width: 2, color: kWhite),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 2, color: kGreen),
                          ),
                          focusColor: kGreen,
                          hintText: 'Pilih lokasi',
                          hintStyle: GoogleFonts.poppins(
                            color: kWhite.withOpacity(.7),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 120,
                        child: provider.locationResult.isNotEmpty
                            ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount:
                                    provider.locationResult.length >= 2 ? 2 : 1,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      controller.text =
                                          provider.locationResult[index];
                                      provider.clearDestionation();
                                    },
                                    child: Container(
                                      height: 45,
                                      margin: EdgeInsets.only(bottom: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border:
                                            Border.all(width: 1, color: kGreen),
                                      ),
                                      child: Center(
                                        child: Text(
                                          provider.locationResult[index],
                                          style: GoogleFonts.poppins(
                                            color: kWhite,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                })
                            : Container(),
                      ),
                      InkWell(
                        onTap: () async {
                          provider.setIdLocation(controller.text);
                          Navigator.pushNamedAndRemoveUntil(
                              context, WRAPPER_ROUTE_NAME, (route) => false,
                              arguments: provider.idLocation);
                        },
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 2, color: kWhite),
                            color: kGreen,
                          ),
                          child: Icon(
                            Icons.check,
                            color: kWhite,
                          ),
                        ),
                      ),
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
