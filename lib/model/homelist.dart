import 'package:flutter_english_hub/router/router.dart';

class HomeList {
  HomeList({
    this.routeName = '',
    this.imagePath = '',
  });

  String routeName;
  String imagePath;

  static List<HomeList> homeList = [
    HomeList(
      imagePath: 'assets/listening.png',
      routeName: Routes.listening,
    ),
    HomeList(
      imagePath: 'assets/reading.png',
      routeName: Routes.reading,
    ),
    HomeList(
      imagePath: 'assets/hotel/writing.png',
      routeName: Routes.writing,
    ),
    HomeList(
      imagePath: 'assets/hotel/writing.png',
      routeName: Routes.writing,
    ),
  ];
}
