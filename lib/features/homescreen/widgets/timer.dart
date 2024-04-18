// ignore_for_file: unused_field, must_be_immutable

import 'dart:async';
import 'package:bidder/features/homescreen/controller/home_controller.dart';
import 'package:flutter/material.dart';

class Time extends StatefulWidget {
  Time({
    super.key,
    required this.homeController,
    required this.name,
    required this.min,
    required this.sec,
    required this.bidStarted,
  });

  final HomeController homeController;
  final String name;
  int min;
  int sec;
  final bool bidStarted;

  @override
  State<Time> createState() => _TimeState();
}

class _TimeState extends State<Time> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    if (widget.bidStarted) {
      calculateTime();
    }
  }

  void calculateTime() async {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (mounted) {
        setState(() {
          if (widget.min == 0 && widget.sec == 0) {
            timer.cancel();
            widget.homeController
                .updateTime(widget.min, widget.sec, true, widget.name);
          } else {
            if (widget.sec == 0) {
              widget.sec = 59;
              widget.min -= 1;
              widget.homeController
                  .updateTime(widget.min, widget.sec, false, widget.name);
            } else {
              widget.sec--;
              widget.homeController
                  .updateTime(widget.min, widget.sec, false, widget.name);
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 10, top: 8),
          child: Column(
            children: [
              const Text(
                "Ends in",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(82, 249, 249, 251),
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    "${widget.min} m ${widget.sec} sec",
                    style: const TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
