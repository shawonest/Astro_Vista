import '../../../../core/resources/data_state.dart';
import '../entities/solar_notification.dart';

abstract class SolarRepository {
  Future<DataState<List<SolarNotification>>> getSolarNotifications();
}
