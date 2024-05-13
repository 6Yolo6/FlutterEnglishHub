import 'package:flutter/material.dart';

class BlankImageWithText extends StatelessWidget {
  final String text; // 要显示的文本
  final double width; // 图片宽度
  final double height; // 图片高度

  const BlankImageWithText({
    Key? key,
    required this.text,
    this.width = 60,
    this.height = 80,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height), // 图片大小
      painter: _TextPainter(text), // 使用自定义绘制器
    );
  }
}

class _TextPainter extends CustomPainter {
  final String text; // 要绘制的文本

  _TextPainter(this.text);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.grey[300] ?? Colors.grey; // 设置背景颜色

    // 绘制空白背景
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // 创建TextPainter来绘制文本
    final textPainter = TextPainter(
      text: TextSpan(
        text: text, // 要显示的文本
        style: TextStyle(color: Colors.black, fontSize: 12), // 文本样式
      ),
      textDirection: TextDirection.ltr, // 文本方向
    );

    textPainter.layout(minWidth: 0, maxWidth: size.width); // 布局文本

    // 计算文本的位置
    final offset = Offset(
      (size.width - textPainter.width) / 2,
      (size.height - textPainter.height) / 2,
    );

    // 在画布上绘制文本
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // 无需重新绘制
  }
}
