import 'package:equatable/equatable.dart';

class AstronomyPicture extends Equatable {
  final String? copyright;
  final String? date;
  final String? explanation;
  final String? hdUrl;
  final String? mediaType;
  final String? title;
  final String? url;

  const AstronomyPicture({
    this.copyright,
    this.date,
    this.explanation,
    this.hdUrl,
    this.mediaType,
    this.title,
    this.url,
  });

  @override
  List<Object?> get props => [
        copyright,
        date,
        explanation,
        hdUrl,
        mediaType,
        title,
        url,
      ];
}