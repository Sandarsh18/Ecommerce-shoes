class Shoe {
  final String image;
  final String tag;
  final String brand;
  final String category;
  final int price;
  bool isFavorite;

  Shoe({
    required this.image,
    required this.tag,
    required this.brand,
    required this.category,
    required this.price,
    this.isFavorite = false,
  });
}
