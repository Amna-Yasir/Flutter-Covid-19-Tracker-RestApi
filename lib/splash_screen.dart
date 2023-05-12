import 'dart:async';

import 'package:covid_app/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 2), vsync: this)
        ..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => worldstats())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                child: Container(
                  height: 300,
                  width: 200,
                  child: const Center(
                      child: Image(
                          height: 400,
                          width: 200,
                          image: AssetImage('assets/images/virus.png'))),
                ),
                animation: _controller,
                builder: (BuildContext context, child) {
                  return Transform.rotate(
                      child: child, angle: _controller.value * 2.0 * math.pi);
                }),
            const Align(
                alignment: Alignment.center,
                child: Text(
                  '   Covid-19\n Tracker App',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
