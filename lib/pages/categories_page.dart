import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/blocs/category_bloc.dart';
import 'package:flutter_app_tenis/models/category_model.dart';
import 'package:flutter_app_tenis/models/sponsor_model.dart';
import 'package:flutter_app_tenis/widgets/bottomSlider.dart';
import 'package:flutter_app_tenis/widgets/categoryCard.dart';
import 'package:flutter_app_tenis/pages/sponsors_page.dart';
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
  int currentIndex = 0;

  @override
  void initState() {
    categBloc.getCategories(widget.idTournament);
    categBloc.getSponsors(widget.idTournament);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            onTap: () => Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (context) => SponsorsPage(
                      idTournament: widget.idTournament,
                    ),
                  ),
                )
                .then((value) => categBloc.getSponsorsDataUpdate()),
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
          return BottomSlider(sponsors: snapshot.data);
        } else {
          return Container();
        }
      },
    );
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
      children: _getCards(data),
    );
  }

  List<Widget> _getCards(List<Category> data) {
    final List<Widget> drawnCategories = [];
    final cateogyList = data;

    cateogyList.forEach((category) {
      final widgetTemp = CategoryCard(category: category);
      drawnCategories.add(widgetTemp);
    });
    return drawnCategories;
  }
}
