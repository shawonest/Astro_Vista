import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/use_case/get_neo_list_usecase.dart';
import 'neo_events.dart';
import 'neo_state.dart';

// Bloc
class NeoBloc extends Bloc<NeoEvent, NeoState> {
  final GetNeoListUseCase _getNeoListUseCase;

  NeoBloc(this._getNeoListUseCase) : super(NeoLoading()) {
    on<GetNeoList>(onGetNeoList);
  }

  void onGetNeoList(GetNeoList event, Emitter<NeoState> emit) async {
    final dataState = await _getNeoListUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(NeoLoaded(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(NeoError(dataState.error!));
    }
  }
}