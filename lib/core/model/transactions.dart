class Transactions {
  final String amount;
  final String item;
  final bool credited;
  final String description;
  final String time;
  final String mode;

  Transactions(
      {required this.description,
      required this.time,
      required this.mode,
      required this.amount,
      required this.item,
      required this.credited});

  factory Transactions.fromJSON(Map<String, dynamic> json) {
    return Transactions(
        amount: json["Amount"],
        credited: json["credited"],
        description: json["description"],
        time: json["time"],
        mode: json["mode"],
        item: json["item"]);
  }
}
