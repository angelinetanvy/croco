class PurchasingHistory {
  final int purchasingId;
  final int vendId;
  final int goodId;
  final int userId;
  int purchaseDate;
  final double price;

  PurchasingHistory(
      this.purchasingId, this.vendId, this.goodId, this.userId, this.price,
      {this.purchaseDate}) {
    if (purchaseDate == null)
      purchaseDate = DateTime.now().millisecondsSinceEpoch;
  }

  factory PurchasingHistory.frommap(map){
    return PurchasingHistory(
      map['purchasingId'],
      map['vendId'],
      map['goodId'],
      map['userId'],
      map['price'],
      purchaseDate: map['purchaseDate']
    );
  }
}





























