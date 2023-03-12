import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class PulsingHeartIcon extends StatefulWidget {

  final Color color;

  PulsingHeartIcon({ required this.color});

  @override
  _PulsingHeartIconState createState() => _PulsingHeartIconState();
}

class _PulsingHeartIconState extends State<PulsingHeartIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + _animationController.value * 0.4,
          // child: Image.asset(
          //   'assets/images/marker.png',
           
          // ),
          
         child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_sharp, color: widget.color),
            // iconSize: widget.size,
          ),
        );
      },
    );
  }
}