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
      imagePath: 'assets/hotel/hotel_1.png',
      routeName: Routes.listening,
    ),
    HomeList(
      imagePath: 'assets/hotel/hotel_2.png',
      routeName: Routes.reading,
    ),
    HomeList(
      imagePath: 'assets/hotel/hotel_3.png',
      routeName: Routes.writing,
    ),
    HomeList(
      imagePath: 'assets/hotel/hotel_3.png',
      routeName: Routes.writing,
    ),
    HomeList(
      imagePath: 'assets/hotel/hotel_3.png',
      routeName: Routes.writing,
    ),
    HomeList(
      imagePath: 'assets/hotel/hotel_3.png',
      routeName: Routes.writing,
    ),
    HomeList(
      imagePath: 'assets/hotel/writing.png',
      routeName: Routes.writing,
    ),
    HomeList(
      imagePath: 'assets/hotel/writing.png',
      routeName: Routes.writing,
    ),
    HomeList(
      imagePath: 'assets/hotel/hotel_3.png',
      routeName: Routes.writing,
    ),
    HomeList(
      imagePath: 'assets/hotel/writing.png',
      routeName: Routes.writing,
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
