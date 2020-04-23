library flutter_marquee_widget;

import 'package:flutter/material.dart';
import 'dart:async';

class FlutterMarqueeWidget extends StatefulWidget {
  
  final List<Widget> items;
  final int initialItemCount;
  final bool running;
  final Duration duration;
  final bool reverse;
  
  const FlutterMarqueeWidget(this.items, {
    Key key,
    this.initialItemCount = 1,
    this.running = true,
    this.duration = const Duration(seconds: 2),
    this.reverse = false,
  }): super(key: key);
  
  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<FlutterMarqueeWidget> {
  
  int currIndex;
  List<Widget> currWidgetList;

  final GlobalKey _animatedListKey = GlobalKey<AnimatedListState>();
  
  @override
  void initState() {
    super.initState();
    
    currIndex = widget.initialItemCount;
    currWidgetList = widget.items.sublist(0, widget.initialItemCount);

    if (widget.running) {
      _start();
    }
  }

  void _start() {
    Timer.periodic(widget.duration, (_) async {
      // 删除第一个
      Widget delete = currWidgetList.removeAt(0);
      (_animatedListKey.currentState as AnimatedListState).removeItem(
        0,
        (BuildContext context, Animation<double> animation) {
          return SizeTransition(
            sizeFactor: animation,
            axis: Axis.horizontal,
              child: ScaleTransition(
                scale: animation,
                child: FadeTransition(
                  opacity: animation,
                  child: delete,
                )
            )
          );
        }
      );

      // 等待一定时间
      await Future.delayed(Duration(milliseconds: 100));

      // 在末尾添加新的widget
      currWidgetList.add(widget.items[currIndex]);
      (_animatedListKey.currentState as AnimatedListState).insertItem(currWidgetList.length-1);

      // 计算下一次要添加的元素
      currIndex = (currIndex + 1) % widget.items.length;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: Container(
        child: AnimatedList(
          key: _animatedListKey,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          initialItemCount: widget.initialItemCount,
          reverse: widget.reverse,
          itemBuilder: (BuildContext context, int index, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
                child: Transform.scale(
                  scale: 1.2,
                  child: currWidgetList[index],
                )
            );
          }
        ),
      ),
    );
  }
}
