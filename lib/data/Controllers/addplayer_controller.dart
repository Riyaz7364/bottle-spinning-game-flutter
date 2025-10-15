import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPlayerController extends GetxController {
  final playerList = <String>[].obs;
  final nameInput = TextEditingController();
  Future<void> addPlayer() async {
    playerList.add(nameInput.text);
    nameInput.clear();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
