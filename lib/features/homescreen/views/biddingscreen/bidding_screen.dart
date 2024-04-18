// ignore_for_file: unused_local_variable
import 'dart:async';
import 'package:bidder/core/model/bid_model.dart';
import 'package:bidder/features/homescreen/controller/home_controller.dart';
import 'package:bidder/features/homescreen/views/biddingscreen/widgets/bid_value.dart';
import 'package:bidder/features/homescreen/views/biddingscreen/widgets/dialog_box.dart';
import 'package:bidder/features/homescreen/widgets/product_description.dart';
import 'package:bidder/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BiddingScreen extends StatefulWidget {
  const BiddingScreen(
      {super.key, required this.bidDeatil, required this.homeController});

  final Bid bidDeatil;
  final HomeController homeController;

  @override
  State<BiddingScreen> createState() => _BiddingScreenState();
}

Map<String, DateTime> userBids = {};

class _BiddingScreenState extends State<BiddingScreen> {
  TextEditingController bidTextController = TextEditingController();
  TextEditingController bidAmountController = TextEditingController();
  List bids = [];
  List myBids = [];
  bool validate = false;
  bool disable = true;
  String name = "";

  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    bids = widget.bidDeatil.amounts;
    widget.homeController.top.value = widget.bidDeatil.topBid == ""
        ? widget.bidDeatil.amounts[widget.bidDeatil.amounts.length - 1]
        : widget.bidDeatil.topBid;
    name = await MySharedPrefrence().getUser();
    widget.homeController.getUserBids(widget.bidDeatil.item, name);

