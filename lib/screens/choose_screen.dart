import 'package:flatter/flatter.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/fontelico_icons.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final param = Get.parameters;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 33, 124, 243),
          shadowColor: Colors.transparent,
          title: const Text("Whoopsie!")
              .fontSize(30)
              .fontWeight(FontWeight.bold)
              .textColor(Colors.white),
          leading: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: const Icon(Icons.arrow_back_ios_new),
          ),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromARGB(255, 33, 124, 243),
                Color.fromARGB(255, 111, 62, 247)
              ])),
          child: Column(
            children: [
              const Gap(20),
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(
                  Fontelico.emo_wink,
                  size: 50,
                  color: Color.fromARGB(255, 33, 124, 243),
                ),
              ),
              const Gap(20),
              Text(
                "Its ${param['name']} turn",
                style: Get.textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(200),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(radiusCircular(10)))),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.black,
                      child: Icon(
                        Fontelico.emo_tongue,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Truth!",
                      style: Get.textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const Gap(23)
                  ],
                ).paddingVertical(value: 20),
              ).marginSymmetric(horizontal: 50),
              ListTile(
                leading: Icon(
                  FontAwesome5.random,
                  color: Colors.white,
                ),
                title: Text(
                  "Random",
                  style: Get.textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ).marginSymmetric(horizontal: Get.width * 0.3),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(radiusCircular(10)))),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Fontelico.emo_devil,
                        size: 25,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Dare!",
                      style: Get.textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const Gap(23)
                  ],
                ).paddingVertical(value: 20),
              ).marginSymmetric(horizontal: 50),
              const Gap(50),
              TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                  label: const Text('Forfeit Round').textColor(Colors.white))
            ],
          ),
        ));
  }
}
