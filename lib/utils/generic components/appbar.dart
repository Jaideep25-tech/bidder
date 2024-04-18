import 'package:flutter/material.dart';

class GenericAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GenericAppBar({
    super.key,
    required this.bckButton,
    required this.amount,
    required this.showWallet,
  });

  final bool bckButton;
  final String amount;
  final bool showWallet;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: bckButton
          ? Row(
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
                Image.asset('assets/icons/title_logo.png'),
              ],
            )
          : Image.asset('assets/icons/title_logo.png'),
      actions: [
        showWallet
            ? Padding(
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
                          "  ₹$amount",
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    )),
              )
            : const SizedBox(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
