import 'package:dio/dio.dart';
import '../../models/astronomy_picture_model.dart';

class ApodApiService {
  final Dio _dio;
  final String _baseUrl = 'https://api.nasa.gov/planetary/apod';
  final String _apiKey = 'YfobCZGyTDXTQP9JfF3cAyoN9cxd2ktzBp2Z0zrr'; // Ideally, put this in an env file

  ApodApiService(this._dio);

  Future<Response> getApod({String? date}) async {
    final queryParameters = {
      'api_key': _apiKey,
    };

    // Add date to params if provided
    if (date != null) {
      queryParameters['date'] = date;
    }

    return await _dio.get(_baseUrl, queryParameters: queryParameters);
  }
}