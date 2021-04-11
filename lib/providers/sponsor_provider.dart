import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:flutter_app_tenis/models/sponsor_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SponsorProvider {
  final databaseReference = Firestore.instance;

  Future<List<Sponsor>> getSponsors(String idTournament) async {
    try {
      var data = (await databaseReference
              .collection("sponsors")
              .where("id_torneo", isEqualTo: int.parse(idTournament))
              .getDocuments())
          .documents
          .toList();
      final auspices = new Sponsors.fromJsonList(data);
      return auspices.items;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String> addSponsor(Sponsor sponsor, File img) async {
    try {
      StorageReference storageReference =
          FirebaseStorage.instance.ref().child('auspicios/${Path.basename(img.path)}');
      StorageUploadTask uploadTask = storageReference.putFile(img);
      var url = await (await uploadTask.onComplete).ref.getDownloadURL();
      String uploadedFileURL = url.toString();

      await databaseReference.collection("sponsors").add({
        'auspiciante': sponsor.auspiciante,
        'nombre_img': img.toString(),
        'url_img': uploadedFileURL,
        'id_torneo': sponsor.idTorneo
      });

      return "Auspcio Agregado";
    } catch (e) {
      print(e);
      return "Ocurrio un error";
    }
  }

  Future<String> deleteSponsor(String idSponsor, String urlImg) async {
    try {
      FirebaseStorage.instance.getReferenceFromUrl(urlImg).then((res) {
        res.delete().then((res) {
          print("borrado!");
        });
      });

      await databaseReference.collection('sponsors').document(idSponsor).delete();
      return "Auspicio Eliminado";
    } catch (e) {
      print(e);
      return "Ocurrio un error";
    }
  }
}
