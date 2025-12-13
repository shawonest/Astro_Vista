import '../../../../core/resources/data_state.dart';
import '../entities/neo_entity.dart';
import '../repository/neo_repository.dart';

class GetNeoListUseCase {
  final NeoRepository _repository;

  GetNeoListUseCase(this._repository);

  Future<DataState<List<NeoEntity>>> call() {
    return _repository.getNeoList();
  }
}