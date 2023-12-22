class ItemModel {
  String id;
  String itemName;
  String imgUrl;
  String unit;
  double price;
  String description;
  ItemModel({
    this.id = '',
    required this.itemName,
    required this.imgUrl,
    required this.unit,
    required this.price,
    required this.description,
  });
}
