import 'package:get_it/get_it.dart';

import 'presentations/providers/detection_helper_notifier.dart';
import 'presentations/providers/navbar_ notifier.dart';
import 'presentations/providers/target_image_notifier.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(() => NavbarNotifier());
  locator.registerFactory(() => TargetImageNotifier());
  locator.registerFactory(() => DetectionHelperNotifier());
}
