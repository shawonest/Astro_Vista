import '../../../../core/resources/data_state.dart';
import '../entities/solar_notification.dart';
import '../repository/solar_repository.dart';

class GetSolarNotificationsUseCase {
  final SolarRepository _repository;

  GetSolarNotificationsUseCase(this._repository);

  Future<DataState<List<SolarNotification>>> call() {
    return _repository.getSolarNotifications();
  }
}