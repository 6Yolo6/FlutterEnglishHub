import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FavorDailySentence extends StatefulWidget {
  const FavorDailySentence({super.key});
  @override
  _FavorDailySentenceState createState() => _FavorDailySentenceState();
}

class _FavorDailySentenceState extends State<FavorDailySentence> {
  
  List<Map<String, String>> dailySentences = [
    {
      'date': 'Apr 10',
      'sentence': 'When winter comes, can spring be far behind?',
      'translation': '冬天到了，春天还会远吗？',
      'imagePath': 'assets/images/spring.jpg',
    },
    {
      'date': 'Apr 28',
      'sentence': 'Energy and persistence conquer all things.',
      'translation': '能量和坚持可以征服一切。',
      'imagePath': 'assets/images/energy.jpg',
    },
    {
      'date': 'Apr 29',
      'sentence': 'Others wait for me to fall, but I want to be a blockbuster.',
      'translation': '别人等我一跤不挺，而我却想成为一部大片。',
      'imagePath': 'assets/images/blockbuster.jpg',
    },
    {
      'date': 'Apr 29',
      'sentence': 'Others wait for me to fall, but I want to be a blockbuster.',
      'translation': '别人等我一跤不挺，而我却想成为一部大片。',
      'imagePath': 'assets/images/blockbuster.jpg',
    },
    {
      'date': 'Apr 29',
      'sentence': 'Others wait for me to fall, but I want to be a blockbuster.',
      'translation': '别人等我一跤不挺，而我却想成为一部大片。',
      'imagePath': 'assets/images/blockbuster.jpg',
    },
    {
      'date': 'Apr 29',
      'sentence': 'Others wait for me to fall, but I want to be a blockbuster.',
      'translation': '别人等我一跤不挺，而我却想成为一部大片。',
      'imagePath': 'assets/images/blockbuster.jpg',
    },
    {
      'date': 'Apr 29',
      'sentence': 'Others wait for me to fall, but I want to be a blockbuster.',
      'translation': '别人等我一跤不挺，而我却想成为一部大片。',
      'imagePath': 'assets/images/blockbuster.jpg',
    },
    {
      'date': 'Apr 29',
      'sentence': 'Others wait for me to fall, but I want to be a blockbuster.',
      'translation': '别人等我一跤不挺，而我却想成为一部大片。',
      'imagePath': 'assets/images/blockbuster.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: dailySentences.length,
        itemBuilder: (context, index) {
          var item = dailySentences[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(item['imagePath']!),
              radius: 30.0,
            ),
            title: Text(
              item['sentence']!,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
            subtitle: Text(
              '${item['date']} - ${item['translation']}',
              style: TextStyle(fontSize: 14.sp),
            ),
          );
        },
      ),
    );
  }
}
