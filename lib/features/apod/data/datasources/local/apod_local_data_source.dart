import 'package:hive_flutter/hive_flutter.dart';
import '../../models/astronomy_picture_model.dart';

abstract class ApodLocalDataSource {
  Future<AstronomyPictureModel?> getLastApod();
  Future<void> cacheApod(AstronomyPictureModel apod);
}

class ApodLocalDataSourceImpl implements ApodLocalDataSource {
  final Box<AstronomyPictureModel> apodBox;

  ApodLocalDataSourceImpl({required this.apodBox});

  @override
  Future<void> cacheApod(AstronomyPictureModel apod) async {
    // We store it with a specific key 'current_apod'
    await apodBox.put('current_apod', apod);
  }

  @override
  Future<AstronomyPictureModel?> getLastApod() async {
    return apodBox.get('current_apod');
  }
}