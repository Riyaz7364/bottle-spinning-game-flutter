// import 'dart:ffi';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// // import 'package:google_mobile_ads/google_mobile_ads.dart';

// class AdsController extends GetxController {
//   final bool enableAds = true;

//   // final bannerAd = <BannerAd>[].obs;
//   // final interstitialAd = <InterstitialAd>[].obs;
//   // final nativeAd = <NativeAd>[].obs;

//   final adBannerId = 'ca-app-pub-3940256099942544/6300978111';
//   final adInterstitialId = 'ca-app-pub-3940256099942544/1033173712';
//   final adAppOpen = 'ca-app-pub-3940256099942544/9257395921';
//   final adNative = 'ca-app-pub-3940256099942544/3986624511';

//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     loadBannerAd();
//     loadInterstitialAd();
//     showAdIfAvailable();
//     loadNativeAd();
//     final app = AppLifecycleReactor(appOpenAdManager: AdsController());
//     app.listenToAppStateChanges();
//   }

//   final isNativeAdReady = false.obs;

//   // TODO: replace this test ad unit with your own ad unit.

//   /// Loads a native ad.
//   void loadNativeAd() {
//     nativeAd.value = [
//       NativeAd(
//           adUnitId: adNative,
//           listener: NativeAdListener(
//             onAdLoaded: (ad) {
//               print('$NativeAd loaded.');
//               isNativeAdReady.value = true;
//             },
//             onAdFailedToLoad: (ad, error) {
//               // Dispose the ad here to free resources.
//               debugPrint('$NativeAd failed to load: $error');
//               ad.dispose();
//             },
//           ),
//           request: const AdRequest(),
//           // Styling
//           nativeTemplateStyle: NativeTemplateStyle(
//               // Required: Choose a template.
//               templateType: TemplateType.medium,
//               // Optional: Customize the ad's style.
//               mainBackgroundColor: Colors.purple,
//               cornerRadius: 10.0,
//               callToActionTextStyle: NativeTemplateTextStyle(
//                   textColor: Colors.cyan,
//                   backgroundColor: Colors.red,
//                   style: NativeTemplateFontStyle.monospace,
//                   size: 16.0),
//               primaryTextStyle: NativeTemplateTextStyle(
//                   textColor: Colors.red,
//                   backgroundColor: Colors.cyan,
//                   style: NativeTemplateFontStyle.italic,
//                   size: 16.0),
//               secondaryTextStyle: NativeTemplateTextStyle(
//                   textColor: Colors.green,
//                   backgroundColor: Colors.black,
//                   style: NativeTemplateFontStyle.bold,
//                   size: 16.0),
//               tertiaryTextStyle: NativeTemplateTextStyle(
//                   textColor: Colors.brown,
//                   backgroundColor: Colors.amber,
//                   style: NativeTemplateFontStyle.normal,
//                   size: 16.0)))
//         ..load()
//     ];
//   }

//   /// Loads a banner ad.
//   Future<void> loadBannerAd() async {
//     if (bannerAd.isNotEmpty) {
//       bannerAd.first.dispose();
//     }
//     bannerAd.value = [
//       BannerAd(
//         adUnitId: adBannerId,
//         request: const AdRequest(),
//         size: AdSize.banner,
//         listener: BannerAdListener(
//           // Called when an ad is successfully received.
//           onAdLoaded: (ad) {
//             print('$ad loaded.');
//           },
//           // Called when an ad request failed.
//           onAdFailedToLoad: (ad, err) {
//             print('BannerAd failed to load: $err');
//             // Dispose the ad here to free resources.
//             ad.dispose();
//           },
//         ),
//       )..load()
//     ];
//   }

//   /// Loads an interstitial ad.
//   void loadInterstitialAd() {
//     InterstitialAd.load(
//         adUnitId: adInterstitialId,
//         request: const AdRequest(),
//         adLoadCallback: InterstitialAdLoadCallback(
//           // Called when an ad is successfully received.
//           onAdLoaded: (ad) {
//             print('$ad loaded.');
//             // Keep a reference to the ad so you can show it later.
//             interstitialAd.value = [ad];
//           },
//           // Called when an ad request failed.
//           onAdFailedToLoad: (LoadAdError error) {
//             print('InterstitialAd failed to load: $error');
//           },
//         ));
//   }

//   AppOpenAd? _appOpenAd;
//   bool _isShowingAd = false;

//   void showAdIfAvailable() {
//     if (!isAdAvailable) {
//       print('Tried to show ad before available.');
//       loadAd();
//       return;
//     }
//     if (_isShowingAd) {
//       print('Tried to show ad while already showing an ad.');
//       return;
//     }
//     // Set the fullScreenContentCallback and show the ad.
//     _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (ad) {
//         _isShowingAd = true;
//         print('$ad onAdShowedFullScreenContent');
//       },
//       onAdFailedToShowFullScreenContent: (ad, error) {
//         print('$ad onAdFailedToShowFullScreenContent: $error');
//         _isShowingAd = false;
//         ad.dispose();
//         _appOpenAd = null;
//       },
//       onAdDismissedFullScreenContent: (ad) {
//         print('$ad onAdDismissedFullScreenContent');
//         _isShowingAd = false;
//         ad.dispose();
//         _appOpenAd = null;
//         loadAd();
//       },
//     );
//   }

//   /// Load an AppOpenAd.
//   void loadAd() {
//     AppOpenAd.load(
//       adUnitId: adAppOpen,
//       request: const AdRequest(),
//       adLoadCallback: AppOpenAdLoadCallback(
//         onAdLoaded: (ad) {
//           _appOpenAd = ad;
//         },
//         onAdFailedToLoad: (error) {
//           print('AppOpenAd failed to load: $error');
//           // Handle the error.
//         },
//       ),
//     );
//   }

//   /// Whether an ad is available to be shown.
//   bool get isAdAvailable {
//     return _appOpenAd != null;
//   }
// }

// /// Listens for app foreground events and shows app open ads.
// class AppLifecycleReactor {
//   final AdsController appOpenAdManager;

//   AppLifecycleReactor({required this.appOpenAdManager});

//   void listenToAppStateChanges() {
//     AppStateEventNotifier.startListening();
//     AppStateEventNotifier.appStateStream
//         .forEach((state) => _onAppStateChanged(state));
//   }

//   void _onAppStateChanged(AppState appState) {
//     // Try to show an app open ad if the app is being resumed and
//     // we're not already showing an app open ad.
//     if (appState == AppState.foreground) {
//       appOpenAdManager.showAdIfAvailable();
//     }
//   }
// }
