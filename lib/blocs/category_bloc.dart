import 'package:rxdart/rxdart.dart';
import 'package:flutter_app_tenis/models/category_model.dart';
import 'package:flutter_app_tenis/repositories/category_repository.dart';

class CategoryBloc {
  CategoryRepository repository = CategoryRepository();

  final BehaviorSubject<List<Category>> _category = BehaviorSubject<List<Category>>();
  Observable<List<Category>> get category => _category.stream;
  Function(List<Category>) get changeCategory => _category.sink.add;

  void dispose() {
    _category.close();
  }

  void getCategories(String idTorneo) async {
    List<Category> data = await repository.getCategories(idTorneo);
    changeCategory(data);
  }
}
