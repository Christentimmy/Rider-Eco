import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/models/car_model.dart';
import 'package:rider/models/personal_documents_models.dart';
import 'package:rider/models/review_model.dart';
import 'package:rider/models/vehicle_documents_model.dart';

class DriverModel {
  String? id;
  String? userId;
  String? stripeAccountId;
  Car? car;
  String? status;
  LatLng? location;
  bool? isVerified;
  bool? isVehicleApproved;
  PersonalDocuments? personalDocuments;
  VehicleDocuments? vehicleDocuments;
  double? balance;
  Reviews? reviews;

  DriverModel({
    this.id,
    this.userId,
    this.stripeAccountId,
    this.car,
    this.status,
    this.location,
    this.isVerified,
    this.isVehicleApproved,
    this.personalDocuments,
    this.vehicleDocuments,
    this.balance,
    this.reviews,
  });

  factory DriverModel.fromJson(json) {
    return DriverModel(
      id: json['_id'] ?? "",
      userId: json['user'] ?? "",
      stripeAccountId: json['stripe_account_id'] ?? "",
      car: json["car"] != null ? Car.fromJson(json['car']) : Car(),
      status: json['status'] ?? "",
      location: LatLng(
        json['location']['coordinates'][1] ?? 0.0, // Lat
        json['location']['coordinates'][0] ?? 0.0, // Lng
      ),
      isVerified: json['is_verified'] ?? false,
      isVehicleApproved: json['is_vehicle_approved'] ?? false,
      personalDocuments: json["personal_documents"] != null
          ? PersonalDocuments.fromJson(json['personal_documents'])
          : PersonalDocuments(),
      vehicleDocuments: json["vehicle_documents"] != null
          ? VehicleDocuments.fromJson(json['vehicle_documents'])
          : VehicleDocuments(),
      balance: (json['balance'] as num).toDouble(),
      reviews: json["reviews"] != null
          ? Reviews.fromJson(json['reviews'])
          : Reviews(),
    );
  }
}
