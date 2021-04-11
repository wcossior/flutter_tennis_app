import 'dart:io';
import 'package:flutter_app_tenis/blocs/validators/validators.dart';
import 'package:flutter_app_tenis/models/sponsor_model.dart';
import 'package:flutter_app_tenis/repositories/sponsor_repository.dart';
import 'package:rxdart/rxdart.dart';

class SponsorBloc extends Validators {
  SponsorRepository repository = SponsorRepository();

  final BehaviorSubject<List<Sponsor>> _sponsors = BehaviorSubject<List<Sponsor>>();
  Observable<List<Sponsor>> get sponsors => _sponsors.stream;
  Function(List<Sponsor>) get changeSponsors => _sponsors.sink.add;

  final BehaviorSubject<String> _sponsorsMessage = BehaviorSubject<String>();
  Observable<String> get sponsorsMessage => _sponsorsMessage.stream;
  Function(String) get changeSponsorsMessage => _sponsorsMessage.sink.add;

  final BehaviorSubject<String> _titleController = BehaviorSubject<String>();
  final BehaviorSubject<File> _imgController = BehaviorSubject<File>();
  final PublishSubject _loadingData = PublishSubject<bool>();

  Function(String) get changeTitle => _titleController.sink.add;
  Function(File) get changeImg => _imgController.sink.add;

  Stream<String> get title => _titleController.stream.transform(validateName);
  Stream<File> get image => _imgController.stream.transform(validateImg);
  Stream<bool> get submitValid => Observable.combineLatest2(title, image, (title, image) => true);

  Observable<bool> get loading => _loadingData.stream;

  String get mssgValue => _sponsorsMessage.value;
  List<Sponsor> get listSponsors => _sponsors.value;

  void dispose() {
    _sponsors.close();
    _sponsorsMessage.close();
    _titleController.close();
    _imgController.close();
    _loadingData.close();
  }

  Future getSponsors(String idTournament) async {
    await repository.getSponsors(idTournament);
    changeSponsors(repository.list);
  }

  Future addSponsor(int idTournament) async {
    Sponsor sp = Sponsor();
    sp.idTorneo = idTournament;
    sp.auspiciante = _titleController.value;
    File img = _imgController.value;

    _loadingData.sink.add(true);
    String resp = await repository.addSponsor(sp, img);
    changeSponsorsMessage(resp);
    _loadingData.sink.add(false);
  }

  Future deleteSponsor(String idSponsor, String urlImg) async {
    _loadingData.sink.add(true);
    String resp = await repository.deleteSponsor(idSponsor, urlImg);
    changeSponsorsMessage(resp);
    _loadingData.sink.add(false);
  }
}
