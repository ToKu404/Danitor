// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:danitor/domain/entities/animal_detail.dart';
import 'package:danitor/domain/entities/bounding_box.dart';
import 'package:danitor/domain/entities/detection.dart';
import 'package:danitor/presentations/providers/danitor_notifier.dart';
import 'package:danitor/presentations/providers/detail_provider_notifier.dart';
import 'package:danitor/presentations/providers/detection_result_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../core/themes/color_const.dart';

class HelperSection {
  final File fileImage;
  final List<int> filters;

  HelperSection({required this.fileImage, required this.filters});
}

class ResultDetectionPage extends StatefulWidget {
  final HelperSection helper;
  const ResultDetectionPage({Key? key, required this.helper}) : super(key: key);

  @override
  State<ResultDetectionPage> createState() => ResultDetectionPageState();
}

class ResultDetectionPageState extends State<ResultDetectionPage> {
  double imageWidth = 0;
  double imageHeight = 0;
  @override
  void initState() {
    Future.microtask(() {
      Provider.of<DanitorNotifier>(context, listen: false).startDetection(
          base64Encode(widget.helper.fileImage.readAsBytesSync()),
          widget.helper.filters);
      Provider.of<DetectionResultHelper>(context, listen: false)
          .changeResultIndex(0);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });

    super.initState();
  }

