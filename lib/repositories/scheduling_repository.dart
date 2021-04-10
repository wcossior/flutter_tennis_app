import 'package:flutter_app_tenis/models/scheduling_model.dart';
import 'package:flutter_app_tenis/providers/scheduling_provider.dart';

class SchedulingRepository {
  final SchedulingProvider schedulingProvider = SchedulingProvider();

  Future<List<Event>> getScheduling(String id) => schedulingProvider.getScheduling(id);
}
