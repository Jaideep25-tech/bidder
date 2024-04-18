// ignore_for_file: constant_identifier_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

const String ITEM_COLLECTION = "Bids";
const String USER_COLLECTION = "Users";
const String USER_BIDS_COLLECTION = "UserBids";
const String TRANSACTION_COLLECTION = "transactions";

class NetworkService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  NetworkService();

  Future<void> createUser(String name, String bitmoji) async {
    try {
      await _db.collection(USER_COLLECTION).doc(name).set(
        {"Bitmoji": bitmoji, "UserName": name, "Balance": 10000},
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateTransaction(
      String name, var transaction, bool credit) async {
    try {
      await _db.collection(USER_COLLECTION).doc(name).update(
        {"transaction": transaction, "credited": credit},
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateTime(
      int min, int sec, bool bidCompleted, String name) async {
    try {
      await _db.collection(ITEM_COLLECTION).doc(name).update(
        {"bid_completed": bidCompleted, "min": min, "sec": sec},
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateUserBids(String item, String user, var userBid) async {
    try {
      await _db
          .collection(ITEM_COLLECTION)
          .doc(item)
          .collection(USER_BIDS_COLLECTION)
          .doc(user)
          .update({"userBids": userBid});
    } catch (e) {
      print(e);
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserBids(
      String item, String user) {
    return _db
        .collection(ITEM_COLLECTION)
        .doc(item)
        .collection(USER_BIDS_COLLECTION)
        .doc(user)
        .get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getTexts(String item) {
    return _db.collection(ITEM_COLLECTION).doc(item).get();
  }

  Future<void> updateBid(
      String name, var amounts, var bidTime, String topBid) async {
    try {
      await _db.collection(ITEM_COLLECTION).doc(name).update(
        {"bid_amount": amounts, "bid_time": bidTime, "top_bid": topBid},
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateBidChat(String name, var texts) async {
    try {
      await _db.collection(ITEM_COLLECTION).doc(name).update(
        {"texts": texts},
      );
    } catch (e) {
      print(e);
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uName) {
    return _db.collection(USER_COLLECTION).doc(uName).get();
  }

  CollectionReference<Map<String, dynamic>> getUserTransactions(String user) {
    return _db
        .collection(USER_COLLECTION)
        .doc(user)
        .collection(TRANSACTION_COLLECTION);
  }

  CollectionReference<Map<String, dynamic>> getBidDaTa() {
    return _db.collection(ITEM_COLLECTION);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getBidDetails(String name) {
    return _db.collection(ITEM_COLLECTION).doc(name).get();
  }
}
