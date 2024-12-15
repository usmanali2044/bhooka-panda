import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_project_1/dashboard.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override

void initState(){
    super.initState();
    Timer(Duration(seconds: 3), (){
      Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context)=>Dashboard())
      );
    });
  }
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFFEA2A00),
      body: Stack(
        alignment: Alignment.center,
        children: [

          Image.asset(
            "assets/img/pandalogo.png",
            width: media.width,
            height: media.height,

          ),

        ],
      ),
    );
  }
}
