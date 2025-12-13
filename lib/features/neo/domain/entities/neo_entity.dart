import 'package:equatable/equatable.dart';

class NeoEntity extends Equatable {
  final String id;
  final String name;
  final String absoluteMagnitude;
  final bool isHazardous;
  final String closeApproachDate;
  final String missDistanceKm;
  final String diameterMaxKm;

  const NeoEntity({
    required this.id,
    required this.name,
    required this.absoluteMagnitude,
    required this.isHazardous,
    required this.closeApproachDate,
    required this.missDistanceKm,
    required this.diameterMaxKm,
  });

  @override
  List<Object?> get props => [id, name, isHazardous, closeApproachDate];
}