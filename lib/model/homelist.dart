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
      routeName: Routes.routes[5].name, 
    ),
    HomeList(
      imagePath: 'assets/reading.png',
      routeName: Routes.routes[6].name,
    ),
    HomeList(
      imagePath: 'assets/hotel/writing.png',
      routeName: Routes.routes[7].name,
    ),
    
  ];
}
