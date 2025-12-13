import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/entities/solar_notification.dart';
import '../../domain/repository/solar_repository.dart';
import '../datasource/local/solar_local_data_source.dart';
import '../datasource/remote/solar_api_service.dart';
import '../models/solar_notification_model.dart';

class SolarRepositoryImpl implements SolarRepository {
  final SolarApiService _apiService;
  final SolarLocalDataSource _localDataSource;

  SolarRepositoryImpl(this._apiService, this._localDataSource);

  @override
  Future<DataState<List<SolarNotification>>> getSolarNotifications() async {
    try {
      final httpResponse = await _apiService.getNotifications();

      if (httpResponse.statusCode == HttpStatus.ok) {
        List<SolarNotificationModel> notifications = (httpResponse.data as List)
            .map((e) => SolarNotificationModel.fromJson(e))
            .toList();

        // Cache data
        await _localDataSource.cacheNotifications(notifications);

        return DataSuccess(notifications);
      } else {
        return DataFailed(DioException(
            error: httpResponse.statusMessage,
            response: httpResponse,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.requestOptions));
      }
    } on DioException catch (e) {
      // Fallback to cache
      final cached = _localDataSource.getNotifications();
      if (cached.isNotEmpty) {
        return DataSuccess(cached);
      }
      return DataFailed(e);
    }
  }
}