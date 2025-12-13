import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class NeoApiService {
  final Dio _dio;
  final String _baseUrl = 'https://api.nasa.gov/neo/rest/v1/feed';
  final String _apiKey = 'YfobCZGyTDXTQP9JfF3cAyoN9cxd2ktzBp2Z0zrr';

  NeoApiService(this._dio);

  Future<Response> getNeoFeed() async {
    // Get current date formatted as YYYY-MM-DD
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final queryParameters = {
      'start_date': today,
      'end_date': today, // Just fetch today for simplicity
      'api_key': _apiKey,
    };

    return await _dio.get(_baseUrl, queryParameters: queryParameters);
  }
}