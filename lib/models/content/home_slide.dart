class HomeSlide {
  final String title;
  final String subTitle;
  final String imgUrl;
  final String color;
  final String? url;

  const HomeSlide(
      {required this.title,
      required this.subTitle,
      required this.imgUrl,
      required this.color,
      this.url});

  factory HomeSlide.fromJson(Map<String, dynamic> json) => HomeSlide(
      title: json['title'] as String,
      subTitle: json['sub_title'] as String,
      imgUrl: json['img_url'] as String,
      color: json['color'] as String,
      url: json['url'] as String?);

  @override
  String toString() => 'HomeSlide('
      'title=$title'
      'subTitle=$subTitle'
      'imgUrl=$imgUrl'
      'url=$url)';
}
