import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/blocs/sponsor_bloc.dart';
import 'package:flutter_app_tenis/styles/colors.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';
import 'package:flutter_app_tenis/styles/svgIcons.dart';
import 'package:flutter_app_tenis/utils/keyboard.dart';
import 'package:flutter_app_tenis/widgets/customButton.dart';
import 'package:flutter_app_tenis/widgets/custom_surfix_icon.dart';
import 'package:image_picker/image_picker.dart';

class FormAddSponsorPage extends StatefulWidget {
  final String idTournament;

  FormAddSponsorPage({Key key, this.idTournament}) : super(key: key);

  @override
  _FormAddSponsorPageState createState() => _FormAddSponsorPageState();
}

class _FormAddSponsorPageState extends State<FormAddSponsorPage> {
  SponsorBloc sponsorBloc = SponsorBloc();
  bool firstClick = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          _loadingIndicator(sponsorBloc),
          _drawForm(),
        ],
      ),
    );
  }

  Widget _drawForm() {
    return SingleChildScrollView(
      child: Container(
        width: SizeConfig.screenWidth * 0.85,
        child: Column(
          children: [
            SafeArea(
              child: Container(
                height: getProportionateScreenHeight(25.0),
              ),
            ),
            _drawTitleAdd(),
            SizedBox(height: 25.0),
            _drawFieldTitle(sponsorBloc),
            SizedBox(height: 10.0),
            _drawFieldImage(sponsorBloc),
            SizedBox(height: 25.0),
            _drawButtonSave(sponsorBloc),
            SizedBox(height: 25.0),
          ],
        ),
      ),
    );
  }

  Widget _drawTitleAdd() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "Agregar auspicio",
        style: Theme.of(context).textTheme.headline2.copyWith(color: ColorsApp.green),
      ),
    );
  }

  Widget _drawFieldTitle(SponsorBloc bloc) {
    return StreamBuilder<Object>(
      stream: bloc.title,
      builder: (context, snapshot) {
        return Container(
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: bloc.changeTitle,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Title.svg"),
              labelText: 'Nombre',
              hintText: 'Nombre del auspciante',
              errorText: snapshot.error,
            ),
          ),
        );
      },
    );
  }

  Widget _drawFieldImage(SponsorBloc bloc) {
    return StreamBuilder(
      stream: bloc.image,
      builder: (context, snapshot) {
        File img = snapshot.data;

        return Column(
          children: [
            SizedBox(height: 14.0),
            _drawLabelImg(context),
            SizedBox(height: 14.0),
            img != null ? _showImgSelected(img) : _showImgDefault(),
            SizedBox(height: 14.0),
            _drawButtonAddImg(context),
          ],
        );
      },
    );
  }

  Widget _drawButtonSave(SponsorBloc bloc) {
    return StreamBuilder<Object>(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return CustomButton(
          child: Text(
            'Guardar',
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: !snapshot.hasData
              ? null
              : !firstClick
                  ? () async {
                      setState(() => firstClick = true);
                      KeyboardUtil.hideKeyboard(context);
                      await bloc.addSponsor(int.parse(widget.idTournament));
                      String text = bloc.mssgValue;
                      var mssg = _showMessage(context, text);
                      await mssg.show();
                      await sponsorBloc.getSponsors(widget.idTournament);
                      Navigator.pop(context);
                    }
                  : null,
        );
      },
    );
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

  Widget _drawLabelImg(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: getProportionateScreenWidth(40.0)),
        Text(
          'Imagen',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _showImgDefault() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7.0),
      child: Image.asset(
        'assets/images/DefaultImg.jpg',
        width: double.infinity,
        height: getProportionateScreenHeight(130),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _showImgSelected(File img) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7.0),
      child: Image.file(
        img,
        width: double.infinity,
        height: 150.0,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _drawButtonAddImg(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      color: ColorsApp.orange,
      disabledColor: ColorsApp.blueObscuredOp50,
      child: SvgIconsApp.addImg,
      onPressed: _chooseFile,
    );
  }

  void _chooseFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) sponsorBloc.changeImg(File(pickedFile.path));
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
}
