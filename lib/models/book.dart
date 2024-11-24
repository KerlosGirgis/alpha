class Book {
  String id;
  String price;
  String image;
  String title;
  String subtitle;

  Book(
      {
        required this.subtitle,
        required this.id,
        required this.image,
        required this.title,
        required this.price});

  factory Book.fromJson(Map<dynamic, dynamic> json) {
    return Book(
        id: json['isbn13'],
        price: json['price'],
        image: json['image'],
        title: json['title'],
        subtitle: json['subtitle'],);
  }
}