import 'package:equatable/equatable.dart';

class SolarNotification extends Equatable {
  final String messageType;
  final String messageID;
  final String messageURL;
  final String messageIssueTime;
  final String messageBody;

  const SolarNotification({
    required this.messageType,
    required this.messageID,
    required this.messageURL,
    required this.messageIssueTime,
    required this.messageBody,
  });

  @override
  List<Object?> get props => [messageID, messageType, messageIssueTime];
}