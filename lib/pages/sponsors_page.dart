import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/blocs/sponsor_bloc.dart';
import 'package:flutter_app_tenis/models/sponsor_model.dart';
import 'package:flutter_app_tenis/styles/colors.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';
import 'package:flutter_app_tenis/styles/svgIcons.dart';
import 'package:flutter_app_tenis/pages/formAddSponsor_page.dart';

class SponsorsPage extends StatefulWidget {
  final String idTournament;

  SponsorsPage({Key key, this.idTournament}) : super(key: key);

  @override
  _SponsorsPageState createState() => _SponsorsPageState();
}

class _SponsorsPageState extends State<SponsorsPage> {
  SponsorBloc sponsorBloc = SponsorBloc();

  @override
  void initState() {
    sponsorBloc.getSponsors(widget.idTournament);
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
          _loadingIndicator(sponsorBloc),
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
                .then((value) => sponsorBloc.getSponsors(widget.idTournament));
          }),
    );
  }

  Widget _loadingIndicator(SponsorBloc bloc) {
    return StreamBuilder<bool>(
      stream: bloc.loading,
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
      stream: sponsorBloc.sponsors,
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

  Widget _drawSponsors(List<Sponsor> data) {
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

  Widget _getSponsors(Sponsor sponsor) {
    return Card(
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(18.0)),
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: _drawInfoCard(sponsor),
    );
  }

  Widget _drawInfoCard(Sponsor sponsor) {
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

  Widget _drawImg(Sponsor sponsor) {
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

  Widget _drawButtonDelete(Sponsor sponsor) {
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

  void _areYouSureToDelete(Sponsor sponsor) {
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
          await sponsorBloc.deleteSponsor(sponsor.id, sponsor.urlImg);
          String text = sponsorBloc.mssgValue;
          var mssg = _showMessage(context, text);
          await sponsorBloc.getSponsors(widget.idTournament);
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
