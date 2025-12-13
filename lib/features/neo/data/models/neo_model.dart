import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/neo_entity.dart';

part 'neo_model.g.dart'; // Run build_runner to generate this

@HiveType(typeId: 1) // Unique ID for Hive
class NeoModel extends NeoEntity {

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String absoluteMagnitude;
  @HiveField(3)
  final bool isHazardous;
  @HiveField(4)
  final String closeApproachDate;
  @HiveField(5)
  final String missDistanceKm;
  @HiveField(6)
  final String diameterMaxKm;

  const NeoModel({
    required this.id,
    required this.name,
    required this.absoluteMagnitude,
    required this.isHazardous,
    required this.closeApproachDate,
    required this.missDistanceKm,
    required this.diameterMaxKm,
  }) : super(
    id: id,
    name: name,
    absoluteMagnitude: absoluteMagnitude,
    isHazardous: isHazardous,
    closeApproachDate: closeApproachDate,
    missDistanceKm: missDistanceKm,
    diameterMaxKm: diameterMaxKm,
  );

  factory NeoModel.fromJson(Map<String, dynamic> json) {
    // Helper to safely get nested data
    final closeApproach = (json['close_approach_data'] as List).isNotEmpty
        ? json['close_approach_data'][0]
        : null;

    final diameter = json['estimated_diameter']['kilometers'];

    return NeoModel(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      absoluteMagnitude: (json['absolute_magnitude_h'] ?? 0).toString(),
      isHazardous: json['is_potentially_hazardous_asteroid'] ?? false,
      closeApproachDate: closeApproach != null ? closeApproach['close_approach_date'] : 'Unknown',
      missDistanceKm: closeApproach != null ? closeApproach['miss_distance']['kilometers'] : '0',
      diameterMaxKm: diameter != null ? diameter['estimated_diameter_max'].toString() : '0',
    );
  }
}