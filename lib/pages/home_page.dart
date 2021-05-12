import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/blocs/home_bloc.dart';
import 'package:flutter_app_tenis/pages/notifications_page.dart';
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

  void _areYouSureToLogout() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      headerAnimationLoop: true,
      animType: AnimType.BOTTOMSLIDE,
      showCloseIcon: false,
      closeIcon: Icon(Icons.close_fullscreen_outlined),
      title: 'Cerrar Sesión',
      desc: '¿Esta seguro de salir?',
      btnOkText: "Si",
      btnOkColor: ColorsApp.orange,
      btnCancelText: "No",
      btnCancelColor: ColorsApp.green,
      btnCancelOnPress: () {},
      btnOkOnPress: bloc.logoutUser,
    )..show();
  }

  Widget _drawAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsApp.white,
      elevation: 0.0,
      brightness: Brightness.light,
      title: _drawUser(context),
      toolbarHeight: 70.0,
      actions: [
        _drawLogoutOption(context),
      ],
    );
  }

  Widget _drawLogoutOption(BuildContext context) {
    return GestureDetector(
      onTap: _areYouSureToLogout,
      child: Container(
        margin: EdgeInsets.only(right: getProportionateScreenWidth(22.0)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgIconsApp.logout,
            SizedBox(width: 6.0),
            Text(
              "Cerrar Session",
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: ColorsApp.orange,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawUser(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgIconsApp.avatarPlayer,
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              prefs.user["nombre"],
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
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
