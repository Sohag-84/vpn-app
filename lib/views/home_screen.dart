// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/app%20preferences/app_preferences.dart';
import 'package:vpn_app/main.dart';
import 'package:vpn_app/widgets/custom_widget.dart';

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

  /// for vpn button
  Widget vpnRoundButton() {
    return Column(
      children: [
        Semantics(
          button: true,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(100),
            child: Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: Container(
                  height: sizeScreen.height * .14,
                  width: sizeScreen.width * .14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.power_settings_new,
                        size: 30,
                        color: Colors.white,
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Tap to Connect",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomWidget(
                titleText: "Location",
                subtitleText: "Free",
                roundWidgetWithIcon: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  radius: 32,
                  child: Icon(
                    Icons.flag_circle,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              CustomWidget(
                titleText: "60 ms",
                subtitleText: "PING",
                roundWidgetWithIcon: CircleAvatar(
                  backgroundColor: Colors.black54,
                  radius: 32,
                  child: Icon(
                    Icons.graphic_eq,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          vpnRoundButton(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomWidget(
                titleText: "0 kbps",
                subtitleText: "DOWNLOAD",
                roundWidgetWithIcon: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 32,
                  child: Icon(
                    Icons.arrow_circle_down,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              CustomWidget(
                titleText: "0 kbps",
                subtitleText: "UPLOAD",
                roundWidgetWithIcon: CircleAvatar(
                  backgroundColor: Colors.purpleAccent,
                  radius: 32,
                  child: Icon(
                    Icons.arrow_circle_up,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
