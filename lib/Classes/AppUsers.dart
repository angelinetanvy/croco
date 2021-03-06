import 'package:google_maps_flutter/google_maps_flutter.dart';


class AppUsers {
  final String userId, username, email, fullname, gender, dob;
  double balance, points;
  LatLng location;
  List<dynamic> userHistory;

  AppUsers(this.userId, this.username, this.email, this.balance, this.fullname,
      this.gender, this.dob, this.userHistory, this.location, this.points);

  AppUsers updateBalance(double updateBy) {
    balance += updateBy;
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
        map["userHistory"],
        map[LatLng(map['lat'], map['lng'])],
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
      'userHistory': userHistory,
      'lat': location.latitude,
      'lng': location.longitude,
      'points': points,
    };
  }
}
