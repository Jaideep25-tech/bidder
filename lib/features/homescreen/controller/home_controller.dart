import 'package:bidder/core/model/bid_model.dart';
import 'package:bidder/core/model/transactions.dart';
import 'package:bidder/core/model/user_model.dart';
import 'package:bidder/core/services/network_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class HomeController {
  RxBool fetchingData = false.obs;
  RxBool fetchingTransactions = false.obs;
  final network = GetIt.instance.get<NetworkService>();
  RxList<Bid>? bidDetails = <Bid>[].obs;
  RxList<Transactions>? transactions = <Transactions>[].obs;
  RxBool timeUp = false.obs;
  RxBool fetchingBids = false.obs;
  Map<String, dynamic> usersBid = {};
  RxList bids = [].obs;
  RxString top = "".obs;
  RxList texts = [].obs;
  User? user;
  RxInt amount = 0.obs;
  //late Bid bidDetails;

  getBidData() async {
    fetchingData.value = true;
    CollectionReference<Map<String, dynamic>> bids = network.getBidDaTa();
    bids.snapshots().forEach((element) {
      bidDetails!.clear();
      for (var element1 in element.docs) {
        Map<String, dynamic> bidData = element1.data();
        Bid detail = Bid.fromJSON(bidData);
        bidDetails?.add(detail);
      }
    });
    fetchingData.value = false;
  }

  getUserTransactions(String name) async {
    fetchingTransactions.value = true;
    CollectionReference<Map<String, dynamic>> trans =
        network.getUserTransactions(name);
    trans.snapshots().forEach((element) {
      transactions!.clear();
      for (var element1 in element.docs) {
        Map<String, dynamic> trns = element1.data();
        Transactions detail = Transactions.fromJSON(trns);
        transactions?.add(detail);
      }
    });
    fetchingTransactions.value = false;
  }

  getUserBids(String item, String user) async {
    fetchingBids.value = true;
    DocumentSnapshot<Map<String, dynamic>> userBids =
        await network.getUserBids(item, user);
    usersBid = userBids.data()?["userBids"] ?? {};
    usersBid.forEach((key, value) {
      bids.add(key);
    });
    fetchingBids.value = false;
  }

  getTexts(String item) async {
    DocumentSnapshot<Map<String, dynamic>> userBids =
        await network.getTexts(item);
    texts.value = userBids.data()?["texts"] ?? [];
  }

  updateUserBids(String item, String user, var userBid) {
    network.updateUserBids(item, user, userBid);
  }

  getUserData(String uName) async {
    DocumentSnapshot<Map<String, dynamic>> use =
        await network.getUserData(uName);
    user = User.fromJSON(use.data()!);
    amount.value = user!.balance;
  }

  updateTime(int min, int sec, bool completed, String name) {
    network.updateTime(min, sec, completed, name);
  }

  updateBid(String name, var amounts, var bidTime, String topBid) {
    network.updateBid(name, amounts, bidTime, topBid);
  }

  updateChat(String name, var texts) {
    network.updateBidChat(name, texts);
  }
}
