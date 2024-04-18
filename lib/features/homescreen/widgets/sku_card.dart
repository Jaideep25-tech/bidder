import 'package:bidder/core/model/bid_model.dart';
import 'package:bidder/features/homescreen/views/biddingscreen/bidding_screen.dart';
import 'package:bidder/features/homescreen/controller/home_controller.dart';
import 'package:bidder/features/homescreen/widgets/image_carousel.dart';
import 'package:bidder/features/homescreen/widgets/product_description.dart';
import 'package:bidder/features/homescreen/widgets/timer.dart';
import 'package:flutter/material.dart';

class SKUCard extends StatefulWidget {
  const SKUCard({
    super.key,
    required this.bid,
    required this.homeController,
  });
  final Bid bid;
  final HomeController homeController;
  @override
  State<SKUCard> createState() => _SKUCardState();
}

class _SKUCardState extends State<SKUCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BiddingScreen(
                        bidDeatil: widget.bid,
                        homeController: widget.homeController,
                      )));
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            const ImageCarousel(),
            Time(
              homeController: widget.homeController,
              name: widget.bid.item,
              min: widget.bid.min,
              sec: widget.bid.sec,
              bidStarted: widget.bid.bidStarted,
            ),
            Positioned.fill(
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ProductDescription(
                          maxLines: 2,
                          product: widget.bid.item,
                          desc: widget.bid.itemDescription,
                        ),
                        Container(
                            height: 65,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(82, 249, 249, 251),
                                borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      widget.bid.bidCompleted
                                          ? "Top Bid"
                                          : "Minimum Bid",
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(168, 255, 255, 255),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      widget.bid.bidCompleted
                                          ? "₹${widget.bid.topBid}"
                                          : "₹${widget.bid.minimumBid}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                  ],
                                ),
                                if (widget.bid.amounts.isNotEmpty)
                                  const VerticalDivider(),
                                if (widget.bid.amounts.isNotEmpty)
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: 'Bid #2 ',
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                168, 255, 255, 255),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    '₹${widget.bid.amounts[1]}',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22)),
                                          ],
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Bid #3 ',
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                168, 255, 255, 255),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    '₹${widget.bid.amounts[2]}',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                              ],
                            )),
                      ],
                    ),
                  )),
            ),
            if (widget.bid.amounts.isNotEmpty)
              Positioned.fill(
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, bottom: 5),
                      child: SizedBox(
                        width: 140,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.bid.amounts.length > 3
                                ? 3
                                : widget.bid.amounts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            82, 249, 249, 251),
                                        borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              WidgetSpan(
                                                  child: Image.asset(
                                                      'assets/icons/bid_2.png')),
                                              TextSpan(
                                                  text:
                                                      "  ₹${widget.bid.amounts[widget.bid.amounts.length - 1 - index]}",
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18)),
                                              TextSpan(
                                                text: "  ${index + 2}m",
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      168, 255, 255, 255),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )

                                    //  const Text(
                                    //   "5m 45sec",
                                    //   style: TextStyle(color: Colors.white),
                                    // )
                                    ),
                              );
                            }),
                      ),
                    )),
              )
          ],
        ),
      ),
    );
  }
}
