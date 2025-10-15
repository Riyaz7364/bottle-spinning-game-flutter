import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:bottel_spinner_game/plugin/src/spinning_wheel.dart';
import 'package:flatter/flatter.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';
import '/Widgets/circle_with_text.dart';
import '/data/Controllers/addplayer_controller.dart';
import '/data/Controllers/ads_controller.dart';
import '/data/Controllers/settings_controller.dart';

class WeelGameScreen extends StatefulWidget {
  const WeelGameScreen({super.key});

  @override
  State<WeelGameScreen> createState() => _RouletteState();
}

class _RouletteState extends State<WeelGameScreen> {
  final StreamController<int> _dividerController = StreamController<int>();
  final AddPlayerController controller = Get.find<AddPlayerController>();
  final StreamController<double> _wheelNotifier = StreamController<double>();
  // final adsController = Get.find<AdsController>();
  final settings = Get.find<SettingsController>();
  int? _currentDivider;
  bool _isSpinning = false;
  bool _isPointerUp = false;
  List<int> counterWeel = [];
  final player = AudioPlayer();
  var playerInt = -1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _dividerController.close();
    _wheelNotifier.close();
  }

  void _changeValue(int newValue) {
    if (playerInt != newValue) {
      if (playerInt != -1 && _isPointerUp) {
        if (settings.soundMute.isFalse) {
          AudioPlayer().play(AssetSource('sounds/pop-coke.wav'));
        }
      }
      playerInt = newValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFAFBF6),
        shadowColor: Colors.transparent,
        leading:
            Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: const Icon(Icons.arrow_back_ios_new),
            ).onTap(() {
              settings.playSound('click.wav');
              Get.back();
            }),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffFAFBF6), Color(0xfffD4FFE5)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo.png", scale: 2),
              Center().expand(),
              if (playerInt != -1)
                Text.rich(
                  TextSpan(
                    style: Get.textTheme.headlineMedium,
                    children: [
                      const TextSpan(text: "Its "),
                      TextSpan(
                        text: '${controller.playerList[playerInt - 1]}\'s ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: "Turn"),
                    ],
                  ),
                ),
              const Gap(10),
              Listener(
                onPointerDown: (event) {
                  _isPointerUp = false;
                  counterWeel.clear();
                },
                onPointerUp: (event) {
                  _isPointerUp = true;
                },
                child: SpinningWheel(
                  image: Image.asset('assets/images/bottle-8-300.png'),
                  width: 320,
                  height: 320,
                  initialSpinAngle: _generateRandomAngle(),
                  spinResistance: 0.6,
                  canInteractWhileSpinning: false,
                  dividers: controller.playerList.length,
                  onUpdate: (divider) {
                    if (!_isSpinning) {
                      _dividerController.add(divider);
                    }
                  },
                  onEnd: _handleWheelEnd,
                  secondaryImage: CustomPaint(
                    painter: TextCirclePainter(controller.playerList),
                  ),
                  secondaryImageHeight: 350,
                  secondaryImageWidth: 350,
                  shouldStartOrStop: _wheelNotifier.stream,
                ),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  _wheelNotifier.sink.add(_generateRandomVelocity());
                  _isPointerUp = true;
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.purpleAccent, Colors.deepPurple],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purpleAccent.withOpacity(0.6),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Text(
                    "🎯 SPIN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              StreamBuilder<int>(
                stream: _dividerController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _currentDivider = snapshot.data;

                    print('Current Divider: $_currentDivider');
                    _changeValue(snapshot.data as int);
                    if (_isPointerUp) counterWeel.add(1);
                    return const SizedBox(height: 100);
                  } else {
                    return Container();
                  }
                },
              ),
              // FutureBuilder(
              //   future: adsController.loadBannerAd(),
              //   builder: (context, snapshot) {
              //     return Container(
              //       margin: const EdgeInsets.only(top: 10),
              //       alignment: Alignment.bottomCenter,
              //       width: adsController.bannerAd.first.size.width.toDouble(),
              //       height: adsController.bannerAd.first.size.height.toDouble(),
              //       child: AdWidget(ad: adsController.bannerAd.first),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleWheelEnd(int divider) {
    if (counterWeel.length > controller.playerList.length * 3) {
      print('The wheel stopped at player: $_currentDivider');
      setState(() {
        playerInt = _currentDivider!;
      });
      // Get.toNamed(
      //   Routes.chooseScreen,
      //   parameters: {'name': controller.playerList[_currentDivider! - 1]},
      // );
    }
    _isSpinning = false;
    _dividerController.add(
      divider,
    ); // Update the divider controller with the final value
    // Here you can add any additional logic you need when the wheel stops
  }

  double _generateRandomVelocity() => (Random().nextDouble() * 8000) + 4000;

  double _generateRandomAngle() => Random().nextDouble() * pi * 2;
}
