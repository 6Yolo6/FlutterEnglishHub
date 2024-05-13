import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TranslationPage extends StatefulWidget {
  const TranslationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TranslationPageState createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Translation'),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
        
  //     ),
  //     body: SingleChildScrollView(
  //       padding: EdgeInsets.symmetric(vertical: 17.h),
  //       child: Column(
  //         children: [
  //           Section(
  //             title: 'Hot topics',
  //             child: SizedBox(
  //               height: 180,
  //               child: ListView.builder(
  //                 scrollDirection: Axis.horizontal,
  //                 itemBuilder: (BuildContext context, int index) => Container(
  //                   margin: EdgeInsets.only(
  //                     left: index == 0 ? 13.w : 0,
  //                     right: 8.w,
  //                   ),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Container(
  //                         width: 129.w,
  //                         height: 129.w,
  //                         decoration: ShapeDecoration(
  //                           shape: RoundedRectangleBorder(
  //                             side: BorderSide(
  //                                 width: 1, color: Color(0xFFA8A8A8)),
  //                           ),
  //                         ),
  //                         alignment: Alignment.center,
  //                         child: Image.network(
  //                           'https://hyf666.oss-cn-fuzhou.aliyuncs.com/english_hub/jpg/d6f27fffa6b247508eb0c61c315e7c78hd-wallpaper-g745e7965a_640.jpg',
  //                           width: 50.w,
  //                           height: 50.h,
  //                         ),
  //                       ),
  //                       4.verticalSpace,
  //                       Text(
  //                         'Topic #1',
  //                         style: TextStyle(
  //                           color: Colors.black,
  //                           fontSize: 14,
  //                           fontFamily: 'Work Sans',
  //                           fontWeight: FontWeight.w500,
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //                 itemCount: 3,
  //               ),
  //             ),
  //           ),
  //           Section(
  //             title: 'Playlist',
  //             child: SizedBox(
  //               height: 268.h,
  //               child: ListView.builder(
  //                 scrollDirection: Axis.horizontal,
  //                 itemBuilder: (BuildContext context, int index) => Container(
  //                   width: 168.w,
  //                   margin: EdgeInsets.only(
  //                     left: index == 0 ? 12.w : 0,
  //                     right: 16.w,
  //                   ),
  //                   decoration: BoxDecoration(
  //                     color: Color(0x7FD0D0D0),
  //                   ),
  //                   child: Column(
  //                     children: [
  //                       Container(
  //                         width: 168.w,
  //                         height: 180.h,
  //                         decoration: BoxDecoration(color: Color(0xFFC4C4C4)),
  //                         padding: EdgeInsets.symmetric(
  //                             vertical: 11.h, horizontal: 7.w),
  //                         alignment: Alignment.bottomRight,
  //                         child: Container(
  //                           padding: EdgeInsets.all(2.w),
  //                           decoration: BoxDecoration(color: Color(0xFF262626)),
  //                           child: Text(
  //                             '11 talks',
  //                             style: TextStyle(
  //                               color: Colors.white,
  //                               fontSize: 12.sp,
  //                               fontFamily: 'Work Sans',
  //                               fontWeight: FontWeight.w400,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: EdgeInsets.only(
  //                             top: 4.w, right: 4.w, left: 4.w, bottom: 4.w),
  //                         child: Row(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Expanded(
  //                               child: Text(
  //                                 'Biden Ends Infrastructure Talks With Senate GOP Group.',
  //                                 style: TextStyle(
  //                                   color: Colors.black,
  //                                   fontSize: 12.sp,
  //                                   fontFamily: 'Work Sans',
  //                                   fontWeight: FontWeight.w600,
  //                                 ),
  //                               ),
  //                             ),
  //                             5.horizontalSpace,
  //                             Icon(Icons.more_vert),
  //                           ],
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //                 itemCount: 3,
  //               ),
  //             ),
  //           ),
  //           41.verticalSpace,
  //           Section(
  //               title: "Speakers",
  //               child: SizedBox(
  //                 height: 110,
  //                 child: ListView.builder(
  //                   scrollDirection: Axis.horizontal,
  //                   itemCount: 7,
  //                   itemBuilder: (context, index) => Container(
  //                     width: 105,
  //                     height: 105,
  //                     margin: EdgeInsets.only(
  //                       left: 12.0,
  //                       right: 4,
  //                     ),
  //                     decoration: ShapeDecoration(
  //                       color: Color(0xFFC4C4C4),
  //                       shape: OvalBorder(),
  //                     ),
  //                   ),
  //                 ),
  //               )),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

class Section extends StatelessWidget {
  final Widget child;

  const Section({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  child: Text(
                    'See all',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontFamily: 'Work Sans',
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
          ),
          12.verticalSpace,
          child,
        ],
      ),
    );
  }
}

