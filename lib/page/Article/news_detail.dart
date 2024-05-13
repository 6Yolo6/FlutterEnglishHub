import 'package:flutter/material.dart';

class NewsDetailPage extends StatefulWidget {
  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  bool isFavorite = false;
  String displayLanguage = 'Both'; // Options: 'Both', 'Chinese', 'English'

  // 模拟从数据库加载的数据
  final Map<String, dynamic> articleData = {
    'title': '二十四节气：夏天立夏，可能不知道的5件事',
    'author': 'China Daily',
    'publish_time': '2024-05-05 14:56',
    'description':
        'The traditional Chinese solar calendar divides the year into 24 solar terms. 中囯的传统农历将一年分为二十四节气。',
    'content': '''
    ["\u6700\u8fd1\u4e00\u6bb5\u65f6\u95f4\uff0c\u90e8\u5206\u7f8e\u897f\u65b9\u653f\u5ba2\u548c\u5a92\u4f53\u4e0d\u65ad\u6e32\u67d3\u6240\u8c13\u201c\u4e2d\u56fd\u4ea7\u80fd\u8fc7\u5269\u8bba\u201d\u3002\u5206\u6790\u4eba\u58eb\u666e\u904d\u8ba4\u4e3a\uff0c\u201c\u4e2d\u56fd\u4ea7\u80fd\u8fc7\u5269\u8bba\u201d\u7ad9\u4e0d\u4f4f\u811a\uff0c\u6765\u81ea\u6743\u5a01\u673a\u6784\u7684\u6570\u636e\u4e5f\u4e0d\u652f\u6301\u6240\u8c13\u7684\u201c\u4ea7\u80fd\u8fc7\u5269\u201d\u3002\u201c\u4e2d\u56fd\u4ea7\u80fd\u8fc7\u5269\u8bba\u201d\u5b9e\u8d28\u4e0a\u662f\u62b9\u9ed1\u548c\u6253\u538b\u4e2d\u56fd\u7ecf\u6d4e\u7684\u653f\u6cbb\u5de5\u5177\uff0c\u5176\u80cc\u540e\u51f8\u663e\u7684\u662f\u9006\u5168\u7403\u5316\u548c\u8d38\u6613\u4fdd\u62a4\u4e3b\u4e49\uff0c\u5176\u7ed3\u679c\u662f\u963b\u788d\u5168\u7403\u8d38\u6613\uff0c\u635f\u5bb3\u5404\u56fd\u5171\u540c\u5229\u76ca\u3002",
     "The so-called \"China overcapacity\" narrative has been employed by certain Western countries, primarily the United States, as a political tool to tarnish and suppress the Chinese economy, the observers said. Behind the slander lies an agenda of anti-globalization and protectionism that ultimately hinders normal global trade and undermines the common interests of nations, they said.\u5206\u6790\u4eba\u58eb\u6307\u51fa\uff0c\u4ee5\u7f8e\u56fd\u4e3a\u9996\u7684\u90e8\u5206\u897f\u65b9\u56fd\u5bb6\u5c06\u6240\u8c13\u7684\u201c\u4e2d\u56fd\u4ea7\u80fd\u8fc7\u5269\u8bba\u201d\u4f5c\u4e3a\u62b9\u9ed1\u548c\u6253\u538b\u4e2d\u56fd\u7ecf\u6d4e\u7684\u653f\u6cbb\u5de5\u5177\u3002\u5176\u80cc\u540e\u662f\u53cd\u5168\u7403\u5316\u548c\u8d38\u6613\u4fdd\u62a4\u4e3b\u4e49\uff0c\u5176\u7ed3\u679c\u662f\u963b\u788d\u6b63\u5e38\u7684\u5168\u7403\u8d38\u6613\uff0c\u635f\u5bb3\u5404\u56fd\u5171\u540c\u5229\u76ca\u3002",
      "China holds a significant position in the global supply chain, although that's not due to Chinese policy, but rather the result of companies and consumers worldwide making their own decisions, experts and executives said. After all, they added, China, as the world's second-largest economy, has a comparative advantage in its economic model \u2014 one that makes it the go-to manufacturing hub of the world.\u591a\u4f4d\u7ecf\u6d4e\u5b66\u5bb6\u548c\u8de8\u56fd\u4f01\u4e1a\u9ad8\u7ba1\u8868\u793a\uff0c\u4e2d\u56fd\u5728\u5168\u7403\u4f9b\u5e94\u94fe\u4e2d\u5360\u636e\u91cd\u8981\u5730\u4f4d\uff0c\u8fd9\u662f\u5168\u7403\u4f01\u4e1a\u548c\u6d88\u8d39\u8005\u81ea\u4e3b\u51b3\u7b56\u7684\u7ed3\u679c\uff0c\u800c\u4e0d\u662f\u4e2d\u56fd\u7684\u653f\u7b56\u51b3\u5b9a\u7684\u3002\u4f5c\u4e3a\u4e16\u754c\u7b2c\u4e8c\u5927\u7ecf\u6d4e\u4f53\uff0c\u4e2d\u56fd\u7684\u7ecf\u6d4e\u6a21\u5f0f\u5177\u6709\u6bd4\u8f83\u4f18\u52bf\uff0c\u4f7f\u5176\u6210\u4e3a\u4e16\u754c\u5236\u9020\u4e1a\u7684\u4e2d\u5fc3\u3002",
       "Albert Park, chief economist at the Asian Development Bank, said concerns about Chinese exports in terms of overcapacity are not supported well by evidence, noting that the World Trade Organization addresses noncompetitive practices with anti-dumping and countervailing duties, and there is no strong evidence that either applies to China.\u4e9a\u6d32\u5f00\u53d1\u94f6\u884c\u9996\u5e2d\u7ecf\u6d4e\u5b66\u5bb6\u6734\u4e4b\u6c34\u8868\u793a\uff0c\u5bf9\u201c\u4e2d\u56fd\u8f93\u51fa\u8fc7\u5269\u4ea7\u80fd\u201d\u7684\u62c5\u5fe7\u8bc1\u636e\u4e0d\u8db3\u3002\u4ed6\u6307\u51fa\uff0c\u4e16\u754c\u8d38\u6613\u7ec4\u7ec7\u901a\u8fc7\u5f81\u6536\u53cd\u503e\u9500\u7a0e\u548c\u53cd\u8865\u8d34\u7a0e\u89e3\u51b3\u4e0d\u5f53\u7ade\u4e89\u95ee\u9898\uff0c\u4f46\u6ca1\u6709\u6709\u529b\u7684\u8bc1\u636e\u8868\u660e\u8fd9\u4e24\u79cd\u505a\u6cd5\u9002\u7528\u4e8e\u4e2d\u56fd\u3002", "On the contrary, a critical issue facing the world today is not an oversupply of green energy capacity, but rather a severe shortage. According to the International Energy Agency, annual sales of electric vehicles are projected to reach 45 million units by 2030, more than four times the demand in 2022.\u5f53\u4eca\u4e16\u754c\u9762\u4e34\u7684\u5173\u952e\u95ee\u9898\u4e0d\u662f\u7eff\u8272\u80fd\u6e90\u4ea7\u80fd\u8fc7\u5269\uff0c\u800c\u662f\u4e25\u91cd\u77ed\u7f3a\u3002\u636e\u56fd\u9645\u80fd\u6e90\u7f72\u6d4b\u7b97\uff0c2030\u5e74\u5168\u7403\u65b0\u80fd\u6e90\u6c7d\u8f66\u9700\u6c42\u91cf\u5c06\u8fbe4500\u4e07\u8f86\uff0c\u662f2022\u5e74\u76844\u500d\u591a\u3002", 
       "Robin Xing, chief China economist at Morgan Stanley, said, \"It is unfair to specifically mention China's industrial policies and imply that China's competitive advantage is subsidized by the government\", as many countries are allocating government subsidies and introducing industrial policies to boost strategic industries and productivity.\u6469\u6839\u58eb\u4e39\u5229\u4e2d\u56fd\u9996\u5e2d\u7ecf\u6d4e\u5b66\u5bb6\u90a2\u81ea\u5f3a\u79f0\uff0c\u201c\u523b\u610f\u9488\u5bf9\u4e2d\u56fd\u7684\u4ea7\u4e1a\u653f\u7b56\u3001\u5e76\u6697\u793a\u4e2d\u56fd\u7684\u7ade\u4e89\u4f18\u52bf\u662f\u9760\u653f\u5e9c\u8865\u8d34\uff0c\u8fd9\u662f\u4e0d\u516c\u5e73\u7684\u201d\uff0c\u56e0\u4e3a\u8bb8\u591a\u56fd\u5bb6\u6b63\u5728\u901a\u8fc7\u653f\u5e9c\u8865\u8d34\u548c\u76f8\u5e94\u4ea7\u4e1a\u653f\u7b56\u4fc3\u8fdb\u6218\u7565\u6027\u4ea7\u4e1a\u548c\u751f\u4ea7\u529b\u7684\u53d1\u5c55\u3002", "For instance, the US Inflation Reduction Act \u2014 the largest US investment ever in clean energy and climate action \u2014 was signed into law by US President Joe Biden, and the White House has awarded billions of dollars in subsidies for advanced semiconductor manufacturing.\u4ee5\u7f8e\u56fd\u4e3a\u4f8b\uff0c\u7f8e\u56fd\u603b\u7edf\u4e54\u00b7\u62dc\u767b\u7b7e\u7f72\u4e86\u300a\u901a\u80c0\u524a\u51cf\u6cd5\u6848\u300b\uff0c\u8fd9\u662f\u8be5\u56fd\u6709\u53f2\u4ee5\u6765\u5bf9\u6e05\u6d01\u80fd\u6e90\u548c\u6c14\u5019\u884c\u52a8\u7684\u6700\u5927\u6295\u8d44\uff0c\u767d\u5bab\u5df2\u4e3a\u5148\u8fdb\u534a\u5bfc\u4f53\u5236\u9020\u4e1a\u63d0\u4f9b\u6570\u4ebf\u7f8e\u5143\u7684\u8865\u8d34\u3002", 
       "In the lead-up to the US presidential election in November, politicians are increasingly using issues of overcapacity and the trade imbalance with other countries for political leverage, with political considerations taking precedence over genuine economic concerns, observers said.\u5206\u6790\u4eba\u58eb\u79f0\uff0c\u5728\u5341\u4e00\u6708\u7f8e\u56fd\u5927\u9009\u524d\u5915\uff0c\u4e00\u4e9b\u653f\u5ba2\u5c06\u6240\u8c13\u201c\u4e2d\u56fd\u4ea7\u80fd\u8fc7\u5269\u8bba\u201d\u548c\u4e0e\u5176\u4ed6\u56fd\u5bb6\u7684\u8d38\u6613\u4e0d\u5e73\u8861\u95ee\u9898\u4f5c\u4e3a\u653f\u6cbb\u7b79\u7801\uff0c\u5176\u653f\u6cbb\u8003\u8651\u4f18\u5148\u4e8e\u771f\u6b63\u7684\u7ecf\u6d4e\u5173\u5207\u3002", "Yao Yang, director of the China Center for Economic Research at Peking University, said: \"The Biden administration claims to uphold a worker-centered trade policy, and its recent moves, from raising the capacity issue to launching a trade probe against China, are more like gestures to please and curry favor with certain groups of voters, rather than pursuing any economic considerations.\u5317\u4eac\u5927\u5b66\u4e2d\u56fd\u7ecf\u6d4e\u7814\u7a76\u4e2d\u5fc3\u4e3b\u4efb\u59da\u6d0b\u8868\u793a\uff1a\u201c\u7f8e\u56fd\u653f\u5e9c\u58f0\u79f0\u5176\u8d38\u6613\u653f\u7b56\u4e3a\u2018\u4ee5\u5de5\u4eba\u4e3a\u4e2d\u5fc3\u2019\u201d\uff0c\u4ece\u70ae\u5236\u2018\u4e2d\u56fd\u4ea7\u80fd\u8fc7\u5269\u8bba\u2019\u5230\u5bf9\u4e2d\u56fd\u53d1\u8d77\u8d38\u6613\u8c03\u67e5\uff0c\u5176\u8fd1\u671f\u4e3e\u63aa\u66f4\u50cf\u662f\u4e3a\u53d6\u60a6\u548c\u8ba8\u597d\u67d0\u4e9b\u9009\u6c11\u7fa4\u4f53\u505a\u59ff\u6001\uff0c\u800c\u975e\u51fa\u4e8e\u7ecf\u6d4e\u8003\u8651\u3002", 
       "\u82f1\u6587\u6765\u6e90\uff1a\u4e2d\u56fd\u65e5\u62a5\u7f16\u8f91\uff1a\u8463\u9759\u5ba1\u6821\uff1a\u4e07\u6708\u82f1 \u9648\u4e39\u59ae"]
       ''',
    'urlToImage':
        'https://img2.chinadaily.com.cn/images/202404/25/6629fbbba31082fc2b6cd018.jpeg',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.topRight,
              children: [
                Image.network(
                  articleData['urlToImage'],
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border),
                        color: Colors.red,
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                      ),
                      PopupMenuButton<String>(
                        onSelected: (String value) {
                          setState(() {
                            displayLanguage = value;
                          });
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'Both',
                            child: Text('显示双语'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'Chinese',
                            child: Text('仅显示中文'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'English',
                            child: Text('仅显示英文'),
                          ),
                        ],
                        icon: Icon(Icons.settings),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    getDisplayText(articleData['title']),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '编辑: ${articleData['author']}',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '发布时间: ${articleData['publish_time']}',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                  Text(
                    getDisplayText(articleData['description']),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getDisplayText(String text) {
    if (displayLanguage == 'Chinese') {
      return text.split('. ')[
          1]; // Assumes the Chinese text follows the English text and is separated by ". "
    } else if (displayLanguage == 'English') {
      return text.split('. ')[0]; // Assumes the English text comes first
    }
    return text; // Return the full text if both are selected
  }
}
