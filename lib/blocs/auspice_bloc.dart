import 'dart:io';
import 'package:flutter_app_tenis/validators/validators.dart';
import 'package:flutter_app_tenis/models/auspice_model.dart';
import 'package:flutter_app_tenis/repositories/auspice_repository.dart';
import 'package:rxdart/rxdart.dart';

class AuspiceBloc extends Validators {
  AuspiceRepository repository = AuspiceRepository();

  final BehaviorSubject<List<Auspice>> _auspiceController = BehaviorSubject<List<Auspice>>();
  Observable<List<Auspice>> get streamAuspice => _auspiceController.stream;
  Function(List<Auspice>) get sinkAuspice => _auspiceController.sink.add;

  final BehaviorSubject<String> _messageController = BehaviorSubject<String>();
  Observable<String> get streamMessage => _messageController.stream;
  Function(String) get sinkMessage => _messageController.sink.add;

  final BehaviorSubject<String> _titleController = BehaviorSubject<String>();
  final BehaviorSubject<File> _imgController = BehaviorSubject<File>();
  final PublishSubject _loadingController = PublishSubject<bool>();

  Function(String) get sinkTitle => _titleController.sink.add;
  Function(File) get sinkImg => _imgController.sink.add;

  Stream<String> get streamTitle => _titleController.stream.transform(validateName);
  Stream<File> get streamImage => _imgController.stream.transform(validateImg);
  Stream<bool> get streamSubmitValid => Observable.combineLatest2(streamTitle, streamImage, (title, image) => true);

  Observable<bool> get streamLoading => _loadingController.stream;

  String get valueMessage => _messageController.value;

  void dispose() {
    _auspiceController.close();
    _messageController.close();
    _titleController.close();
    _imgController.close();
    _loadingController.close();
  }

  Future getAuspices(String idTournament) async {
    await repository.getAuspices(idTournament);
    sinkAuspice(repository.list);
  }

  void getAuspicesDataUpdate(){
    sinkAuspice(repository.list);
  }

  Future addAuspice(int idTournament) async {
    Auspice sp = Auspice();
    sp.idTorneo = idTournament;
    sp.auspiciante = _titleController.value;
    File img = _imgController.value;

    _loadingController.sink.add(true);
    String resp = await repository.addAuspice(sp, img);
    sinkMessage(resp);
    _loadingController.sink.add(false);
  }

  Future deleteAuspice(String idAuspice, String urlImg) async {
    _loadingController.sink.add(true);
    String resp = await repository.deleteAuspice(idAuspice, urlImg);
    sinkMessage(resp);
    _loadingController.sink.add(false);
  }
}
