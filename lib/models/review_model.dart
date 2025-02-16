

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