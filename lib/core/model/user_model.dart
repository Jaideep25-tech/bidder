class User {
  final String userName;
  final int balance;
  final String bitmoji;

  User({
    required this.userName,
    required this.balance,
    required this.bitmoji,
  });

  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
      userName: json["UserName"],
      balance: json["Balance"],
      bitmoji: json["Bitmoji"] ?? "",
    );
  }
}
