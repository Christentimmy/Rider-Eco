


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
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      id: json["_id"] ?? "",
      userId: json["user"] ?? "",
      driverId: json["driver"] ?? "",
      status: json["status"] ?? "",
      pickupLocation: PickupLocation.fromJson(json["pickup_location"]),
      dropoffLocation: DropoffLocation.fromJson(json["dropoff_location"]),
      fare: json["fare"].toDouble(),
      requestedAt: DateTime.parse(json["requested_at"]),
      paymentMethod: json["payment_method"],
      paymentStatus: json["payment_status"],
      transactionId: json["transaction_id"],
      isScheduled: json["is_scheduled"],
      scheduledTime: json["scheduled_time"] != null
          ? DateTime.parse(json["scheduled_time"])
          : null,
      scheduleStatus: json["schedule_status"] ?? "",
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
