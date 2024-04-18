// ignore_for_file: use_build_context_synchronously

import 'package:bidder/core/services/network_service.dart';
import 'package:bidder/features/homescreen/views/homescreen.dart';
import 'package:bidder/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class BitMojiScreen extends StatefulWidget {
  const BitMojiScreen({super.key});

  @override
  State<BitMojiScreen> createState() => _BitMojiScreenState();
}

class _BitMojiScreenState extends State<BitMojiScreen> {
  final FluttermojiController fluttermojiController = FluttermojiController();

  late NetworkService _db;
  final TextEditingController userNameController = TextEditingController();

  @override
  void initState() {
    Get.put(FluttermojiController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _db = GetIt.instance.get<NetworkService>();
    // var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: FluttermojiSaveWidget(
              onTap: () async {
                await MySharedPrefrence().setOldUser(true);
                await MySharedPrefrence().setUser(userNameController.text);
                await _db.createUser(userNameController.text,
                    fluttermojiController.fluttermoji.value);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: FluttermojiCircleAvatar(
                  radius: 120,
                  // backgroundColor: Colors.grey[200],
                ),
              ),
              SizedBox(
                child: TextField(
                  controller: userNameController,
                  cursorColor: Colors.grey,
                  style: const TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 10),
                    labelText: 'Username',
                    labelStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    floatingLabelStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.5),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    // errorText: _validate ? 'Name Can\'t Be Empty' : null,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
                child: FluttermojiCustomizer(
                  //  scaffoldWidth: min(600, _width * 0.85),
                  autosave: true,
                  theme: FluttermojiThemeData(
                      boxDecoration:
                          const BoxDecoration(boxShadow: [BoxShadow()])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
