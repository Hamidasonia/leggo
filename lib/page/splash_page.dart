import 'dart:async';

import 'package:flutter/material.dart';
import 'package:leggo/api/session_manager.dart';
import 'package:leggo/common/constans/image.dart';
import 'package:leggo/model/app/singleton_model.dart';
import 'package:leggo/page/main_page.dart';
import 'package:leggo/page/onboard_page.dart';
import 'package:leggo/tool/helper.dart';
import 'package:leggo/tool/hex_color.dart';
import 'package:leggo/tool/permissions_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late AnimationController _controller;
  late SingletonModel _model;

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
    _model = SingletonModel.withContext(context);
    _model.user?.data?.users = [];
    _model.isLogin = false;
    _cekSession();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future _cekSession() async {
    return Future.delayed(const Duration(milliseconds: 5900), () {
      session.getSession().then((value) {
        if (value != null) {
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (_) => MainPage()), (
              route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (_) => OnBoardPage()), (
              route) => false);
        }
      });
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
