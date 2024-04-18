import 'package:bidder/core/model/transactions.dart';
import 'package:bidder/features/homescreen/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class WalletAndTransactions extends StatefulWidget {
  const WalletAndTransactions({super.key, required this.controller});
  final HomeController controller;

  @override
  State<WalletAndTransactions> createState() => _WalletAndTransactionsState();
}

class _WalletAndTransactionsState extends State<WalletAndTransactions> {
  @override
  void initState() {
    widget.controller.getUserTransactions(widget.controller.user!.userName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Wallet Ballance",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "₹${widget.controller.amount}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ],
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: const Icon(
                            Icons.add,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          "Add Money",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Bids And Transactions",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            const SizedBox(
              height: 15,
            ),
            Obx(() {
              if (widget.controller.transactions!.isEmpty) {
                return const Center(
                    child: Text("There are no Transactions yet"));
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: widget.controller.transactions!.length,
                itemBuilder: (context, index) {
                  return TransactionWidget(
                    transactions: widget.controller.transactions![index],
                  );
                },
              );
            })
          ],
        ),
      ),
    );
  }
}

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    super.key,
    required this.transactions,
  });

  final Transactions transactions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(transactions.credited
                ? 'assets/images/money.png'
                : 'assets/images/transaction.png'),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.72,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        transactions.item,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text(
                        transactions.credited ? "15m ago" : "1m ago",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.72,
                  child: Text(
                    transactions.description,
                    style: const TextStyle(
                        color: Color.fromARGB(168, 100, 99, 99), fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.72,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(60, 158, 158, 158),
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          transactions.mode,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                        ),
                      ),
                      RichText(
                          text: TextSpan(children: [
                        WidgetSpan(
                            child: Icon(
                          transactions.credited ? Icons.add : Icons.remove,
                          color: Colors.black,
                          size: 15,
                        )),
                        TextSpan(
                          text: transactions.amount,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )
                      ]))
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
