// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/app%20preferences/app_preferences.dart';
import 'package:vpn_app/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ///for bottom navigation bar
  locationSelectionBottomNavigation(BuildContext context) {
    return SafeArea(
        child: Semantics(
      button: true,
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: sizeScreen.width * 0.041),
          color: Colors.redAccent,
          height: 62,
          child: Row(
            children: [
              Icon(
                CupertinoIcons.flag_circle,
                color: Colors.white,
                size: 36,
              ),
              SizedBox(width: 12),
              Text(
                "Select Country / Location",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.redAccent,
                  size: 26,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    sizeScreen = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Free vpn"),
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.perm_device_info),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.changeThemeMode(
                AppPreferences.isModeDark ? ThemeMode.light : ThemeMode.dark,
              );
              AppPreferences.isModeDark = !AppPreferences.isModeDark;
            },
            icon: Icon(Icons.brightness_2_outlined),
          ),
        ],
      ),
      bottomNavigationBar: locationSelectionBottomNavigation(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [],
      ),
    );
  }
}
