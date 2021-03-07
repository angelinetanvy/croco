class Goods {
  String name;
  String type;
  String goodId;
  int stock;
  double price;
  String image;

  Goods(this.name, this.goodId, this.stock, this.price, this.image);

  Goods upgradeGoodsQuantity(int updateBy) {
    stock += updateBy;
    return this;
  }

  Goods updatePrice(double newPrice) {
    price = newPrice;
    return this;
  }

  factory Goods.fromMap(map) {
    return Goods(
      map['name'],
      map['goodId'],
      map['stock'],
      map['price'],
      map['image'],
    );
  }

  toMap() {
    return {
      'name': name,
      'type': type,
      'goodId': goodId,
      'stock': stock,
      'image': image,
    };
  }
}
