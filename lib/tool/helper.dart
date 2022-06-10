import 'dart:io';
import 'package:money2/money2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class Helper {
  bool isValidMail(String mail) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(mail);
  }

  Future exitApp() {
    return Platform.isIOS ? exit(0) : SystemNavigator.pop(animated: true);
  }

  Future jumpToPage(BuildContext context, {required Widget page}) {
    return Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  Future moveToPageNoAnim(BuildContext context, {required Widget page}) {
    return Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }

  Future moveToPage(BuildContext context, {required Widget page}) {
    return Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => page));
  }

  Future jumpToPageNamed(
    BuildContext context, {
    required String route,
    dynamic arguments,
  }) {
    return Navigator.of(context).pushNamed(route, arguments: arguments);
  }

  Future moveToPageNamed(
    BuildContext context, {
    required String route,
    dynamic arguments,
  }) {
    return Navigator.of(context).pushReplacementNamed(
      route,
      arguments: arguments,
    );
  }

  void backToRootPage(BuildContext context) {
    Navigator?.of(context).popUntil((route) => route.isFirst);
  }

  void showToast(
    String msg, {
    Toast? length,
    ToastGravity? gravity,
    Color? bgColor,
    Color? textColor,
    double? size,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: length ?? Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.CENTER,
      backgroundColor: bgColor ?? Colors.black,
      textColor: textColor ?? Colors.white,
      fontSize: size ?? 16.0,
    );
  }

  String dioErrorHandler(e) {
    if (e == null) return "Unknown Error";
    if (e.runtimeType != DioError) {
      if (e is String) {
        return "Error : $e";
      } else {
        return "Unknown Error";
      }
    }
    if (e.response == null) return "Error : ${e.message}";
    String response =
        "Error (${e.response.statusCode}) : ${e.response.statusMessage}";
    if (e.response.data != null) {
      Map<String, dynamic>? data = e.response.data;
      if (data != null) {
        if (data.containsKey("message")) {
          response += "\n${data["message"]}";
        }
        if (data.containsKey("errors")) {
          data["errors"]?.forEach(
            (key, value) {
              if (value is Map<String, dynamic>) {
                value.forEach((key, val) => response += "\n$val");
              } else if (value is List) {
                for (var v in value) {
                  response += "\n$v";
                }
              } else {
                response += "\n$value";
              }
            },
          );
        }
      }
    }
    return response;
  }

  Future launcherIntent(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  double getSize({
    required BuildContext context,
    required double scale,
  }) {
    return MediaQuery.of(context).size.height * scale / 100;
  }

  String formatRupiah(String n) {
    final Currency idr = Currency.create(
      "IDR",
      0,
      symbol: "Rp",
      pattern: n.length > 3 ? "S 0.000" : "S 0",
      invertSeparators: true,
    );
    Currencies().register(idr);

    Money output = Money.fromIntWithCurrency(int.parse(n), idr);
    return output.toString();
  }
}
