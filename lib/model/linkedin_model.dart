class Linkedin {
  final String company;
  final String jobTitle;
  final String link;
    final String id;


  Linkedin({
    required this.company,
    required this.jobTitle,
    required this.link,
    required this.id,

  });

  factory Linkedin.fromJson(Map<String, dynamic> json) {
    return Linkedin(
      company: json['company'] ?? '',
      jobTitle: json['job_title'] ?? '',
      link: json['link'] ?? '',
      id: json['_id'] ?? '', // Provide default values

    );
  }
}
