import 'package:hive_flutter/hive_flutter.dart';
import '../../models/solar_notification_model.dart';

abstract class SolarLocalDataSource {
  List<SolarNotificationModel> getNotifications();
  Future<void> cacheNotifications(List<SolarNotificationModel> list);
}

class SolarLocalDataSourceImpl implements SolarLocalDataSource {
  final Box<SolarNotificationModel> solarBox;

  SolarLocalDataSourceImpl({required this.solarBox});

  @override
  Future<void> cacheNotifications(List<SolarNotificationModel> list) async {
    await solarBox.clear();
    await solarBox.addAll(list);
  }

  @override
  List<SolarNotificationModel> getNotifications() {
    return solarBox.values.toList();
  }
}