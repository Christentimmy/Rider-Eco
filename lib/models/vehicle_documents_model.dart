
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

  factory VehicleDocuments.fromJson(json) {
    return VehicleDocuments(
      vehicleRegistration: json['vehicle_registration'] ?? "",
      insurancePolicy: json['insurance_policy'] ?? "",
      ownerCertificate: json['owner_certificate'] ?? "",
      puc: json['puc'] ?? "",
    );
  }
}