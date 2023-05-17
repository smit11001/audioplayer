import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class firstpage extends StatefulWidget {
  const firstpage({Key? key}) : super(key: key);
  @override
  State<firstpage> createState() => _firstpageState();
}
class _firstpageState extends State<firstpage> {
  bool isplaying = false;
  double value = 0;
  final player = AudioPlayer();
  Duration? duration = Duration(seconds: 0);
  void initPlayer() async {
    await player.setSource(AssetSource("kesariya.mp3"));
    duration = await player.getDuration();
  }
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    initPlayer();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'MUSIC PLAYER',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.my_library_music,
                color: Colors.black,
              ),
              label: "Settings",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              label: "Profile",
            ),
          ]),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/1.jpg"), fit: BoxFit.cover)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
              child: Container(
                color: Colors.black54,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 220,
                width: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image:DecorationImage(
                      image: AssetImage("assets/1.jpg"),fit: BoxFit.cover
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "KESARIYA",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: 6,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${(value / 60).floor()}:${(value % 60).floor()}",
                    style: TextStyle(color: Colors.white),
                  ),
                  Slider.adaptive(
                    onChanged: (v){
                      setState(() {
                        value=v;
                      });
                    },
                    min: 0.0,
                    max: duration!.inSeconds.toDouble(),
                    value: value,
                    onChangeEnd: (NewValue) async{
                      setState(() {
                        value=NewValue;
                        print(NewValue);
                      });
                      player.pause();
                      await player.seek(Duration(seconds: NewValue.toInt()));
                    },
                    activeColor: Colors.white,
                  ),
                  Text(
                    "${duration!.inMinutes}:${duration!.inSeconds % 60}",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.black87,
                    border: Border.all(color: Colors.pink)),
                child: InkWell(
                  onTap: () async {
                    if (isplaying) {
                      await player.pause();
                      setState(() {
                        isplaying = false;
                      });
                    } else {
                      await player.resume();
                      setState(() {
                        isplaying = true;
                      });
                      player.onPositionChanged.listen((position) {
                        setState(() {
                          value = position.inSeconds.toDouble();
                        });
                      });
                    }
                  },
                  child: Icon(
                    isplaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}