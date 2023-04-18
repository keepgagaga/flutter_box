import 'package:flutter/material.dart';
import 'package:flutter_box/components/AnimatedAlignExample.dart';
import 'package:flutter_box/components/AnimatedContainerExample.dart';
import 'package:flutter_box/components/AnimatedPaddingExample.dart';
import 'package:flutter_box/components/AnimatedPositionedExample.dart';
import 'package:flutter_box/components/AnimatedText.dart';
import 'package:flutter_box/components/InnerShadowExample.dart';
import 'package:flutter_box/components/RotateAnima.dart';
import 'package:flutter_box/components/StopWatch/StopWatch.dart';
import 'package:flutter_box/components/TweenAnimationBuilderExample.dart';
import 'package:flutter_box/pages/web/components/CustomAppbar.dart';
import 'package:flutter_box/pages/web/components/LeftNav.dart';
import 'package:flutter_box/pages/web/components/RightContent.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _navIndex = 0;

  void _onNavChange(i) {
    setState(() {
      _navIndex = i;
    });
  }

  Widget build(context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: Center(
        child: Container(
          child: Row(
            children: [
              LeftNav(onNavChange: _onNavChange),
              RightContent(_navIndex),
              // SizedBox(
              //   width: 200,
              //   child: Column(
              //     children: [
              //       Text(AppLocalizations.of(context)!.implicitlyAnima),
              //       Expanded(
              //         child: ListView(
              //           children: [
              //             AnimatedContainerExample(),
              //             AnimatedPaddingExample(),
              //             AnimatedAlignExample(),
              //             TweenAnimationBuilderExample(),
              //             AnimatedPositionedExample(),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(width: 20),
              // SizedBox(
              //   width: 400,
              //   child: Column(
              //     children: [
              //       Text(AppLocalizations.of(context)!.animatedWidget),
              //       Expanded(
              //         child: ListView(
              //           children: [
              //             RotateAnima(),
              //             // AnimatedText(),
              //             // InnerShadowExample(),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(width: 20),
              // SizedBox(
              //   width: 300,
              //   child: Column(
              //     children: [
              //       Text(AppLocalizations.of(context)!.draw),
              //       Expanded(
              //         child: ListView(
              //           children: [
              //             StopWatch(),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
