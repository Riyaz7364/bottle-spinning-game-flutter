import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:nb_utils/nb_utils.dart';
import '/Widgets/menu_button.dart';
import '/data/Controllers/addplayer_controller.dart';
import '/data/routes.dart';
import '/data/Controllers/settings_controller.dart';

class AddPlayerScreen extends StatefulWidget {
  const AddPlayerScreen({super.key});

  @override
  State<AddPlayerScreen> createState() => _AddPlayerScreenState();
}

class _AddPlayerScreenState extends State<AddPlayerScreen>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(AddPlayerController());
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue.shade300, Colors.blue.shade800],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Floating colorful circles for fun
              ...List.generate(12, (i) {
                final left =
                    random.nextDouble() * MediaQuery.of(context).size.width;
                final top = random.nextDouble() * 400;
                final size = random.nextDouble() * 15 + 10;
                final color = Colors
                    .primaries[random.nextInt(Colors.primaries.length)]
                    .withOpacity(0.5);
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
                          color: color.withOpacity(0.6),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                );
              }),
              Column(
                children: [
                  const Gap(20),
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new),
                          onPressed: () {
                            settings.playSound('click.wav');
                            Get.back();
                          },
                        ),
                      ),
                      const Gap(20),
                      const Text(
                        "Add Players",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 20),
                  const Gap(20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.nameInput,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                          decoration: InputDecoration(
                            hintText: "Player Name",
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const Gap(10),
                      GestureDetector(
                        onTapDown: _onTapDown,
                        onTapUp: _onTapUp,
                        onTap: () {
                          settings.playSound('click.wav');
                          if (controller.nameInput.text.isNotEmpty) {
                            if (!controller.playerList.contains(
                              controller.nameInput.text,
                            )) {
                              controller.addPlayer();
                            } else {
                              toast("Player name already exists!");
                            }
                          }
                        },
                        child: AnimatedBuilder(
                          animation: _scaleAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _scaleAnimation.value,
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: const Icon(Icons.add, size: 35),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 20),
                  const Gap(20),
                  Obx(
                    () => controller.playerList.isEmpty
                        ? const Center(
                            child: Text(
                              "No players added yet",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: controller.playerList.length,
                            itemBuilder: (context, index) {
                              final player = controller.playerList[index];
                              return Card(
                                color: Colors.white.withOpacity(0.9),
                                margin: const EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ListTile(
                                  title: Text(
                                    player,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ).paddingOnly(left: 10),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                      size: 28,
                                    ),
                                    onPressed: () {
                                      controller.playerList.removeAt(index);
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                  ).expand(),
                  const Gap(20),
                  GestureDetector(
                    onTapDown: _onTapDown,
                    onTapUp: _onTapUp,
                    onTap: () {
                      settings.playSound('click.wav');
                      if (controller.playerList.length < 2) {
                        toast("Minimum 2 players required");
                        return;
                      }
                      Get.toNamed(Routes.weelGameScreen);
                    },
                    child: AnimatedBuilder(
                      animation: _scaleAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Container(
                            width: 300,
                            height: 80,
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
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                "🎮 LET'S BEGIN!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black38,
                                      blurRadius: 4,
                                      offset: Offset(1, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Gap(30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
