import 'dart:async';

import 'package:flutter/material.dart' hide CarouselController;

class CustomDelayAnimatedSwitcher extends StatefulWidget {
  final Widget leftItem;
  final Widget rightItem;
  final int delayTime;
  final bool isRepeat;
  const CustomDelayAnimatedSwitcher({
    super.key,
    required this.leftItem,
    required this.rightItem,
    this.delayTime = 3,
    this.isRepeat = false,
  });

  @override
  State<CustomDelayAnimatedSwitcher> createState() =>
      _CustomDelayAnimatedSwitcherState();
}

class _CustomDelayAnimatedSwitcherState
    extends State<CustomDelayAnimatedSwitcher> {
  Widget? _currentItem;
  bool isShowLeft = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _currentItem = widget.leftItem;
    _timer = Timer.periodic(Duration(seconds: widget.delayTime), (Timer timer) {
      if ((_timer?.tick ?? 0) % widget.delayTime == 0) {
        setState(() {
          if (isShowLeft) {
            _currentItem = widget.rightItem;
          } else {
            _currentItem = widget.leftItem;
          }
          isShowLeft = !isShowLeft;
        });
        if (widget.isRepeat == false) {
          _timer?.cancel();
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Container(
              key: ValueKey<int>(_timer?.tick ?? 0),
              child: _currentItem,
            ),
          ),
        ],
      ),
    );
  }
}
