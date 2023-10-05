// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:praticare/components/interface/AppBar.dart';
import '../components/interface/BottomBar.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key, required this.title});
  final String title;

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final int _selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(),
        bottomNavigationBar: BottomBar(
          selectedIndex: _selectedIndex,
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [Center(child: Text("AccountScreen"))],
          ),
        ));
  }
}
