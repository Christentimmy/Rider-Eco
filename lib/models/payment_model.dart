import 'package:rider/models/ride_model.dart';

class PaymentModel {
  final String id;
  final String userId;
  final Ride ride;
  final double amount;
  final String transactionId;
  final String status;
  final DateTime? createdAt;
  final DateTime? processedAt;

  PaymentModel({
    required this.id,
    required this.userId,
    required this.ride,
    required this.amount,
    required this.transactionId,
    required this.status,
    required this.createdAt,
    this.processedAt,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json["_id"] ?? "",
      userId: json["user"] ?? "",
      ride: json["ride"] != null ? Ride.fromJson(json["ride"]) : Ride(),
      amount: (json["amount"] as num).toDouble(),
      transactionId: json["transaction_id"] ?? "",
      status: json["status"] ?? "",
      createdAt: json["created_at"] != null
          ? DateTime.parse(json["created_at"]) // ✅ Fix: Now using correct key
          : null,
      processedAt: json["processed_at"] != null
          ? DateTime.parse(
              json["processed_at"]) // ✅ Fix: Correctly checks processed_at
          : null,
    );
  }
}
