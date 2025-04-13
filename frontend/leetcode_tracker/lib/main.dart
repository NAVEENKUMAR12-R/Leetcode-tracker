import 'package:flutter/material.dart';
import 'package:leetcode_tracker/homescreen.dart';

void main() {
  runApp(LeetcodeTracker());
}

class LeetcodeTracker extends StatefulWidget {
  const LeetcodeTracker({super.key});

  @override
  State<LeetcodeTracker> createState() => _LeetcodeTrackerState();
}

class _LeetcodeTrackerState extends State<LeetcodeTracker> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homescreen()
    );
  }
}
