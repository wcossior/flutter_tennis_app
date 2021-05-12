import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_app_tenis/models/auspice_model.dart';
import 'package:flutter_app_tenis/styles/colors.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';

class BottomSlider extends StatefulWidget {
  final List<Auspice> sponsors;
  const BottomSlider({Key key, this.sponsors}) : super(key: key);

  @override
  _BottomSliderState createState() => _BottomSliderState();
}

class _BottomSliderState extends State<BottomSlider> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _drawSlider(context),
        _drawWayPoints(),
      ],
    );
  }

  Widget _drawWayPoints() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: map(widget.sponsors, (index, url) {
        return Container(
          width: 10.0,
          height: 10.0,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == index ? ColorsApp.orange : ColorsApp.greyObscured,
          ),
        );
      }),
    );
  }

  CarouselSlider _drawSlider(BuildContext context) {
    return CarouselSlider(
      options: _drawCarouselOptions(context),
      items: widget.sponsors.map((sponsor) {
        return Container(
          width: double.infinity,
          child: FadeInImage(
            placeholder: AssetImage("assets/images/LoadingImg.gif"),
            fadeInDuration: Duration(milliseconds: 200),
            image: sponsor.urlImg == null
                ? AssetImage("assets/images/LoadingImg.gif")
                : NetworkImage(sponsor.urlImg),
            fit: BoxFit.cover,
          ),
        );
      }).toList(),
    );
  }

  CarouselOptions _drawCarouselOptions(BuildContext context) {
    return CarouselOptions(
      height: SizeConfig.screenHeight * 0.18,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      pauseAutoPlayOnTouch: true,
      aspectRatio: 2.0,
      onPageChanged: (index, reason) {
        setState(() {
          currentIndex = index;
        });
      },
    );
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
}
