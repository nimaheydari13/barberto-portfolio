class StoreItem {
  final String docId;
  final String sellerId; // Reference to the barber/seller
  final String title;
  final String description;
  final double price;
  final double? discountPrice;
  final List<String> images;
  final String category;
  final List<String> tags;
  final int stock;
  final String barberShopName; // To display shop name in product listing
  final bool isAvailable; // To quickly check if item can be purchased

  StoreItem({
    required this.docId,
    required this.sellerId,
    required this.title,
    required this.description,
    required this.price,
    this.discountPrice,
    required this.images,
    required this.category,
    required this.tags,
    required this.stock,
    required this.barberShopName,
    required this.isAvailable,
  });

  factory StoreItem.fromMap(Map<String, dynamic> map) {
    return StoreItem(
      docId: map['DocumentId'] ?? '',
      sellerId: map['SellerId'] ?? '',
      title: map['Title'] ?? '',
      description: map['Description'] ?? '',
      price: (map['Price'] as num?)?.toDouble() ?? 0.0,
      discountPrice: (map['DiscountPrice'] as num?)?.toDouble(),
      images: map['Images'] is List<dynamic>
          ? List<String>.from(map['Images'])
          : [],
      category: map['Category'] ?? '',
      tags: map['Tags'] is List<dynamic> ? List<String>.from(map['Tags']) : [],
      stock: (map['Stock'] as num?)?.toInt() ?? 0,
      barberShopName: map['BarberShopName'] ?? '',
      isAvailable: map['IsAvailable'] as bool? ?? true,
    );
  }

  // Helper method to check if item is on discount
  bool get isOnDiscount => discountPrice != null && discountPrice! < price;

  // Helper method to get the current price (discount or regular)
  double get currentPrice => discountPrice ?? price;
}
