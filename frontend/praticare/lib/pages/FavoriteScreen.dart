// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:praticare/components/interface/AppBar.dart';
import '../components/interface/BottomBar.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key, required this.title});
  final String title;

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: MyAppBar(),
        bottomNavigationBar: BottomBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [Center(child: Text("FavoriteScreen"))],
          ),
        ));
  }
}
