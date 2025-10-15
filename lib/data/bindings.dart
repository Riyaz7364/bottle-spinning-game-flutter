import 'package:get/get.dart';
import '/data/Controllers/ads_controller.dart';
import '/data/Controllers/settings_controller.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<AdsController>(() => AdsController(), fenix: true);
    Get.lazyPut<SettingsController>(() => SettingsController(), fenix: true);
  }
}
