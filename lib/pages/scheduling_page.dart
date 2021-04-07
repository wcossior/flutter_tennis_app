import 'package:flutter/material.dart';

class SchedulingPage extends StatefulWidget {
  final String idTournament;
  const SchedulingPage({Key key, this.idTournament}) : super(key: key);

  @override
  _SchedulingPageState createState() => _SchedulingPageState();
}

class _SchedulingPageState extends State<SchedulingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Hola programación"),
      ),
    );
  }
}
