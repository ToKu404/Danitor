import 'dart:io';

import 'package:danitor/core/routes/route_names.dart';
import 'package:danitor/core/utils/observer.dart';
import 'package:danitor/presentations/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'injection.dart' as di;
import 'presentations/pages/full_screen_image.dart';
import 'presentations/providers/detection_helper_notifier.dart';
import 'presentations/providers/navbar_ notifier.dart';
import 'presentations/providers/target_image_notifier.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<NavbarNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TargetImageNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<DetectionHelperNotifier>(),
        )
      ],
      child: MaterialApp(
        title: 'Danitor',
        navigatorObservers: [routeObserver],
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HOME_ROUTE_NAME:
              return MaterialPageRoute(builder: (context) => HomePage());
            case FULL_SCREEN_IMAGE_ROUTE_NAME:
              final image = settings.arguments as File;
              return MaterialPageRoute(
                  builder: (context) => FullScreenImagePage(
                        fileImage: image,
                      ));
          }
        },
      ),
    );
  }
}
