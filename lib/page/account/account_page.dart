import 'package:flutter/material.dart';
import 'package:leggo/api/session_manager.dart';
import 'package:leggo/model/app/singleton_model.dart';
import 'package:leggo/page/onboard_page.dart';
import 'package:leggo/tool/helper.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late SingletonModel _model;

  @override
  void initState() {
    _model = SingletonModel.withContext(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () async {
            await session.clearSession().then((value) {
              Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (_) => OnBoardPage()), (
                  route) => false);
            });
          },
          child: const Text(
            "Logout",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
