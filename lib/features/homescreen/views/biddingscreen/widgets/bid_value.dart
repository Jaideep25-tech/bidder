import 'package:flutter/material.dart';

class BidValue extends StatelessWidget {
  const BidValue({
    super.key,
    required this.bid,
    required this.amount,
  });

  final String bid;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            bid,
            style: const TextStyle(
              color: Color.fromARGB(168, 255, 255, 255),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "₹$amount",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