    widget.homeController.getTexts(widget.bidDeatil.item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                )),
            ProductDescription(
              maxLines: 1,
              product: widget.bidDeatil.item,
              desc: widget.bidDeatil.itemDescription,
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20)),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
                child: Row(
                  children: [
                    const Icon(Icons.wallet),
                    Text(
                      " ₹${widget.homeController.amount.value}",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                )),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/pic_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            if (widget.bidDeatil.amounts.isNotEmpty)
              Positioned.fill(
                  child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, top: 120),
                  child: bids.isNotEmpty
                      ? Column(
                          children: [
                            BidValue(
                              bid: 'Top Bid',
                              amount: bids[bids.length - 1],
                            ),
                            BidValue(
                              bid: 'Bid #2',
                              amount: bids[bids.length - 2],
                            ),
                            BidValue(
                              bid: 'Bid #3',
                              amount: bids[bids.length - 3],
                            ),
                          ],
                        )
                      : const SizedBox(),
                ),
              )),
            Positioned.fill(
                child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 10),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.48,
                  height: 40,
                  child: TextField(
                    controller: bidTextController,
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(135, 158, 158, 158),
                      contentPadding: const EdgeInsets.only(left: 10),
                      hintText: "Say something nice...",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onSubmitted: (value) {
                      bidTextController.clear();
                      widget.homeController.texts.add(value);
                      widget.homeController.updateChat(
                          widget.bidDeatil.item, widget.homeController.texts);
                      setState(() {});
                    },
                  ),
                ),
              ),
            )),
            Positioned.fill(
                child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, right: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Timer timer =
                            Timer(const Duration(milliseconds: 800), () {
                          Navigator.of(context, rootNavigator: true).pop();
                        });
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const DialogBox(
                              text: 'Double Tap to Bid',
                            );
                          },
                        );
                      },
                      onDoubleTap: () {
                        if (widget.bidDeatil.bidCompleted) {
                          Timer timer =
                              Timer(const Duration(milliseconds: 800), () {
                            Navigator.of(context, rootNavigator: true).pop();
                          });
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const DialogBox(
                                text: 'Time UP, Bid has been completed',
                              );
                            },
                          );
                        }
                        if (!widget.bidDeatil.bidStarted &
                            !widget.bidDeatil.bidCompleted) {
                          Timer timer =
                              Timer(const Duration(milliseconds: 800), () {
                            Navigator.of(context, rootNavigator: true).pop();
                          });
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const DialogBox(
                                text: 'Wait for Bid to Start',
                              );
                            },
                          );
                        }
                        if (widget.bidDeatil.bidStarted &&
                            !widget.bidDeatil.bidCompleted) {
                          if (widget.homeController.usersBid.length >= 3) {
                            Timer timer =
                                Timer(const Duration(milliseconds: 800), () {
                              Navigator.of(context, rootNavigator: true).pop();
                            });
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const DialogBox(
                                  text:
                                      'You Already have bid maximum no. of times',
                                );
                              },
                            );
                          } else {
                            bids.add((int.parse(bids[bids.length - 1]) + 50)
                                .toString());
                            widget.bidDeatil.bitTime.addAll(
                                {" ${bids[bids.length - 1]}": DateTime.now()});
                            widget.homeController.updateBid(
                                widget.bidDeatil.item,
                                bids,
                                widget.bidDeatil.bitTime,
                                bids[bids.length - 1]);
                            widget.homeController.usersBid.addAll({
                              "${(bids[bids.length - 1])}":
                                  DateTime.now().toString()
                            });
                            widget.homeController.bids
                                .add("${(bids[bids.length - 1])}");
                            widget.homeController.updateUserBids(
                                widget.bidDeatil.item,
                                name,
                                widget.homeController.usersBid);
                            setState(() {});
                          }
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 13),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 4.0,
                                    height: 4.0,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 4.0),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey),
                                  ),
                                  Container(
                                    width: 4.0,
                                    height: 4.0,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 4.0),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                              const Text(
                                "+50",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        Timer timer =
                            Timer(const Duration(milliseconds: 800), () {
                          Navigator.of(context, rootNavigator: true).pop();
                        });
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const DialogBox(
                              text: 'Double Tap to Bid',
                            );
                          },
                        );
                      },
                      onDoubleTap: () {
                        if (widget.bidDeatil.bidCompleted) {
                          Timer timer =
                              Timer(const Duration(milliseconds: 800), () {
                            Navigator.of(context, rootNavigator: true).pop();
                          });
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const DialogBox(
                                text: 'Time UP, Bid has been completed',
                              );
                            },
                          );
                        }
                        if (!widget.bidDeatil.bidStarted &
                            !widget.bidDeatil.bidCompleted) {
                          Timer timer =
                              Timer(const Duration(milliseconds: 800), () {
                            Navigator.of(context, rootNavigator: true).pop();
                          });
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const DialogBox(
                                text: 'Wait for Bid to Start',
                              );
                            },
                          );
                        }

                        if (widget.bidDeatil.bidStarted &&
                            !widget.bidDeatil.bidCompleted) {
                          if (widget.homeController.usersBid.length >= 3) {
                            Timer timer =
                                Timer(const Duration(milliseconds: 800), () {
                              Navigator.of(context, rootNavigator: true).pop();
                            });
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const DialogBox(
                                  text:
                                      'You Already have bid maximum no. of times',
                                );
                              },
                            );
                          } else {
                            bids.add((int.parse(bids[bids.length - 1]) + 100)
                                .toString());
                            widget.bidDeatil.bitTime.addAll(
                                {" ${bids[bids.length - 1]}": DateTime.now()});
                            widget.homeController.updateBid(
                                widget.bidDeatil.item,
                                bids,
                                widget.bidDeatil.bitTime,
                                bids[bids.length - 1]);
                            widget.homeController.usersBid.addAll({
                              "${bids[bids.length - 1]}":
                                  DateTime.now().toString()
                            });
                            widget.homeController.bids
                                .add("${bids[bids.length - 1]}");
                            widget.homeController.updateUserBids(
                                widget.bidDeatil.item,
                                name,
                                widget.homeController.usersBid);
                            setState(() {});
                          }
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 13),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 4.0,
                                    height: 4.0,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 4.0),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey),
                                  ),
                                  Container(
                                    width: 4.0,
                                    height: 4.0,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 4.0),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                              const Text(
                                "+100",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (widget.bidDeatil.bidCompleted) {
                          Timer timer =
                              Timer(const Duration(milliseconds: 800), () {
                            Navigator.of(context, rootNavigator: true).pop();
                          });
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const DialogBox(
                                text: 'Time UP, Bid has been completed',
                              );
                            },
                          );
                        }
                        if (!widget.bidDeatil.bidStarted) {
                          Timer timer =
                              Timer(const Duration(milliseconds: 800), () {
                            Navigator.of(context, rootNavigator: true).pop();
                          });
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const DialogBox(
                                text: 'Wait for Bid to Start',
                              );
                            },
                          );
                        }
                        if (widget.bidDeatil.bidStarted &&
                            !widget.bidDeatil.bidCompleted) {
                          if (widget.homeController.usersBid.length >= 3) {
                            Timer timer =
                                Timer(const Duration(milliseconds: 800), () {
                              Navigator.of(context, rootNavigator: true).pop();
                            });
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const DialogBox(
                                  text:
                                      'You Already have bid maximum no. of times',
                                );
                              },
                            );
                          } else {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25.0))),
                                backgroundColor: Colors.white,
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => Padding(
                                      padding: EdgeInsets.only(
                                          top: 20,
                                          right: 20,
                                          left: 20,
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Expanded(
                                                flex: 2,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Add New Bid",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                    Text(
                                                      "The extra bid amount will be blocked from your Qube Wallet till the bidding ends",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              215, 93, 92, 92)),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    const Text(
                                                      "Current Top Bid",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              215, 93, 92, 92)),
                                                    ),
                                                    Text(
                                                      "₹${widget.homeController.top}",
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          TextField(
                                            controller: bidAmountController,
                                            cursorColor: Colors.black,
                                            style: const TextStyle(
                                                color: Colors.black),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 10),
                                              hintText: "Enter the Amount",
                                              hintStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              errorText: validate
                                                  ? "Invalid bid, new bid should be higher than the current bid ${widget.homeController.top}"
                                                  : null,
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                            ),
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              if (value.isNotEmpty) {
                                                setState(() {
                                                  disable = false;
                                                });
                                              }
                                            },
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          MaterialButton(
                                              minWidth: double.maxFinite,
                                              onPressed: () {
                                                if (!disable) {
                                                  if (int.parse(
                                                          bidAmountController
                                                              .text) <
                                                      int.parse(widget
                                                          .homeController
                                                          .top
                                                          .value)) {
                                                    setState(() {
                                                      validate = false;
                                                      disable = false;
                                                    });
                                                  } else {
                                                    bids.add(bidAmountController
                                                        .text);
                                                    widget.bidDeatil.bitTime
                                                        .addAll({
                                                      " ${bids[bids.length - 1]}":
                                                          DateTime.now()
                                                    });
                                                    widget.homeController
                                                        .updateBid(
                                                            widget
                                                                .bidDeatil.item,
                                                            bids,
                                                            widget.bidDeatil
                                                                .bitTime,
                                                            bids[bids.length -
                                                                1]);
                                                    widget
                                                        .homeController.usersBid
                                                        .addAll({
                                                      "${bids[bids.length - 1]}":
                                                          DateTime.now()
                                                              .toString()
                                                    });
                                                    widget.homeController.bids.add(
                                                        "${bids[bids.length - 1]}");
                                                    widget.homeController
                                                        .updateUserBids(
                                                            widget
                                                                .bidDeatil.item,
                                                            name,
                                                            widget
                                                                .homeController
                                                                .usersBid);
                                                    widget.homeController.top
                                                            .value =
                                                        bidAmountController
                                                            .text;
                                                    bidAmountController.clear();
                                                    Navigator.pop(context);
                                                    setState(() {
                                                      disable = false;
                                                    });
                                                  }
                                                }
                                              },
                                              color: disable
                                                  ? Colors.grey
                                                  : Colors.black,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 30),
                                              child: const Text(
                                                "Bid",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    )).then((value) => setState(() {}));
                          }
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 13),
                          child: const Text("BID",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20))),
                    ),
                  ],
                ),
              ),
            )),
            Positioned.fill(
                child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 90, right: 20),
                child: SizedBox(
                  width: 150,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("My Bids",
                          style: TextStyle(
                              color: Color.fromARGB(194, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      Obx(() {
                        if (widget.homeController.fetchingBids.value) {
                          return const SizedBox();
                        }
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: widget.homeController.usersBid.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: RichText(
                                textAlign: TextAlign.right,
                                text: TextSpan(children: [
                                  WidgetSpan(
                                      child: Image.asset(
                                          'assets/icons/bid${index + 1}.png')),
                                  TextSpan(
                                      text:
                                          "₹${widget.homeController.bids[index]}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text:
                                          " ${(DateTime.now().difference(DateTime.parse(widget.homeController.usersBid[widget.homeController.bids[index]] ?? DateTime.now().toString())).inMinutes)}m",
                                      style: const TextStyle(
                                          color: Color.fromARGB(
                                              194, 255, 255, 255),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold))
                                ]),
                              ),
                            );
                          },
                        );
                      })
                    ],
                  ),
                ),
              ),
            )),
            Positioned.fill(
                child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 60, left: 20),
                  child: Obx(() {
                    if (widget.homeController.texts.isEmpty) {
                      return const SizedBox();
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.homeController.texts.length,
                      itemBuilder: (context, index) {
                        return RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: name,
                            style: const TextStyle(
                                color: Color.fromARGB(194, 255, 255, 255),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          TextSpan(
                            text: " ${widget.homeController.texts[index]}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          )
                        ]));
                      },
                    );
                  })),
            )),
          ],
        ),
      ),
    );
  }
}
