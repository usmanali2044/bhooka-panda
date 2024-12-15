class CartItem {
  final String name;
  final String Description;
  final String price;
  final String image;
  int quantity;

  CartItem({
    required this.name,required this.Description, required this.price, required this.image, this.quantity = 1,
  });
}