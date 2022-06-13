import 'package:flutter/material.dart';
import 'package:leggo/common/constans/fonts.dart';
import 'package:leggo/common/constans/image.dart';
import 'package:leggo/page/auth/auth_login_page.dart';
import 'package:leggo/page/auth/auth_register_page.dart';
import 'package:leggo/tool/helper.dart';
import 'package:leggo/tool/hex_color.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({Key? key}) : super(key: key);

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late Helper _helper;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey();
    _helper = Helper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: HexColor("F0F4FD"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(kImgOnBoard),
            const SizedBox(height: 30),
            const Text(
              "Leggo",
              style: TextStyle(
                color: Colors.black,
                fontSize: 38,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Enjoy Your Trip,\nChoose Your Travel Destination!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            _buildButton(
              label: "Masuk",
              colorButton: "433C82",
              colorText: "FFFFFF",
              route: () => _helper.jumpToPage(context, page: const LoginPage()),
            ),
            const SizedBox(height: 20),
            _buildButton(
              label: "Daftar",
              colorButton: "9A98BF",
              colorText: "433C82",
              route: () => _helper.jumpToPage(context, page: RegisterPage()),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required String colorButton,
    required String colorText,
    required Function() route,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: MaterialButton(
        onPressed: route,
        height: 50,
        minWidth: double.infinity,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: HexColor(colorButton),
        child: Text(
          label,
          style: TextStyle(
            color: HexColor(colorText),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
