import 'dart:async';

import 'package:flutter/cupertino.dart';

class DelayedAnimation extends StatefulWidget {
  final Widget child;
  final int? delay;
  final AnimationController _controller;
  final Animation<Offset> _animOffset;

  DelayedAnimation(
      {Key? key,
      required this.child,
      this.delay,
      required controller,
      required animationOffset})
      : _controller = controller,
        _animOffset = animationOffset,
        super(key: key);

  @override
  _DelayedAnimationState createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    widget._controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: widget._animOffset,
        child: widget.child,
      ),
      opacity: widget._controller,
    );
  }
}
