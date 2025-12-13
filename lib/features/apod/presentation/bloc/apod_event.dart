abstract class ApodEvent {
  const ApodEvent();
}

class GetApod extends ApodEvent {
  final String? date;
  const GetApod({this.date});
}