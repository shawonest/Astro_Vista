import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/astronomy_picture.dart';

abstract class ApodState extends Equatable {
  final AstronomyPicture? apod;
  final DioException? error;

  const ApodState({this.apod, this.error});

  @override
  List<Object?> get props => [apod, error];
}

class ApodLoading extends ApodState {
  const ApodLoading();
}

class ApodLoaded extends ApodState {
  const ApodLoaded(AstronomyPicture apod) : super(apod: apod);
}

class ApodError extends ApodState {
  const ApodError(DioException error) : super(error: error);
}