import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leggo/common/styles/theme.dart';
import 'package:leggo/dialog/coming_soon_dialog.dart';
import 'package:leggo/dialog/exit_dialog.dart';
import 'package:leggo/page/account/account_page.dart';
import 'package:leggo/page/home/home_page.dart';
import 'package:leggo/page/list/list_page.dart';
import 'package:leggo/page/wishlist/wishlist_page.dart';
import 'package:leggo/tool/hex_color.dart';

class MainPage extends StatefulWidget {
  final int page;

  MainPage({this.page = 0});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late int _page;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _page = widget.page;
  }

  Future<bool> _onWillPop() async {
    if (_page > 0) {
      setState(() {
        _page = 0;
      });
      return Future(() => false);
    } else {
      bool exit = await openExitDialog(context) ?? false;
      if (exit) {
        setState(() {
          exit = true;
        });
      }
      return Future(() => exit);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        body: _buildBody(_page),
        bottomSheet: _buildBottomNavBar(),
      ),
    );
  }

  Widget _buildBody(int page) {
    return <Widget>[
      HomePage(),
      WishlistPage(),
      ListPage(),
      AccountPage(),
    ].toList()[_page];
  }

  Widget _buildBottomNavBar() {
    return Theme(
      data: tdMain(context).copyWith(canvasColor: Colors.white),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 0,
              blurRadius: 10,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _page,
            onTap: (i) => setState(() {
              if(i == 1 || i == 2){
                openComingSoonDialog(context);
              } else {
                _page = i;
              }
            }),
            selectedItemColor: HexColor("C983DE"),
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icons/home_ic.svg",
                  height: 20,
                  color: _page == 0 ? HexColor("C983DE") : Colors.grey[300],
                ),
                label: "Home"
              ),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/favorite_ic.svg",
                    height: 20,
                    color: _page == 1 ? HexColor("#C983DE") : Colors.grey[300],
                  ),
                  label: "Favorite"
              ),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/list_ic.svg",
                    height: 20,
                    color: _page == 2 ? HexColor("C983DE") : Colors.grey[300],
                  ),
                  label: "List"
              ),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/account_ic.svg",
                    height: 20,
                    color: _page == 3 ? HexColor("C983DE") : Colors.grey[300],
                  ),
                  label: "Account"
              ),
            ],
          ),
        ),
      ),
    );
  }
}
