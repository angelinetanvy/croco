import 'PurchasingHistory.dart';

class AppUsers {
  final String userId, username, email, fullname, gender, dob;
  double balance;
  List<dynamic> userHistory;

  AppUsers(this.userId, this.username, this.email, this.balance, this.fullname,
      this.gender, this.dob, this.userHistory);

  AppUsers updateBalance(double updateBy) {
    balance += updateBy;
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
        map["userHistory"]);
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
      'userHistory': userHistory
    };
  }
}
