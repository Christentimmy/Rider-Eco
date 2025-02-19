


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

  factory PersonalDocuments.fromJson(json) {
    return PersonalDocuments(
      birthCertificate: json['birth_certificate'] ?? "",
      drivingLicense: json['driving_license'] ?? "",
      passport: json['passport'] ?? "",
      electionCard: json['election_card'] ?? "",
    );
  }
}