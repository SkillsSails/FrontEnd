import 'package:intl/intl.dart';

class Review {
  final String? jobId;
  final String? userId;
  final int? rating;
  final String? comment;
  final DateTime? date;

  Review({
    this.jobId,
    this.userId,
    this.rating,
    this.comment,
    this.date,
  });

  // Method to parse date from a string
  static DateTime? parseDate(String? dateString) {
    if (dateString == null) return null;
    try {
      // Adjust this format to match your incoming date format
      final DateFormat inputFormat = DateFormat('EEE, d MMM yyyy HH:mm:ss Z');
      return inputFormat.parse(dateString);
    } catch (e) {
      print('Error parsing date: $dateString');
      return null;
    }
  }

  // Method to parse rating
  static int? parseRating(dynamic rating) {
    if (rating is int) {
      return rating;
    } else if (rating is String) {
      return int.tryParse(rating);
    } else {
      return null;
    }
  }

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      jobId: json['job_id'] as String?,
      userId: json['user_id'] as String?,
      rating: parseRating(json['rating']),
      comment: json['comment'] as String?,
      date: parseDate(json['date'] as String?),
    );
  }

  Map<String, dynamic> toJson() {
    final dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ');
    
    return {
      'job_id': jobId,
      'user_id': userId,
      'rating': rating,
      'comment': comment,
      'date': date != null ? dateFormat.format(date!) : null,
    };
  }

  @override
  String toString() {
    return 'Review{ jobId: $jobId, userId: $userId, rating: $rating, comment: $comment, date: $date}';
  }
}
