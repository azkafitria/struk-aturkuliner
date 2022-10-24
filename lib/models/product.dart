class Product {
  final String name;
  final String qty;
  final String price;
  final List varian;

  Product({required this.name, required this.qty, required this.price, required this.varian});

  @override
  String toString() => name;
}