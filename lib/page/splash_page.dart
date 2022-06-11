import 'dart:async';

import 'package:flutter/material.dart';
import 'package:leggo/common/constans/image.dart';
import 'package:leggo/page/onboard_page.dart';
import 'package:leggo/tool/helper.dart';
import 'package:leggo/tool/hex_color.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    _controller.forward();
    _startSplash();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _startSplash() {
    var duration = const Duration(milliseconds: 6900);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return const OnBoardPage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 40.0,
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(kImgBgSplash),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SafeArea(child: _buildBody())
          ],
        ));
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(kImgLogo),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 5,
            ),
            child: LinearProgressIndicator(
              value: _controller.value,
              color: Colors.white,
              backgroundColor: Colors.white.withOpacity(.5),
            ),
          )
        ],
      ),
    );
  }
}
