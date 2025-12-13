import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/usecases/get_apod_usecase.dart';
import 'apod_event.dart';
import 'apod_state.dart';

class ApodBloc extends Bloc<ApodEvent, ApodState> {
  final GetApodUseCase _getApodUseCase;

  ApodBloc(this._getApodUseCase) : super(const ApodLoading()) {
    on<GetApod>(onGetApod);
  }

  void onGetApod(GetApod event, Emitter<ApodState> emit) async {
    emit(const ApodLoading());

    final dataState = await _getApodUseCase(date: event.date);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(ApodLoaded(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(ApodError(dataState.error!));
    }
  }
}