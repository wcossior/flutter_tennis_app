import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/models/category_model.dart';
import 'package:flutter_app_tenis/pages/games_page.dart';
import 'package:flutter_app_tenis/styles/colors.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';
import 'package:flutter_app_tenis/styles/svgIcons.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Column(
        children: [
          _drawInfoCard(category, context),
          Divider(thickness: 1.2, color: ColorsApp.greyObscured),
          _drawOptions(category, context)
        ],
      ),
    );
  }

  Widget _drawOptions(Category category, BuildContext context) {
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
          _drawOptionPlayoffs(category.id, context),
          if (category.tipo == "Round Robin") _drawOptionGroups(category.id, context),
        ],
      ),
    );
  }

  Widget _drawOptionGroups(String idCategory, BuildContext context) {
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

  Row _drawOptionPlayoffs(String idCategory,  BuildContext context) {
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

  Widget _drawInfoCard(Category category, BuildContext context) {
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
                _drawName(category, context),
                Divider(thickness: 1.2, color: ColorsApp.greyObscured, endIndent: 15.0),
                _drawType(category, context),
                Divider(thickness: 1.2, color: ColorsApp.greyObscured, endIndent: 15.0),
                _drawNumberPlayers(category, context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawNumberPlayers(Category category,  BuildContext context) {
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

  Widget _drawType(Category category,  BuildContext context) {
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

  Widget _drawName(Category category,  BuildContext context) {
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
