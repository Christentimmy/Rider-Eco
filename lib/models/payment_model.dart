class PaymentModel {
  final String id;
  final String userId;
  final String rideId;
  final double amount;
  final String transactionId;
  final String status;
  final DateTime? createdAt;
  final DateTime? processedAt;

  PaymentModel({
    required this.id,
    required this.userId,
    required this.rideId,
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
      rideId: json["ride"] ?? "",
      amount: (json["amount"] as num).toDouble(),
      transactionId: json["transaction_id"] ?? "",
      status: json["status"] ?? "",
      createdAt:  json["processed_at"] != null ? DateTime.parse(json["created_at"]) : null,
      processedAt: json["processed_at"] != null
          ? DateTime.parse(json["processed_at"])
          : null,
    );
  }
}
