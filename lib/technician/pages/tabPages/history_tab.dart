import 'package:flutter/material.dart';

class HistoryTabPage extends StatefulWidget {
  const HistoryTabPage({Key? key}) : super(key: key);

  @override
  State<HistoryTabPage> createState() => _HistoryTabPageState();
}

class _HistoryTabPageState extends State<HistoryTabPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("History"),
    );
  }
}
