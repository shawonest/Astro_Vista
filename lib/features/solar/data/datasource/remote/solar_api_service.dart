import 'package:dio/dio.dart';

class SolarApiService {
  final Dio _dio;
  final String _baseUrl = 'https://api.nasa.gov/DONKI/notifications';
  final String _apiKey = 'YfobCZGyTDXTQP9JfF3cAyoN9cxd2ktzBp2Z0zrr';

  SolarApiService(this._dio);

  Future<Response> getNotifications() async {
    final queryParameters = {
      'type': 'all',
      'api_key': _apiKey,
    };
    return await _dio.get(_baseUrl, queryParameters: queryParameters);
  }
}