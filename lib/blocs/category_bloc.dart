import 'package:flutter_app_tenis/models/auspice_model.dart';
import 'package:flutter_app_tenis/repositories/auspice_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_app_tenis/models/category_model.dart';
import 'package:flutter_app_tenis/repositories/category_repository.dart';

class CategoryBloc {
  CategoryRepository repository = CategoryRepository();
  AuspiceRepository auspiceRepository = AuspiceRepository();

  final BehaviorSubject<List<Auspice>> _auspiceControler = BehaviorSubject<List<Auspice>>();
  Observable<List<Auspice>> get auspices => _auspiceControler.stream;
  Function(List<Auspice>) get sinkAuspices => _auspiceControler.sink.add;

  final BehaviorSubject<List<Category>> _categoryController = BehaviorSubject<List<Category>>();
  Observable<List<Category>> get streamCategory => _categoryController.stream;
  Function(List<Category>) get sinkCategory => _categoryController.sink.add;

  void dispose() {
    _categoryController.close();
    _auspiceControler.close();
  }

  void getCategories(String idTorneo) async {
    List<Category> data = await repository.getCategories(idTorneo);
    sinkCategory(data);
  }

  void getAuspicesDataUpdate(){
    sinkAuspices(auspiceRepository.list);
  }

  void getAuspices(String idTournament) async{
    await auspiceRepository.getAuspices(idTournament);
    sinkAuspices(auspiceRepository.list);
  }
}
