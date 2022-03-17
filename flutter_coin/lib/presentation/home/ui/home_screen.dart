import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coin/config/styles.dart';
import 'package:flutter_coin/config/theme.dart';
import 'package:flutter_coin/utils/di/injection.dart';
import 'package:flutter_coin/utils/multi-languages/multi_languages_utils.dart';
import 'package:flutter_coin/utils/route/app_routing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey _keyRed = GlobalKey();
  String containerSize = "";

  String get _containerSize =>
      containerSize.isNotEmpty ? "Container Width Height : $containerSize" : "";

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    DefaultScreen(),
    Text('Tab 1')
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coin'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.select_all),
            label: LocaleKeys.addFriends,
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: LocaleKeys.cancelled,
            backgroundColor: Colors.green,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  void _getSizes() {
    final renderBoxRed = _keyRed.currentContext!.findRenderObject();
    final sizeRed = renderBoxRed!.paintBounds.size;
    setState(() {
      containerSize = sizeRed.toString();
    });
  }
}

class DefaultScreen extends StatefulWidget {
  const DefaultScreen({Key? key}) : super(key: key);

  @override
  _DefaultScreenState createState() => _DefaultScreenState();
}

class _DefaultScreenState extends State<DefaultScreen> {
  final GlobalKey _keyRed = GlobalKey();
  String containerSize = "";

  String get _containerSize =>
      containerSize.isNotEmpty ? "Container Width Height : $containerSize" : "";

  void _getSizes() {
    final renderBoxRed = _keyRed.currentContext!.findRenderObject();
    final sizeRed = renderBoxRed!.paintBounds.size;
    setState(() {
      containerSize = sizeRed.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          key: _keyRed,
          width: 375.w,
          height: 500.h,
          color: Colors.red,
          child: Text(
            "Screen Width : ${ScreenUtil().screenWidth}  Height : ${ScreenUtil().screenHeight}"
            "\n$_containerSize "
            "\nWidth Ratio : ${ScreenUtil().scaleWidth} "
            "\nHeight Ratio : ${ScreenUtil().scaleHeight} "
            "\nText Ratio : ${ScreenUtil().scaleText} "
            "\n$defaultTargetPlatform",
            style: AppTextStyle.label3,
          ),
        ),
        Text(
          "Aspect Ratio : ${ScreenUtil().pixelRatio}",
          style: AppTextStyle.label3,
        ),
        Text(
          LocaleKeys.msg.tr(
            namedArgs: {"userName": "Hoang"},
            args: ["All"],
          ),
          style: AppTextStyle.label3,
        ),
        OutlinedButton(
          onPressed: () {
            _getSizes();
          },
          child: Text(
            "Get Size",
            style: AppTextStyle.label3,
          ),
        ),
        OutlinedButton(
          onPressed: () {
            getIt<AppTheme>().changeTheme();
          },
          child: Text(
            "Change Theme",
            style: AppTextStyle.label3,
          ),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteDefine.listUserScreen.name);
          },
          child: Text(
            "Move To List User Screen",
            style: AppTextStyle.label3,
          ),
        ),
      ],
    );
  }
}
