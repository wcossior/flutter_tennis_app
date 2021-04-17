import 'package:flutter_app_tenis/models/sponsor_model.dart';
import 'package:flutter_app_tenis/repositories/sponsor_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_app_tenis/models/category_model.dart';
import 'package:flutter_app_tenis/repositories/category_repository.dart';

class CategoryBloc {
  CategoryRepository repository = CategoryRepository();
  SponsorRepository sponRepo = SponsorRepository();

  final BehaviorSubject<List<Sponsor>> _sponsors = BehaviorSubject<List<Sponsor>>();
  Observable<List<Sponsor>> get sponsors => _sponsors.stream;
  Function(List<Sponsor>) get changeSponsors => _sponsors.sink.add;

  final BehaviorSubject<List<Category>> _category = BehaviorSubject<List<Category>>();
  Observable<List<Category>> get category => _category.stream;
  Function(List<Category>) get changeCategory => _category.sink.add;

  void dispose() {
    _category.close();
    _sponsors.close();
  }

  void getCategories(String idTorneo) async {
    List<Category> data = await repository.getCategories(idTorneo);
    changeCategory(data);
  }

  void getSponsorsDataUpdate(){
    changeSponsors(sponRepo.list);
  }

  void getSponsors(String idTournament) async{
    await sponRepo.getSponsors(idTournament);
    changeSponsors(sponRepo.list);
  }
}
