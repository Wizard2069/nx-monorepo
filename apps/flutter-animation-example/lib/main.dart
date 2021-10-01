import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_example/utils/ui/animations/hero_animation.dart';
import 'package:flutter_animation_example/utils/ui/animations/radial_expansion_animation.dart';
import 'package:flutter_animation_example/widgets/animated_logo.dart';
import 'package:flutter_animation_example/widgets/stagger_demo.dart';

void main() {
  runApp(const MaterialApp(
    home: StaggerDemo(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {

  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      })
      ..addStatusListener((status) {
        // print('$status');
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}



