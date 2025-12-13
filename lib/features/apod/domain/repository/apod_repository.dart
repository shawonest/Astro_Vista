import 'package:aestro_vista/core/resources/data_state.dart';

import '../entities/astronomy_picture.dart';

abstract class ApodRepository {
  // Returns DataState wrapping the Entity
  Future<DataState<AstronomyPicture>> getAstronomyPicture({String? date});
}