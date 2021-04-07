import 'package:flutter_app_tenis/models/category_model.dart';
import 'package:flutter_app_tenis/providers/category_provider.dart';

class CategoryRepository {
  final CategoryProvider categoryProvider = CategoryProvider();

  Future<List<Category>> getCategories(String id) => categoryProvider.getCategories(id);
}
