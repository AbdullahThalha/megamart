// lib/models/wishlist_item.dart
class WishlistItem {
  final String id; // same as product id
  final String title;
  final double price;
  final String imageUrl;

  WishlistItem({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
  });
}
