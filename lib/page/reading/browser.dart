import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BrowserPage extends StatelessWidget {
  final List<Map<String, String>> websites = [
    {"name": "WikiHow", "url": "https://www.wikihow.com", "icon": "assets/icons/wikihow.png"},
    {"name": "Buzzfeed", "url": "https://www.buzzfeed.com", "icon": "assets/icons/buzzfeed.png"},
    {"name": "CNN", "url": "https://www.cnn.com", "icon": "assets/icons/cnn.png"},
    {"name": "Wikipedia", "url": "https://www.wikipedia.org", "icon": "assets/icons/wikipedia.png"},
    {"name": "BBC", "url": "https://www.bbc.com", "icon": "assets/icons/bbc.png"},
    {"name": "Huffingtonpost", "url": "https://www.huffpost.com", "icon": "assets/icons/huffingtonpost.png"},
    {"name": "EW", "url": "https://ew.com", "icon": "assets/icons/ew.png"},
    {"name": "The Street", "url": "https://www.thestreet.com", "icon": "assets/icons/thestreet.png"},
    {"name": "Today Online", "url": "https://www.todayonline.com", "icon": "assets/icons/todayonline.png"},
    {"name": "The Onion", "url": "https://www.theonion.com", "icon": "assets/icons/theonion.png"},
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('取词浏览器'),
      ),
      body: ListView.builder(
        itemCount: websites.length,
        itemBuilder: (context, index) {
          final website = websites[index];
          return ListTile(
            leading: Image.asset(
              website['icon']!,
              width: 40,
              height: 40,
            ),
            title: Text(website['name']!),
            onTap: () async {
              final url = website['url']!;
              if (await canLaunch(url)) {
                await launch(url, forceSafariVC: true, forceWebView: true);
              } else {
                throw 'Could not launch $url';
              }
            },
          );
        },
      ),
    );
  }
}
