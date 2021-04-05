import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/blocs/home_bloc.dart';
import 'package:flutter_app_tenis/pages/notification_page.dart';
import 'package:flutter_app_tenis/pages/tournament_page.dart';
import 'package:flutter_app_tenis/preferences/userPreferences.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_app_tenis/styles/colors.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';
import 'package:flutter_app_tenis/styles/svgIcons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  HomeBloc bloc = HomeBloc();
  bool showMessage = false;
  final prefs = new UserPreferences();
  GlobalKey _bottomNavigationKey = GlobalKey();
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => showMessageLoginSuccessful());
  }

  void onPageChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }
// onPressed: bloc.logoutUser,

  @override
  Widget build(BuildContext context) {
    print(prefs.user["nombre"]);
    return Scaffold(
      appBar: _drawAppBar(context),
      backgroundColor: ColorsApp.white,
      body: _getPage(),
      bottomNavigationBar: _drawBottomNav(),
    );
  }

  AppBar _drawAppBar(BuildContext context) {
    return AppBar(
      title: _drawUser(context),
      actions: [
        GestureDetector(
          onTap: bloc.logoutUser,
          child: Container(
            margin: EdgeInsets.only(right: getProportionateScreenWidth(22.0)),
            child: Row(
              children: [
                SvgIconsApp.logout,
                SizedBox(width: 6.0),
                Text(
                  "Cerrar Session",
                  style: Theme.of(context).textTheme.bodyText2.copyWith(color: ColorsApp.orange,fontWeight: FontWeight.w700,),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container _drawUser(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15.0),
      child: Row(
        children: [
          SvgIconsApp.user,
          SizedBox(width: 10.0),
          Column(
            children: [
              Text(
                "Hola!",
                style: Theme.of(context).textTheme.headline2.copyWith(color: ColorsApp.blueObscured),
              ),
              Text(
                prefs.user["nombre"],
                style: Theme.of(context).textTheme.bodyText2,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _getPage() {
    return Container(
      child: PageView(
        children: [TournamentPage(), NotificationPage()],
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
    );
  }

  CurvedNavigationBar _drawBottomNav() {
    return CurvedNavigationBar(
      index: currentPage,
      key: _bottomNavigationKey,
      backgroundColor: ColorsApp.white,
      height: getProportionateScreenHeight(55.0),
      color: ColorsApp.green,
      items: [
        SvgIconsApp.trophy,
        SvgIconsApp.bell,
      ],
      onTap: (index) {
        setState(() {
          pageController.jumpToPage(index);
        });
      },
    );
  }

  void showMessageLoginSuccessful() {
    if (prefs.wasShownMessage == null) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.SCALE,
        title: "Inicio de sesión exitoso",
        desc: "",
        autoHide: Duration(seconds: 3),
      )..show();
      prefs.wasShownMessage = true;
    }
  }
}
