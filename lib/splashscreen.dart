import 'dart:async';
import 'package:flutter/material.dart';
import 'firstpage.dart';

class splashscreen extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return _splashscreenState();
  }
}
class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3),() {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => firstpage()), (route) => false);
    });
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Icon(Icons.queue_music,size: 200,color: Colors.white,),
      ),
    );
  }
}
