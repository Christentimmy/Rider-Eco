import 'package:rider/models/review_model.dart';

class Ride {
  String? id;
  String? userId;
  String? driverId;
  String? status;
  PickupLocation? pickupLocation;
  DropoffLocation? dropoffLocation;
  double? fare;
  DateTime? requestedAt;
  String? paymentMethod;
  String? paymentStatus;
  String? transactionId;
  bool? isScheduled;
  DateTime? scheduledTime;
  String? scheduleStatus;
  String? driverFirstName;
  String? driverLastName;
  Reviews? reviews;

  Ride({
    this.id,
    this.userId,
    this.driverId,
    this.status,
    this.pickupLocation,
    this.dropoffLocation,
    this.fare,
    this.requestedAt,
    this.paymentMethod,
    this.paymentStatus,
    this.transactionId,
    this.isScheduled,
    this.scheduledTime,
    this.scheduleStatus,
    this.driverFirstName,
    this.driverLastName,
    this.reviews,
  });

  factory Ride.fromJson(json) {
    bool isDriverPopulated = json["driver"] is Map<String, dynamic>;

    return Ride(
      id: json["_id"] ?? "",
      userId: json["user"] ?? "",
      driverId: isDriverPopulated
          ? json["driver"]["_id"]
          : json["driver"], 
      status: json["status"] ?? "",
      pickupLocation: json["pickup_location"] != null
          ? PickupLocation.fromJson(json["pickup_location"])
          : null,
      dropoffLocation: json["dropoff_location"] != null
          ? DropoffLocation.fromJson(json["dropoff_location"])
          : null,
      fare: json["fare"] != null ? (json["fare"] as num).toDouble() : 0.0,
      requestedAt: json["requested_at"] != null
          ? DateTime.tryParse(json["requested_at"])
          : null,
      paymentMethod: json["payment_method"] ?? "",
      paymentStatus: json["payment_status"] ?? "",
      transactionId: json["transaction_id"] ?? "",
      isScheduled: json["is_scheduled"] ?? false,
      scheduledTime: json["scheduled_time"] != null
          ? DateTime.tryParse(json["scheduled_time"])
          : null,
      scheduleStatus: json["schedule_status"] ?? "",
      driverFirstName:
          isDriverPopulated ? json["driver"]["user"]["first_name"] ?? "" : "",
      driverLastName:
          isDriverPopulated ? json["driver"]["user"]["last_name"] ?? "" : "",
      reviews: isDriverPopulated
          ? Reviews.fromJson(json["driver"]["reviews"])
          : Reviews(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "user": userId,
      "driver": driverId,
      "status": status,
      "pickup_location": pickupLocation?.toJson(),
      "dropoff_location": dropoffLocation?.toJson(),
      "fare": fare,
      "requested_at": requestedAt?.toIso8601String(),
      "payment_method": paymentMethod,
      "payment_status": paymentStatus,
      "transaction_id": transactionId,
      "is_scheduled": isScheduled,
      "scheduled_time": scheduledTime?.toIso8601String(),
      "schedule_status": scheduleStatus
    };
  }
}

class PickupLocation {
  final double lat;
  final double lng;
  final String address;

  PickupLocation({
    required this.lat,
    required this.lng,
    required this.address,
  });

  factory PickupLocation.fromJson(Map<String, dynamic> json) {
    return PickupLocation(
      lat: json["lat"].toDouble(),
      lng: json["lng"].toDouble(),
      address: json["address"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "lat": lat,
      "lng": lng,
      "address": address,
    };
  }
}

class DropoffLocation {
  final double lat;
  final double lng;
  final String address;

  DropoffLocation({
    required this.lat,
    required this.lng,
    required this.address,
  });

  factory DropoffLocation.fromJson(Map<String, dynamic> json) {
    return DropoffLocation(
      lat: json["lat"].toDouble(),
      lng: json["lng"].toDouble(),
      address: json["address"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "lat": lat,
      "lng": lng,
      "address": address,
    };
  }
}
