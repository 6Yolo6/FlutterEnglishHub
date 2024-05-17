// import 'package:flutter/material.dart';
// import 'package:flutter_english_hub/page/widget/post_card.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ArticlePage extends StatefulWidget {
//   const ArticlePage({super.key});

//   @override
//   _ArticlePageState createState() => _ArticlePageState();
// }
// class _ArticlePageState extends State<ArticlePage> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Article'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(vertical: 24),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 177.h,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 5,
//                 itemBuilder: (context, index) =>
//                     Container(
//                       width: 318.w,
//                       margin: EdgeInsets.only(left: 8, right: 8),
//                       child: Column(
//                         children: [
//                           Container(
//                             width: 318.w,
//                             height: 80.h,
//                             decoration: BoxDecoration(color: Color(0xFFC4C4C4)),
//                           ),
//                           SizedBox(
//                             height: 8.h,
//                           ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   'G-7 finance ministers strike landmark deal on taxing multinationals, tech giants',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 18.sp,
//                                     fontFamily: 'Work Sans',
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 8.h,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Author Name',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 14.sp,
//                                       fontFamily: 'Work Sans',
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 2),
//                                   Text(
//                                     'May 20 · 5 min read',
//                                     style: TextStyle(
//                                       color: Color(0xFFA8A8A8),
//                                       fontSize: 12.sp,
//                                       fontFamily: 'Work Sans',
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Icon(
//                                     Icons.bookmark_border,
//                                     size: 24.w,
//                                   ),
//                                   SizedBox(width: 24.w),
//                                   Icon(
//                                     Icons.more_vert,
//                                     size: 24.w,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//               ),
//             ),
//             Divider(
//               color: Color(0xFFD0D0D0),
//             ),
//             ...List.generate(
//               4, (index) => PostCard(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }