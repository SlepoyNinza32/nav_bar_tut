import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:icon_animated/icon_animated.dart';
import 'package:nav_bar_tut/rive_utils.dart';
import 'package:rive/rive.dart';

void main() {
  runApp(
    MaterialApp(
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //late SMIBool searchTrigger;

  //AnimationController con = AnimationController(vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.blueGrey[900],
            borderRadius: BorderRadius.all(
              Radius.circular(24),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                bottomNavs.length,
                (index) => GestureDetector(
                  onTap: () {
                    bottomNavs[index].input!.change(true);
                    Future.delayed(Duration(milliseconds: 700),() {
                      bottomNavs[index].input!.change(false);
                    },);
                    //searchTrigger.change(false);
                  },
                  child: SizedBox(
                    height: 36,
                    width: 36,
                    child: RiveAnimation.asset(
                      bottomNavs[index].src,
                      artboard: bottomNavs[index].artboard,
                      onInit: (artboard) {
                        StateMachineController controller =
                            RiveUtils.getRiveController(artboard,
                                stateMachineName: bottomNavs[index].stateMachineName);
                        bottomNavs[index].input = controller.findSMI('active') as SMIBool;
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RiveAsset {
  final String artboard, stateMachineName, title, src;
  late SMIBool? input;

  RiveAsset(this.src,
      {required this.artboard,
      required this.stateMachineName,
      required this.title,
      this.input});

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> bottomNavs = [
  RiveAsset('rive_icons/icons.riv',
      artboard: "HOME", stateMachineName: "HOME_interactivity", title: "Home"),
  RiveAsset('rive_icons/icons.riv',
      artboard: "CHAT", stateMachineName: "CHAT_Interactivity", title: "Chat"),
  RiveAsset('rive_icons/icons.riv',
      artboard: "LIKE/STAR", stateMachineName: "STAR_Interactivity", title: "Star"),
  RiveAsset('rive_icons/icons.riv',
      artboard: "USER",
      stateMachineName: "USER_Interactivity",
      title: "Profile"),
];
