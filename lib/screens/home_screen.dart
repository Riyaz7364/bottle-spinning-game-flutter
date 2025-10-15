import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';
import '/data/Controllers/settings_controller.dart';
import '/data/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final settings = Get.find<SettingsController>();
  late AnimationController _buttonController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.0,
      upperBound: 0.1,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(_buttonController);
  }

  void _onTapDown(_) => _buttonController.forward();
  void _onTapUp(_) => _buttonController.reverse();

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final random = Random();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffFFD1FF), Color(0xffC8F4FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Floating sparkles / fun particles
              ...List.generate(8, (i) {
                final left =
                    random.nextDouble() * MediaQuery.of(context).size.width;
                final top = random.nextDouble() * 400;
                final size = random.nextDouble() * 12 + 8;
                final color = Colors
                    .primaries[random.nextInt(Colors.primaries.length)]
                    .withOpacity(0.6);
                return Positioned(
                  left: left,
                  top: top,
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.7),
                          blurRadius: 6,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                );
              }),
              Column(
                children: [
                  const SizedBox(height: 50),
                  Image.asset('assets/images/logo.png', height: 100),
                  const SizedBox(height: 80),
                  GestureDetector(
                    onTapDown: _onTapDown,
                    onTapUp: _onTapUp,
                    onTap: () {
                      settings.playSound('click.wav');
                      Get.toNamed(Routes.addPlayerScreen);
                    },
                    child: AnimatedBuilder(
                      animation: _scaleAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.purpleAccent,
                                  Colors.deepPurple,
                                ],
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
                              "🎮 START GAME",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                                shadows: [
                                  Shadow(
                                    color: Colors.black38,
                                    blurRadius: 6,
                                    offset: Offset(1, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Obx(
                        () => IconButton(
                          onPressed: () {
                            settings.toggleMute();
                            settings.playSound('click.wav');
                          },
                          icon: Icon(
                            settings.soundMute.isFalse
                                ? Icons.volume_up
                                : Icons.volume_off,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.share,
                          size: 35,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          settings.playSound('click.wav');
                          Share.share(settings.shareText);
                        },
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 40, vertical: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
