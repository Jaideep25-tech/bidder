class Bid {
  final String item;
  final String itemDescription;
  final String minimumBid;
  final String topBid;
  final String startTime;
  final List amounts;
  final bool bidCompleted;
  final int min;
  final int sec;
  final bool bidStarted;
  final Map<String, dynamic> bitTime;
  final List text;
  Bid(
      {required this.itemDescription,
      required this.bidCompleted,
      required this.text,
      required this.min,
      required this.sec,
      required this.minimumBid,
      required this.topBid,
      required this.startTime,
      required this.item,
      required this.bidStarted,
      required this.bitTime,
      required this.amounts});

  factory Bid.fromJSON(Map<String, dynamic> json) {
    return Bid(
      item: json["item"],
      itemDescription: json["item_description"],
      minimumBid: json["minimum_bid"],
      topBid: json["top_bid"],
      startTime: json["start_time"].toString(),
      amounts: json["bid_amount"],
      bitTime: json["bid_time"],
      bidCompleted: json["bid_completed"],
      min: json["min"] ?? 0,
      sec: json["sec"] ?? 0,
      bidStarted: json["bid_started"],
      text: ["texts"],
    );
  }
}
