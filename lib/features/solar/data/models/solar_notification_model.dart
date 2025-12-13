import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/solar_notification.dart';

part 'solar_notification_model.g.dart';

// We use typeId: 2 because 0 is APOD and 1 is NEO
@HiveType(typeId: 2)
class SolarNotificationModel extends SolarNotification {

  @HiveField(0)
  final String messageType;
  @HiveField(1)
  final String messageID;
  @HiveField(2)
  final String messageURL;
  @HiveField(3)
  final String messageIssueTime;
  @HiveField(4)
  final String messageBody;

  const SolarNotificationModel({
    required this.messageType,
    required this.messageID,
    required this.messageURL,
    required this.messageIssueTime,
    required this.messageBody,
  }) : super(
    messageType: messageType,
    messageID: messageID,
    messageURL: messageURL,
    messageIssueTime: messageIssueTime,
    messageBody: messageBody,
  );

  factory SolarNotificationModel.fromJson(Map<String, dynamic> json) {
    return SolarNotificationModel(
      messageType: json['messageType'] ?? "UNKNOWN",
      messageID: json['messageID'] ?? "",
      messageURL: json['messageURL'] ?? "",
      messageIssueTime: json['messageIssueTime'] ?? "",
      messageBody: json['messageBody'] ?? "",
    );
  }
}