class FareBreakdownModel {
  final String baseFare;
  final String distanceKm;
  final String distanceFare;
  final String totalFare;
  FareBreakdownModel({
    required this.baseFare,
    required this.distanceKm,
    required this.distanceFare,
    required this.totalFare,
  });

  factory FareBreakdownModel.fromMap(map) {
    return FareBreakdownModel(
      baseFare: map['baseFare'] ?? "",
      distanceKm: map['distanceKm'] ?? "",
      distanceFare: map['distanceFare'] ?? "",
      totalFare: map['totalFare'] ?? "",
    );
  }

  @override
  String toString() {
    return 'FareBreakdownModel(baseFare: $baseFare, distanceKm: $distanceKm, distanceFare: $distanceFare, totalFare: $totalFare)';
  }
}
