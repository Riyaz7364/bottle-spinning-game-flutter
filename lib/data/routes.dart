import 'package:get/get.dart';
import '/screens/choose_screen.dart';
import '/screens/home_screen.dart';
import '/screens/select_player_screen.dart';
import '/screens/weel_game_screen.dart';

class Routes {
  static const INITIAL = '/';
  static const addPlayerScreen = '/selectPlayerScreen';
  static const weelGameScreen = '/weelGameScreen';
  static const chooseScreen = '/chooseScreen';

  static List<GetPage> pages = [
    GetPage(name: INITIAL, page: () => const HomeScreen()),
    GetPage(name: addPlayerScreen, page: () => AddPlayerScreen()),
    GetPage(name: weelGameScreen, page: () => WeelGameScreen()),
    GetPage(name: chooseScreen, page: () => ChooseScreen()),
  ];
}
