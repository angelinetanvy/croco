import 'package:croco/Classes/PurchasingHistory.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppUsers {
  final String userId, username, email, fullname, gender, dob;
  double balance, points;
  LatLng location;
  List<PurchasingHistory> userHistory;

  AppUsers(this.userId, this.username, this.email, this.balance, this.fullname,
      this.gender, this.dob, this.userHistory, this.location, this.points);

  AppUsers updateBalance(double updateBy) {
    balance += updateBy;
    return this;
  }

  AppUsers updateLocation(double lat, double lng) {
    location = LatLng(lat, lng);
    return this;
  }

  AppUsers updatePoint(double updateBy) {
    points += updateBy;
    return this;
  }

  AppUsers updatePurchasingHistory(
      List<dynamic> Function(List<dynamic>) purchasingHistory) {
    userHistory = purchasingHistory(userHistory);
    return this;
  }

  factory AppUsers.fromMap(map) {
    return AppUsers(
        map['userId'],
        map["username"],
        map["email"],
        map["balance"]?.toDouble(),
        map["fullname"],
        map["gender"],
        map["dob"],
        (map['userHistory'] as List)
            .map((data) => PurchasingHistory.frommap(data))
            .toList(),
        LatLng(map['lat'], map['lng']),
        map["points"]?.toDouble());
  }

  toMap() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
      'balance': balance,
      'fullname': fullname,
      'gender': gender,
      'dob': dob,
      'userHistory':
          userHistory.map((PurchasingHistory pH) => pH.toMap()).toList(),
      'lat': location.latitude,
      'lng': location.longitude,
      'points': points,
    };
  }
}
