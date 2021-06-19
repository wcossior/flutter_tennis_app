import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/blocs/auth_bloc.dart';
import 'package:flutter_app_tenis/pages/Scheduling_page.dart';
import 'package:flutter_app_tenis/pages/categories_page.dart';
import 'package:flutter_app_tenis/pages/home_page.dart';
import 'package:flutter_app_tenis/pages/login_page.dart';
import 'package:flutter_app_tenis/pages/notifications_page.dart';
import 'package:flutter_app_tenis/pages/signup_page.dart';
import 'package:flutter_app_tenis/pages/tournament_page.dart';
import 'package:flutter_app_tenis/preferences/userPreferences.dart';
import 'package:flutter_app_tenis/providers/pushnotification_provider.dart';
import 'package:flutter_app_tenis/styles/theme.dart';
import 'package:flutter/services.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final prefs = new UserPreferences();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  void initState() {
    super.initState();
    final pushProvider = new PushNotificationProvider();
    pushProvider.initNotifications();
  }

  @override
  Widget build(BuildContext context) {
    authBloc.restoreSession();

    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: _drawPage(),
      routes: {
        "home": (BuildContext context) => HomePage(),
        "login": (BuildContext context) => LoginPage(),
        "signup": (BuildContext context) => SignUpPage(),
        "notification": (BuildContext context) => NotificationPage(),
        "tournament": (BuildContext context) => TournamentPage(),
        "category": (BuildContext context) => CategoryPage(),
        "scheduling": (BuildContext context) => SchedulingPage(),
      },
      theme: theme(),
    );
  }

  Widget _drawPage() {
    return StreamBuilder<bool>(
      stream: authBloc.streamIsSessionValid,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData && snapshot.data) {
          return HomePage();
        }
        return LoginPage();
      },
    );
  }
}
