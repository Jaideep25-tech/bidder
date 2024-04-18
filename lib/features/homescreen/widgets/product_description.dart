import 'package:flutter/material.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    super.key,
    required this.maxLines,
    required this.product,
    required this.desc,
  });

  final int maxLines;
  final String product;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22)),
          Text(desc,
              overflow: TextOverflow.ellipsis,
              maxLines: maxLines,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