  void _asyncMethod() async {
    var decodedImage =
        await decodeImageFromList(widget.helper.fileImage.readAsBytesSync());
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    imageWidth = decodedImage.width.toDouble();
    imageHeight = decodedImage.height.toDouble();

    imageHeight = screenWidth * imageHeight / imageWidth;
    imageWidth = screenWidth;

    if (imageHeight > (screenHeight - 130)) {
      double temp = imageHeight;
      imageHeight = screenHeight - 180;
      imageWidth = imageHeight * imageWidth / temp;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOnPrimary,
      body: SafeArea(
        child: Consumer<DanitorNotifier>(builder: (context, data, _) {
          if (data.detectionState == RequestState.loading) {
            return Center(
              child: CircularProgressIndicator(
                color: kGreen,
              ),
            );
          } else if (data.detectionState == RequestState.error) {
            return Center(
              child: Text(data.message),
            );
          } else if (data.detectionState == RequestState.success) {
            if (data.detecetion.status == 'failed') {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/empty.svg',
                        width: 200,
                        height: 200,
                      ),
                      Text(
                        'Data Hewan Belum Ada Di Database atau Tidak Ada Hewan Berbahaya Yang Terdeteksi',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(fontSize: 18, color: kWhite),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                        child: Container(
                          width: 250,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: kGreen,
                              borderRadius: BorderRadius.circular(16)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.home,
                                color: kWhite,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                'Kembali ke halaman awal',
                                style: GoogleFonts.poppins(color: kWhite),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return BuildDetailBody(
              imageWidth: imageWidth,
              imageHeight: imageHeight,
              detection: data.detecetion,
              fileImage: widget.helper.fileImage,
            );
          } else {
            return const Center();
          }
        }),
      ),
    );
  }
}

class BuildDetailBody extends StatefulWidget {
  const BuildDetailBody({
    Key? key,
    required this.imageWidth,
    required this.imageHeight,
    required this.detection,
    required this.fileImage,
  }) : super(key: key);

  final double imageWidth;
  final double imageHeight;
  final Detection detection;
  final File fileImage;

  @override
  State<BuildDetailBody> createState() => _BuildDetailBodyState();
}

class _BuildDetailBodyState extends State<BuildDetailBody> {
  @override
  void initState() {
    final List<int> listIndex = [];
    for (var e in widget.detection.objectDetected) {
      if (!listIndex.contains(e.objectDetectedClass)) {
        listIndex.add(e.objectDetectedClass);
      }
    }
    String idx = '';
    for (int i = 0; i < listIndex.length; i++) {
      idx += '${listIndex[i]}';
      if (i < listIndex.length - 1) {
        idx += '-';
      }
    }
    Future.microtask(() {
      Provider.of<DetailProviderNotifier>(context, listen: false)
          .getDetails(idx);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailProviderNotifier>(
      builder: (context, detailState, _) {
        if (detailState.detectionState == RequestState.loading) {
          return Center(
            child: CircularProgressIndicator(color: kGreen),
          );
        } else if (detailState.detectionState == RequestState.error) {
          return Text(detailState.message);
        } else if (detailState.detectionState == RequestState.success) {
          final provider = context.watch<DetectionResultHelper>();
          int currentIndex = provider.resultIndex;
          final detail = detailState.listAnimalDetail
              .where((element) =>
                  element.id ==
                  widget.detection.objectDetected[currentIndex]
                      .objectDetectedClass
                      .toString())
              .first;
          return Column(
            children: [
              Container(
                height: 65,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: kGreyDark),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      icon: Icon(
                        Icons.home,
                        color: kWhite,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            color: kGreySoft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Container(
                                    width: widget.imageWidth,
                                    height: widget.imageHeight,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(
                                          widget.fileImage,
                                        ),
                                      ),
                                    ),
                                    child: Builder(builder: (context) {
                                      return BuildBoundingBox(
                                        imageHeight: widget.imageHeight,
                                        imageWidth: widget.imageWidth,
                                        boundingBox: widget
                                            .detection
                                            .objectDetected[currentIndex]
                                            .boundingBox,
                                        confidence: widget
                                            .detection
                                            .objectDetected[currentIndex]
                                            .confidence,
                                        colorBounderies: colorDanger[
                                            int.parse(detail.isDangerousId)],
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 65,
                        ),
                      ],
                    ),
                    BuildDetail(
                      resultLength: widget.detection.objectDetected.length,
                      animalDetail: detail,
                      // animalDetail: detail,
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const Center();
        }
      },
    );
  }
}

class BuildBoundingBox extends StatelessWidget {
  final BoundingBox boundingBox;
  final double imageWidth;
  final double imageHeight;
  final double confidence;
  final Color colorBounderies;
  const BuildBoundingBox({
    super.key,
    required this.boundingBox,
    required this.imageHeight,
    required this.imageWidth,
    required this.confidence,
    required this.colorBounderies,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Stack(
        children: [
          Positioned(
            top: boundingBox.ymin * imageHeight - 20,
            left: boundingBox.xmin * imageWidth,
            child: Text(
              '${(confidence * 100).toStringAsFixed(2)}%',
              style: GoogleFonts.poppins(
                color: colorBounderies,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                      color: kGreyDark,
                      blurRadius: .1,
                      offset: const Offset(0, 0))
                ],
                fontSize: 12,
              ),
            ),
          ),
          Positioned(
            top: boundingBox.ymin * imageHeight,
            left: boundingBox.xmin * imageWidth,
            child: Container(
              width: (boundingBox.xmax * imageWidth) -
                  (boundingBox.xmin * imageWidth),
              height: (boundingBox.ymax * imageHeight) -
                  (boundingBox.ymin * imageHeight),
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: colorBounderies)),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildDetail extends StatelessWidget {
  final int resultLength;
  final AnimalDetail animalDetail;
  const BuildDetail({
    super.key,
    required this.resultLength,
    required this.animalDetail,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DetectionResultHelper>();
    int currentIndex = provider.resultIndex;
    return DraggableScrollableSheet(
      initialChildSize: 0.30,
      minChildSize: 0.11,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
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
                    currentIndex > 0
                        ? InkWell(
                            onTap: () {
                              currentIndex--;
                              provider.changeResultIndex(currentIndex);
                            },
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.arrow_back_rounded),
                            ),
                          )
                        : const SizedBox(
                            width: 32,
                            height: 32,
                          ),
                    const SizedBox(
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
                    const SizedBox(
                      width: 4,
                    ),
                    currentIndex < resultLength - 1
                        ? InkWell(
                            onTap: (() {
                              currentIndex++;
                              provider.changeResultIndex(currentIndex);
                            }),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.arrow_forward_rounded),
                            ),
                          )
                        : const SizedBox(
                            width: 32,
                            height: 32,
                          ),
                  ],
                ),
                const Divider(),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - (16 * 2),
                  child: Text(
                    animalDetail.name,
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
                const SizedBox(
                  height: 8,
                ),
                const BuildTitle(title: 'Ancaman'),
                Builder(builder: (context) {
                  return Text(
                    animalDetail.isDangerousLabel,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color:
                            colorDanger[int.parse(animalDetail.isDangerousId)]),
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
                        color:
                            colorPoison[int.parse(animalDetail.isPoisonousId)]),
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
        );
      },
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
