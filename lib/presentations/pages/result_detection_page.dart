// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:danitor/core/routes/route_names.dart';
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
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(color: kGreyDark),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      icon: Icon(
                        Icons.close_rounded,
                        color: kWhite,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.share,
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
                        SizedBox(
                          height: 65,
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 12,
                      child: Builder(builder: (context) {
                        print(widget.detection.objectDetected.length);
                        return BuildDetail(
                          resultLength: widget.detection.objectDetected.length,
                          animalDetail: detail,
                          detection: widget.detection,
                          // animalDetail: detail,
                        );
                      }),
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
  final Detection detection;
  const BuildDetail({
    super.key,
    required this.detection,
    required this.resultLength,
    required this.animalDetail,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DetectionResultHelper>();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: PageView.builder(
        itemCount: resultLength,
        reverse: true,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index) {
          provider.changeResultIndex(index);
        },
        itemBuilder: (context, index) {
          final detect = detection.objectDetected[index];
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, ANIMAL_DETAIL_ROUTE_NAME,
                  arguments: animalDetail);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: 100,
              height: 75,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border:
                    Border.all(width: 1, color: Colors.grey.withOpacity(.7)),
                color: kWhite,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12), color: kGreen),
                    child: Center(
                      child: Text(
                        '${(detect.confidence * 100).toStringAsFixed(1)}%',
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: kWhite,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          animalDetail.name,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            height: 1.5,
                            color: kGreyDark,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${animalDetail.isDangerousLabel}',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: colorDanger[
                                    int.parse(animalDetail.isDangerousId)],
                                height: 1.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${animalDetail.isPoisonousLabel}',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: colorPoison[
                                    int.parse(animalDetail.isPoisonousId)],
                                height: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
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
