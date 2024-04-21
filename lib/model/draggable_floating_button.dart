import 'package:flutter/material.dart';

class DraggableFloatingButton extends StatefulWidget {
  final VoidCallback onTap;

  DraggableFloatingButton({required this.onTap});

  @override
  _DraggableFloatingButtonState createState() => _DraggableFloatingButtonState();
}

class _DraggableFloatingButtonState extends State<DraggableFloatingButton> {
  Offset _offset = Offset(0, 100); // 初始位置
  final double buttonSize = 40; // 按钮大小

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Positioned(
      left: _offset.dx,
      top: _offset.dy,
      child: Draggable(
        feedback: FloatingButton(onTap: widget.onTap), // 拖动时的按钮
        child: FloatingButton(onTap: widget.onTap), // 按钮状态
        childWhenDragging: Container(), // 占位符
        onDragUpdate: (details) {
          double dx = details.localPosition.dx;
          double dy = details.localPosition.dy;

          // 限制顶部和底部
          dy = dy.clamp(70, screenHeight - 70); // 顶部和底部限制
          dx = dx.clamp(0, screenWidth - buttonSize); // 左右限制

          setState(() {
            _offset = Offset(dx, dy);
          });
        },
        onDragEnd: (details) {
          double dx = details.offset.dx;
          double dy = details.offset.dy;

          // 根据屏幕中线确定左侧或右侧
          if (dx < screenWidth / 2) {
            dx = 0; // 左侧
          } else {
            // 右侧
            dx = screenWidth - buttonSize - 7; // 10是右侧间距
          }
          dy = dy.clamp(60, screenHeight - 104); // 再次限制顶部和底部

          setState(() {
            _offset = Offset(dx, dy); // 确定停靠位置
          });
        },
      ),
    );
  }
}

// 按钮组件外观
class FloatingButton extends StatelessWidget {
  final VoidCallback onTap;

  FloatingButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.search, color: Colors.white),
      ),
    );
  }
}
