import 'package:flutter/material.dart';

import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import '/data/bindings.dart';

import '/data/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      // home: Roulette(),
      initialRoute: Routes.INITIAL,
      getPages: Routes.pages,
      initialBinding: InitBinding(),
    );
  }
}
