import 'package:danitor/core/routes/route_names.dart';
import 'package:danitor/core/common/observer.dart';
import 'package:danitor/presentations/pages/home_page.dart';
import 'package:danitor/presentations/pages/result_detection_page.dart';
import 'package:danitor/presentations/pages/select_destionation_page.dart';
import 'package:danitor/presentations/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'injection.dart' as di;
import 'presentations/pages/full_screen_image.dart';
import 'presentations/providers/danitor_notifier.dart';
import 'presentations/providers/detail_provider_notifier.dart';
import 'presentations/providers/detection_result_helper.dart';
import 'presentations/providers/get_info_location_notifier.dart';
import 'presentations/providers/select_location_handler.dart';
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
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SelectLocationHandler>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<GetInfoLocationNotifier>(),
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
            case DESTINATION_ROUTE_NAME:
              final isInit = settings.arguments as bool;
              return MaterialPageRoute(
                  builder: (context) => SelectDestinationPage(
                        isInit: isInit,
                      ));
            case HOME_ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (context) => HomePage(
                        id: id,
                      ));
            case FULL_SCREEN_IMAGE_ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (context) => const FullScreenImagePage());
            case RESULT_DETECTION_ROUTE_NAME:
              final helper = settings.arguments as HelperSection;
              return MaterialPageRoute(
                builder: (context) => ResultDetectionPage(helper: helper),
              );
          }
        },
      ),
    );
  }
}
