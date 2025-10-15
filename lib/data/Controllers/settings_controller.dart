import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final soundMute = true.obs;

  final shareText = '''
🎉 Ready to take your parties to the next level? 🎉

Download Spin the Bottle - the ultimate party game app! Get everyone laughing, bonding, and having a blast with a classic game revamped for the digital age.

🔄 Spin the Bottle is perfect for:
House parties
Sleepovers
Family gatherings
Fun with friends
📲 Download now and get the party started!

Available on Google Play: https://play.google.com/store/apps/details?id=com.spinthebottle.game

🔥 Features:
Easy-to-use interface
Fun and engaging challenges
Customizable game modes
Play with an unlimited number of friends
Don't miss out on the fun! Share with your friends and start spinning the bottle today!
  ''';

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playSound(String name) async {
    if (!soundMute.value) {
      await _audioPlayer.play(AssetSource('sounds/$name'));
    }
  }

  void toggleMute() {
    soundMute.value = !soundMute.value;
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}
