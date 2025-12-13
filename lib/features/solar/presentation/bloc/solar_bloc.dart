import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/entities/solar_notification.dart';
import '../../domain/use_case/get_solar_notifications_usecase.dart';

// Events
abstract class SolarEvent extends Equatable {
  const SolarEvent();
  @override
  List<Object> get props => [];
}

class GetSolarNotifications extends SolarEvent {}

// States
abstract class SolarState extends Equatable {
  final List<SolarNotification>? notifications;
  final DioException? error;
  const SolarState({this.notifications, this.error});

  @override
  List<Object?> get props => [notifications, error];
}

class SolarLoading extends SolarState {}

class SolarLoaded extends SolarState {
  const SolarLoaded(List<SolarNotification> notifications) : super(notifications: notifications);
}

class SolarError extends SolarState {
  const SolarError(DioException error) : super(error: error);
}

// Bloc
class SolarBloc extends Bloc<SolarEvent, SolarState> {
  final GetSolarNotificationsUseCase _useCase;

  SolarBloc(this._useCase) : super(SolarLoading()) {
    on<GetSolarNotifications>(onGetSolarNotifications);
  }

  void onGetSolarNotifications(GetSolarNotifications event, Emitter<SolarState> emit) async {
    final dataState = await _useCase();

    if (dataState is DataSuccess && dataState.data != null) {
      emit(SolarLoaded(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(SolarError(dataState.error!));
    }
  }
}