import "package:flutter/material.dart";
import 'package:leggo/common/constans/image.dart';
import 'package:leggo/page/main_page.dart';
import 'package:leggo/tool/helper.dart';

class ComingSoonDialog extends StatefulWidget {
  @override
  _ComingSoonDialogState createState() => _ComingSoonDialogState();
}

class _ComingSoonDialogState extends State<ComingSoonDialog> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "COMING SOON",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.asset("assets/images/img_coming_soon.png"),
                SizedBox(height: 20),
                Text(
                  "This feature is on developing stage",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 20),
                MaterialButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Helper().backToRootPage(context);
                    Helper().moveToPage(context,
                        page: MainPage(
                          page: 0,
                        ));
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Colors.black, shape: BoxShape.circle),
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future openComingSoonDialog(BuildContext context) {
  return showGeneralDialog(
    barrierLabel: "Comingsoon Dialog",
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return ComingSoonDialog();
    },
    transitionDuration: Duration(milliseconds: 300),
    transitionBuilder: (context, anim1, anim2, child) {
      return Transform.scale(
        scale: anim1.value,
        child: child,
      );
    },
  );
}