import '../../../../core/resources/data_state.dart';
import '../entities/neo_entity.dart';

abstract class NeoRepository {
  Future<DataState<List<NeoEntity>>> getNeoList();
}