import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/blocs/category_bloc.dart';
import 'package:flutter_app_tenis/models/category_model.dart';
import 'package:flutter_app_tenis/models/sponsor_model.dart';
import 'package:flutter_app_tenis/pages/sponsors_page.dart';
import 'package:flutter_app_tenis/pages/games_page.dart';
import 'package:flutter_app_tenis/repositories/sponsor_repository.dart';
import 'package:flutter_app_tenis/styles/colors.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';
import 'package:flutter_app_tenis/styles/svgIcons.dart';

class CategoryPage extends StatefulWidget {
  final String idTournament;
  const CategoryPage({Key key, this.idTournament}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  CategoryBloc categBloc = CategoryBloc();
  SponsorRepository sponsorRepo = SponsorRepository();
  int currentIndex = 0;

  @override
  void initState() {
    categBloc.getCategories(widget.idTournament);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    categBloc.getSponsors(widget.idTournament);
    return Scaffold(
      appBar: AppBar(
        title: Text("Categorías", style: Theme.of(context).textTheme.subtitle2),
      ),
      body: Column(
        children: [
          _drawOptionSponsors(context),
          Expanded(child: _drawContent()),
          _drawFooter(),
        ],
      ),
    );
  }

  Container _drawOptionSponsors(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(12.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgIconsApp.sponsor,
          SizedBox(width: 8.0),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SponsorsPage(
                  idTournament: widget.idTournament,
                ),
              ),
            ),
            child: Text(
              "Auspicios",
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: ColorsApp.orange,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          )
        ],
      ),
    );
  }

  Widget _drawFooter() {
    return StreamBuilder<List<Sponsor>>(
        stream: categBloc.sponsors,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.length > 0) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _drawSlides(context, snapshot),
                _drawCounterIndicator(snapshot),
              ],
            );
          } else {
            return Container();
          }
        });
  }

  Widget _drawCounterIndicator(AsyncSnapshot<List<Sponsor>> snapshot) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: map(snapshot.data, (index, url) {
        return Container(
          width: 10.0,
          height: 10.0,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == index ? Colors.blueAccent : Colors.grey,
          ),
        );
      }),
    );
  }

  Widget _drawSlides(BuildContext context, AsyncSnapshot<List<Sponsor>> snapshot) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 10.0, spreadRadius: 3.0),
        ],
      ),
      child: CarouselSlider(
        options: _drawCarouselOptions(context),
        items: snapshot.data.map((sponsor) {
          return Builder(builder: (BuildContext context) {
            return Container(
                height: MediaQuery.of(context).size.height * 0.30,
                width: MediaQuery.of(context).size.width,
                child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * 0.40,
                    child: FadeInImage(
                        placeholder: AssetImage("assets/images/LoadingImg.gif"),
                        fadeInDuration: Duration(milliseconds: 200),
                        image: sponsor.urlImg == null
                            ? AssetImage("assets/images/LoadingImg.gif")
                            : NetworkImage(sponsor.urlImg),
                        fit: BoxFit.cover)));
          });
        }).toList(),
      ),
    );
  }

  CarouselOptions _drawCarouselOptions(BuildContext context) {
    return CarouselOptions(
      height: MediaQuery.of(context).size.height * 0.18,
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

  StreamBuilder<List<Category>> _drawContent() {
    return StreamBuilder(
      stream: categBloc.category,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.isNotEmpty) {
          return _drawCategories(snapshot.data);
        }
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(child: Text("No hay categorías"));
        }
      },
    );
  }

  Widget _drawCategories(List<Category> data) {
    return ListView(
      padding: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.055,
        right: SizeConfig.screenWidth * 0.055,
        top: SizeConfig.screenHeight * 0.025,
      ),
      children: _getCategories(data),
    );
  }

  List<Widget> _getCategories(List<Category> data) {
    final List<Widget> drawnCategories = [];
    final cateogyList = data;

    cateogyList.forEach((category) {
      final widgetTemp = Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        child: Column(
          children: [
            _drawInfoCard(category),
            Divider(thickness: 1.2, color: ColorsApp.greyObscured),
            _drawOptions(category)
          ],
        ),
      );
      drawnCategories.add(widgetTemp);
    });
    return drawnCategories;
  }

  Widget _drawOptions(Category category) {
    return Container(
      padding: EdgeInsets.only(
        top: getProportionateScreenHeight(8.0),
        left: getProportionateScreenWidth(15.0),
        right: getProportionateScreenWidth(15.0),
        bottom: getProportionateScreenWidth(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _drawOptionPlayoffs(category.id),
          if (category.tipo == "Round Robin") _drawOptionGroups(category.id),
        ],
      ),
    );
  }

  Widget _drawOptionGroups(String idCategory) {
    return Row(
      children: [
        SvgIconsApp.group,
        SizedBox(width: 8.0),
        GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => GamesPage(
                idCategory: idCategory,
                typeInfo: "partidosgrupo",
              ),
            ),
          ),
          child: Text(
            "Grupos",
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: ColorsApp.orange,
                  fontWeight: FontWeight.w700,
                ),
          ),
        )
      ],
    );
  }

  Row _drawOptionPlayoffs(String idCategory) {
    return Row(
      children: [
        SvgIconsApp.playoffs,
        SizedBox(width: 8.0),
        GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => GamesPage(
                idCategory: idCategory,
                typeInfo: "partidoscuadro",
              ),
            ),
          ),
          child: Text(
            "Eliminatorias",
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: ColorsApp.orange,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ],
    );
  }

  Widget _drawInfoCard(Category category) {
    return Container(
      padding: EdgeInsets.only(
        top: getProportionateScreenHeight(12.0),
        left: getProportionateScreenWidth(15.0),
        right: getProportionateScreenWidth(15.0),
        bottom: getProportionateScreenWidth(8.0),
      ),
      child: Row(
        children: [
          SvgIconsApp.winner,
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              children: [
                _drawName(category),
                Divider(thickness: 1.2, color: ColorsApp.greyObscured, endIndent: 15.0),
                _drawType(category),
                Divider(thickness: 1.2, color: ColorsApp.greyObscured, endIndent: 15.0),
                _drawNumberPlayers(category),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawNumberPlayers(Category category) {
    return Container(
      child: Row(
        children: [
          SvgIconsApp.players,
          SizedBox(width: 8.0),
          Text(
            "Jugadores " + category.numeroJugadores.toString(),
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }

  Widget _drawType(Category category) {
    return Container(
      child: Row(
        children: [
          SvgIconsApp.type,
          SizedBox(width: 8.0),
          Text(
            category.tipo,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }

  Widget _drawName(Category category) {
    return Container(
      child: Row(
        children: [
          SvgIconsApp.title,
          SizedBox(width: 6.0),
          Text(
            category.nombre,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
