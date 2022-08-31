// import 'dart:ui';
// import 'package:danitor/core/routes/route_names.dart';
// import 'package:danitor/core/themes/color_const.dart';
// import 'package:flutter/material.dart';

// Future<void> showDetailEntity({
//   required BuildContext context,
//   required Image entity,
//   required void Function() onRefresh,
// }) async {
//   await Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => const ResultDetectionPage(),
//       settings: RouteSettings(
//         arguments: {
//           'entity': entity,
//           'onRefresh': onRefresh,
//         },
//         name: RESULT_DETECTION_ROUTE_NAME,
//       ),
//     ),
//   );
// }

// class ResultDetectionPage extends StatefulWidget {
//   const ResultDetectionPage({Key? key}) : super(key: key);

//   @override
//   State<ResultDetectionPage> createState() => _ResultDetectionPageState();
// }

// class _ResultDetectionPageState extends State<ResultDetectionPage> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                 image: FileImage(widget.fileImage),
//                 fit: BoxFit.cover,
//               )),
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
//                 child: Container(
//                   decoration:
//                       BoxDecoration(color: Colors.white.withOpacity(0.0)),
//                 ),
//               ),
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: FileImage(widget.fileImage),
//                 ),
//               ),
//             ),
//             Positioned(
//                 top: 18,
//                 left: 18,
//                 child: InkWell(
//                   onTap: () => Navigator.pop(context),
//                   child: Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: kGreyDark,
//                       border: Border.all(width: 1, color: kWhite),
//                     ),
//                     child: Center(
//                         child: Icon(
//                       Icons.home,
//                       color: kWhite,
//                     )),
//                   ),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
