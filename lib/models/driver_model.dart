import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  factory DriverModel.fromJson(Map<String, dynamic> json) {
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

class Car {
  String? carNumber;
  String? model;
  String? manufacturer;
  int? yearOfManufacture;
  String? color;
  int? capacity;

  Car({
    this.carNumber,
    this.model,
    this.manufacturer = '',
    this.yearOfManufacture,
    this.color = '',
    this.capacity = 4,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      carNumber: json['car_number'] ?? "",
      model: json['model'] ?? "",
      manufacturer: json['manufacturer'] ?? '',
      yearOfManufacture: json['year_of_manufacture'] ?? 0,
      color: json['color'] ?? '',
      capacity: json['capacity'] ?? 4,
    );
  }
}

class PersonalDocuments {
  String? birthCertificate;
  String? drivingLicense;
  String? passport;
  String? electionCard;

  PersonalDocuments({
    this.birthCertificate,
    this.drivingLicense,
    this.passport,
    this.electionCard,
  });

  factory PersonalDocuments.fromJson(Map<String, dynamic> json) {
    return PersonalDocuments(
      birthCertificate: json['birth_certificate'] ?? "",
      drivingLicense: json['driving_license'] ?? "",
      passport: json['passport'] ?? "",
      electionCard: json['election_card'] ?? "",
    );
  }
}

class VehicleDocuments {
  String? vehicleRegistration;
  String? insurancePolicy;
  String? ownerCertificate;
  String? puc;

  VehicleDocuments({
    this.vehicleRegistration,
    this.insurancePolicy,
    this.ownerCertificate,
    this.puc,
  });

  factory VehicleDocuments.fromJson(Map<String, dynamic> json) {
    return VehicleDocuments(
      vehicleRegistration: json['vehicle_registration'] ?? "",
      insurancePolicy: json['insurance_policy'] ?? "",
      ownerCertificate: json['owner_certificate'] ?? "",
      puc: json['puc'] ?? "",
    );
  }
}

class Reviews {
  int? totalRatings;
  double? averageRating;

  Reviews({
    this.totalRatings,
    this.averageRating,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
      totalRatings: json['total_ratings'] ?? 0,
      averageRating: (json['average_rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
