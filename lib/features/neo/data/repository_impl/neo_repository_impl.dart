import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/entities/neo_entity.dart';
import '../../domain/repository/neo_repository.dart';
import '../datasources/local/neo_local_data_source.dart';
import '../datasources/remote/neo_api_service.dart';
import '../models/neo_model.dart';

class NeoRepositoryImpl implements NeoRepository {
  final NeoApiService _apiService;
  final NeoLocalDataSource _localDataSource;

  NeoRepositoryImpl(this._apiService, this._localDataSource);

  @override
  Future<DataState<List<NeoEntity>>> getNeoList() async {
    try {
      final httpResponse = await _apiService.getNeoFeed();

      if (httpResponse.statusCode == HttpStatus.ok) {
        final data = httpResponse.data;
        final nearEarthObjects = data['near_earth_objects'] as Map<String, dynamic>;

        List<NeoModel> neoList = [];

        // Iterate through dates keys and flatten the list
        nearEarthObjects.forEach((key, value) {
          final list = value as List;
          neoList.addAll(list.map((e) => NeoModel.fromJson(e)).toList());
        });

        // Cache the new list
        await _localDataSource.cacheNeoList(neoList);

        return DataSuccess(neoList);
      } else {
        return DataFailed(DioException(
            error: httpResponse.statusMessage,
            response: httpResponse,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.requestOptions));
      }
    } on DioException catch (e) {
      // Fetch from Cache if network fails
      final cachedList = _localDataSource.getNeoList();
      if (cachedList.isNotEmpty) {
        return DataSuccess(cachedList);
      }
      return DataFailed(e);
    }
  }
}