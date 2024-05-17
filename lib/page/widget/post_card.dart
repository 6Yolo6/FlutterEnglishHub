import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_english_hub/model/Articles.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final Articles article;

  const PostCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 8, right: 8),
      padding: EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xffD0D0D0)),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      article.description,
                      style: TextStyle(
                        color: Color(0xFFA8A8A8),
                        fontSize: 14.sp,
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 4, bottom: 6),
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      color: Color(0xFF525252),
                      image: DecorationImage(
                              image: NetworkImage(article.urlToImage),
                              fit: BoxFit.cover,
                            )
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: 24.w,
                      height: 24.w,
                      decoration: ShapeDecoration(
                        color: Color(0xFFA8A8A8),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2, color: Color(0xFF525252)),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.author ?? 'Unknown Author',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontFamily: 'Work Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 2.sp),
                  Text(
                    '发布于: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(article.publishTime)}',
                    style: TextStyle(
                      color: Color(0xFFA8A8A8),
                      fontSize: 12.sp,
                      fontFamily: 'Work Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.bookmark_border, size: 24.w),
                  SizedBox(width: 24.sp),
                  Icon(Icons.more_vert, size: 24.w),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
