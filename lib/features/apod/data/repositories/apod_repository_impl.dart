import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/entities/astronomy_picture.dart';
import '../../domain/repository/apod_repository.dart';
import '../datasources/local/apod_local_data_source.dart';
import '../datasources/remote/apod_api_service.dart';
import '../models/astronomy_picture_model.dart';

class ApodRepositoryImpl implements ApodRepository {
  final ApodApiService _apiService;
  final ApodLocalDataSource _localDataSource;

  ApodRepositoryImpl(this._apiService, this._localDataSource);

  @override
  Future<DataState<AstronomyPicture>> getAstronomyPicture({String? date}) async {
    try {
      // 1. Attempt to fetch from Network
      final httpResponse = await _apiService.getApod(date: date);

      if (httpResponse.statusCode == HttpStatus.ok) {
        final model = AstronomyPictureModel.fromJson(httpResponse.data);

        // 2. If successful, cache the data locally
        await _localDataSource.cacheApod(model);

        return DataSuccess(model);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.statusMessage,
            response: httpResponse,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      // 3. If Network fails, try to fetch from Local Cache
      try {
        final cachedApod = await _localDataSource.getLastApod();
        if (cachedApod != null) {
          // You might want to indicate this is cached data in the UI
          return DataSuccess(cachedApod);
        }
      } catch (cacheError) {
        // Fallthrough to return the original network error
      }
      return DataFailed(e);
    }
  }
}