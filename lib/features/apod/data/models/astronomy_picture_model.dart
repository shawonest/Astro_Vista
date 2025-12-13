import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/astronomy_picture.dart';

part 'astronomy_picture_model.g.dart';

@HiveType(typeId: 0)
class AstronomyPictureModel extends AstronomyPicture {
  
  @HiveField(0)
  final String? copyright;
  @HiveField(1)
  final String? date;
  @HiveField(2)
  final String? explanation;
  @HiveField(3)
  final String? hdUrl;
  @HiveField(4)
  final String? mediaType;
  @HiveField(5)
  final String? title;
  @HiveField(6)
  final String? url;

  const AstronomyPictureModel({
    this.copyright,
    this.date,
    this.explanation,
    this.hdUrl,
    this.mediaType,
    this.title,
    this.url,
  }) : super(
          copyright: copyright,
          date: date,
          explanation: explanation,
          hdUrl: hdUrl,
          mediaType: mediaType,
          title: title,
          url: url,
        );

  factory AstronomyPictureModel.fromJson(Map<String, dynamic> map) {
    return AstronomyPictureModel(
      copyright: map['copyright'] ?? "",
      date: map['date'] ?? "",
      explanation: map['explanation'] ?? "",
      hdUrl: map['hdurl'] ?? "",
      mediaType: map['media_type'] ?? "",
      title: map['title'] ?? "",
      url: map['url'] ?? "",
    );
  }
}