import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/blocs/auspice_bloc.dart';
import 'package:flutter_app_tenis/models/auspice_model.dart';
import 'package:flutter_app_tenis/styles/colors.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';
import 'package:flutter_app_tenis/styles/svgIcons.dart';
import 'package:flutter_app_tenis/pages/formAddSponsor_page.dart';

class AuspicePage extends StatefulWidget {
  final String idTournament;

  AuspicePage({Key key, this.idTournament}) : super(key: key);

  @override
  _AuspicePageState createState() => _AuspicePageState();
}

class _AuspicePageState extends State<AuspicePage> {
  AuspiceBloc auspiceBloc = AuspiceBloc();

  @override
  void initState() {
    auspiceBloc.getAuspicesDataUpdate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aupicios", style: Theme.of(context).textTheme.subtitle2),
      ),
      body: Stack(
        children: [
          _drawContent(),
          _loadingIndicator(auspiceBloc),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: SvgIconsApp.formAdd,
          onPressed: () {
            return Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (context) => FormAddSponsorPage(
                      idTournament: widget.idTournament,
                    ),
                  ),
                )
                .then((value) => auspiceBloc.getAuspices(widget.idTournament));
          }),
    );
  }

  Widget _loadingIndicator(AuspiceBloc bloc) {
    return StreamBuilder<bool>(
      stream: bloc.streamLoading,
      builder: (context, snap) {
        return Container(
          child: Center(
            child: (snap.hasData && snap.data) ? CircularProgressIndicator() : null,
          ),
        );
      },
    );
  }

  Widget _drawContent() {
    return StreamBuilder(
      stream: auspiceBloc.streamAuspice,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.isNotEmpty) {
          return _drawSponsors(snapshot.data);
        }
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(child: Text("No hay auspicios"));
        }
      },
    );
  }

  Widget _drawSponsors(List<Auspice> data) {
    return ListView.builder(
      padding: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.055,
        right: SizeConfig.screenWidth * 0.055,
        top: SizeConfig.screenHeight * 0.025,
      ),
      itemBuilder: (ctx, index) {
        return _getSponsors(data[index]);
      },
      itemCount: data.length,
    );
  }

  Widget _getSponsors(Auspice sponsor) {
    return Card(
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(18.0)),
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: _drawInfoCard(sponsor),
    );
  }

  Widget _drawInfoCard(Auspice sponsor) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            _drawImg(sponsor),
            _drawButtonDelete(sponsor),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10.0)),
          child: Text(
            sponsor.auspiciante,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        )
      ],
    );
  }

  Widget _drawImg(Auspice sponsor) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(7.0)),
      child: FadeInImage(
        width: double.infinity,
        height: getProportionateScreenHeight(140),
        placeholder: AssetImage("assets/images/LoadingImg.gif"),
        fadeInDuration: Duration(milliseconds: 200),
        image: NetworkImage(sponsor.urlImg),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _drawButtonDelete(Auspice sponsor) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(100.0),
        topRight: Radius.circular(7.0),
      ),
      child: Container(
        alignment: Alignment.topRight,
        width: getProportionateScreenWidth(65),
        height: getProportionateScreenHeight(65),
        color: ColorsApp.white,
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(12.0),
          horizontal: getProportionateScreenWidth(15.0),
        ),
        child: GestureDetector(
          onTap: () => _areYouSureToDelete(sponsor),
          child: SvgIconsApp.delete,
        ),
      ),
    );
  }

  void _areYouSureToDelete(Auspice sponsor) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        headerAnimationLoop: true,
        animType: AnimType.BOTTOMSLIDE,
        showCloseIcon: false,
        closeIcon: Icon(Icons.close_fullscreen_outlined),
        title: 'Eliminar Auspicio',
        desc: '¿Esta seguro de eliminar?',
        btnOkText: "Si",
        btnOkColor: ColorsApp.orange,
        btnCancelText: "No",
        btnCancelColor: ColorsApp.green,
        btnCancelOnPress: () {},
        btnOkOnPress: () async {
          await auspiceBloc.deleteAuspice(sponsor.id, sponsor.urlImg);
          String text = auspiceBloc.valueMessage;
          var mssg = _showMessage(context, text);
          auspiceBloc.getAuspices(widget.idTournament);
          await mssg.show();
        })
      ..show();
  }

  AwesomeDialog _showMessage(BuildContext context, String mssg) {
    return AwesomeDialog(
      context: context,
      dialogType: mssg.contains("error") ? DialogType.ERROR : DialogType.SUCCES,
      animType: AnimType.SCALE,
      title: mssg,
      desc: "",
      autoHide: Duration(seconds: 4),
    );
  }
}
