import 'dart:io';
import 'package:danitor/core/routes/route_names.dart';
import 'package:danitor/core/common/observer.dart';
import 'package:danitor/presentations/pages/home_page.dart';
import 'package:danitor/presentations/pages/result_detection_page.dart';
import 'package:danitor/presentations/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'injection.dart' as di;
import 'presentations/pages/full_screen_image.dart';
import 'presentations/providers/danitor_notifier.dart';
import 'presentations/providers/detail_provider_notifier.dart';
import 'presentations/providers/detection_result_helper.dart';
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
          create: (_) => di.locator<DanitorNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<DetectionResultHelper>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<DetailProviderNotifier>(),
        )
      ],
      child: MaterialApp(
        title: 'Danitor',
        navigatorObservers: [routeObserver],
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case SPLASH_ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (context) => const SplashScreen());
            case HOME_ROUTE_NAME:
              return MaterialPageRoute(builder: (context) => const HomePage());
            case FULL_SCREEN_IMAGE_ROUTE_NAME:
              final image = settings.arguments as File;
              return MaterialPageRoute(
                  builder: (context) => FullScreenImagePage(
                        fileImage: image,
                      ));
            case RESULT_DETECTION_ROUTE_NAME:
              final image = settings.arguments as File;
              return MaterialPageRoute(
                builder: (context) => ResultDetectionPage(fileImage: image),
              );
          }
        },
      ),
    );
  }
}
