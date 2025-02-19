class ChatModel {
  final String rideId;
  final String sender;
  final String receiver;
  final String message;
  final DateTime timestamp;

  ChatModel({
    required this.rideId,
    required this.sender,
    required this.receiver,
    required this.message,
    required this.timestamp,
  });

  factory ChatModel.fromJson(json) {
    return ChatModel(
      rideId: json['rideId'] ?? "",
      sender: json['sender'] ?? "",
      receiver: json['receiver'] ?? "",
      message: json['message'] ?? "",
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
  @override
  String toString() {
    return '''ChatModel(rideId: $rideId, 
    sender: $sender, 
    receiver: $receiver, 
    message: $message, 
    timestamp: $timestamp)''';
  }
}
