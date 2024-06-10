class SplashData {
  SplashData({
    required this.title,
    required this.description,
    required this.image,
    required this.backgroundColor,
  });

  factory SplashData.fromJson(Map<String, dynamic> json) {
    return SplashData(
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      backgroundColor: json['backgroundColor'] as String,
    );
  }
  final String title;
  final String description;
  final String image;
  final String backgroundColor;
}
