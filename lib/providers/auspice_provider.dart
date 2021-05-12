import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:flutter_app_tenis/models/auspice_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuspiceProvider {
  final databaseReference = Firestore.instance;

  Future<List<Auspice>> getAuspices(String idTournament) async {
    try {
      var data = (await databaseReference
              .collection("sponsors")
              .where("id_torneo", isEqualTo: int.parse(idTournament))
              .getDocuments())
          .documents
          .toList();
      final auspices = new Auspices.fromJsonList(data);
      return auspices.items;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String> addAuspice(Auspice auspice, File img) async {
    try {
      StorageReference storageReference =
          FirebaseStorage.instance.ref().child('auspicios/${Path.basename(img.path)}');
      StorageUploadTask uploadTask = storageReference.putFile(img);
      var url = await (await uploadTask.onComplete).ref.getDownloadURL();
      String uploadedFileURL = url.toString();

      await databaseReference.collection("sponsors").add({
        'auspiciante': auspice.auspiciante,
        'nombre_img': img.toString(),
        'url_img': uploadedFileURL,
        'id_torneo': auspice.idTorneo
      });

      return "Auspcio agregado";
    } catch (e) {
      print(e);
      return "Ocurrio un error";
    }
  }

  Future<String> deleteAuspice(String idAuspice, String urlImg) async {
    try {
      FirebaseStorage.instance.getReferenceFromUrl(urlImg).then((res) {
        res.delete().then((res) {
          print("borrado!");
        });
      });

      await databaseReference.collection('sponsors').document(idAuspice).delete();
      return "Auspicio eliminado";
    } catch (e) {
      print(e);
      return "Ocurrio un error";
    }
  }
}
