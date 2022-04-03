import 'package:flutter/material.dart';
import 'package:hifixit/widgets/menu_drawer.dart';

class CustAccount extends StatelessWidget {
  const CustAccount({Key? key, required this.pageTitle}) : super(key: key);

  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.menu),
        //   onPressed: () => openDrawer(),
        // ),
        title: Text(pageTitle),
        centerTitle: true,
        actions: [],
      ),
      drawer: const MenuDrawer(),
      body: Container(),
    );
  }
}
