import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_english_hub/page/daily_sentence/daily_sentence_list.dart';


class ListeningPage extends StatefulWidget {
  @override
  _ListeningPageState createState() => _ListeningPageState();
}

class _ListeningPageState extends State<ListeningPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DailySentenceList(),
    );
  }
}
