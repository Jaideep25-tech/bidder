// ignore_for_file: use_build_context_synchronously

import 'package:bidder/features/bitmojiScreen/bitmoji_screen.dart';
import 'package:bidder/core/services/network_service.dart';
import 'package:bidder/features/homescreen/views/homescreen.dart';
import 'package:bidder/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool isOldUser;
  _navigatetohome() async {
    isOldUser = await MySharedPrefrence().oldUser();
    await Future.delayed(const Duration(milliseconds: 2000), () {});
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                isOldUser ? const HomeScreen() : const BitMojiScreen()));
  }

  @override
  void initState() {
    _registerServices();
    _navigatetohome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/icons/Logo.png'),
      ),
    );
  }

  void _registerServices() {
    GetIt.instance.registerSingleton<NetworkService>(
      NetworkService(),
    );
  }
}
