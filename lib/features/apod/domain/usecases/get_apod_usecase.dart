import '../../../../core/resources/data_state.dart';
import '../entities/astronomy_picture.dart';
import '../repository/apod_repository.dart';

class GetApodUseCase {
  final ApodRepository _apodRepository;

  GetApodUseCase(this._apodRepository);

  Future<DataState<AstronomyPicture>> call({String? date}) {
    return _apodRepository.getAstronomyPicture(date: date);
  }
}