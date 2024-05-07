// // shake_animation_widget.dart

// import 'package:flutter/material.dart';

// class ShakeAnimationWidget extends StatefulWidget {
//   final Widget child;

//   ShakeAnimationWidget({Key? key, required this.child}) : super(key: key);

//   @override
//   _ShakeAnimationWidgetState createState() => _ShakeAnimationWidgetState();
// }

// class _ShakeAnimationWidgetState extends State<ShakeAnimationWidget>
//     with SingleTickerProviderStateMixin {
//   final ageShakeKey = GlobalKey<_ShakeAnimationWidgetState>();
//   final weightShakeKey = GlobalKey<_ShakeAnimationWidgetState>();
//   AnimationController? _controller;
//   Animation<double>? _animation;

//   @override
//   // void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 100),
//       vsync: this,
//     );

//     _animation = Tween<double>(begin: 0, end: 10).animate(CurvedAnimation(
//       parent: _controller!,
//       curve: Curves.elasticIn,
//     ));

//     _controller!.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         _controller!.reverse();
//       } else if (status == AnimationStatus.dismissed) {
//         _controller!.forward();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller!.dispose();
//     super.dispose();
//   }

//   void startShake() {
//     _controller!.forward(from: 0.0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation!,
//       builder: (BuildContext context, Widget? child) {
//         return Transform.translate(
//           offset: Offset(_animation!.value, 0),
//           child: widget.child,
//         );
//       },
//     );
//   }
// }
