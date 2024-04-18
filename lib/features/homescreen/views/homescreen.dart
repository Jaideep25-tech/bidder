import 'package:bidder/features/homescreen/controller/home_controller.dart';
import 'package:bidder/features/homescreen/views/dashboard_sceen.dart';
import 'package:bidder/features/homescreen/views/wallet_transactions.dart';
import 'package:bidder/utils/generic%20components/appbar.dart';
import 'package:bidder/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = HomeController();
  int _currentIndex = 0;
  @override
  void initState() {
    initialize();

    super.initState();
  }

  void initialize() async {
    String name = await MySharedPrefrence().getUser();
    controller.getBidData();
    controller.getUserData(name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(
        bckButton: false,
        amount: "${controller.user?.balance ?? 10000}",
        showWallet: _currentIndex == 0 ? true : false,
      ),
      body: _currentIndex == 0
          ? DashboardScreen(
              controller: controller,
            )
          : WalletAndTransactions(
              controller: controller,
            ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "Wallet")
        ],
      ),
    );
  }
}



//  new StreamBuilder(
//             stream: Firestore.instance.collection("collection").snapshots(),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) {
//                 return Text(
//                   'No Data...',
//                 );
//               } else {
//                 // <DocumentSnapshot> items = snapshot.data.documents;

//                 return SizedBox();
//               }
//             })

