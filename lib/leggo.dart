import 'package:flutter/material.dart';
import 'package:leggo/common/configs/locale.dart';
import 'package:leggo/common/constans/general.dart';
import 'package:leggo/common/styles.dart';
import 'package:leggo/page/splash_page.dart';

class LeggoApps extends StatelessWidget {
  const LeggoApps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kGAppName,
      theme: tdMain(context),
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: kLDelegates,
      supportedLocales: kLSupports,
    );
  }
}
