// States
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/neo_entity.dart';

abstract class NeoState extends Equatable {
  final List<NeoEntity>? neos;
  final DioException? error;
  const NeoState({this.neos, this.error});

  @override
  List<Object?> get props => [neos, error];
}

class NeoLoading extends NeoState {}

class NeoLoaded extends NeoState {
  const NeoLoaded(List<NeoEntity> neos) : super(neos: neos);
}

class NeoError extends NeoState {
  const NeoError(DioException error) : super(error: error);
}