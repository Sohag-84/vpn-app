// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unnecessary_string_interpolations

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/app%20preferences/app_preferences.dart';
import 'package:vpn_app/controllers/home_controller.dart';
import 'package:vpn_app/main.dart';
import 'package:vpn_app/models/vpn_status.dart';
import 'package:vpn_app/vpn_engine/vpn_engine.dart';
import 'package:vpn_app/widgets/custom_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.put(HomeController());

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
                color: homeController.getRoundVpnButtonColor.withOpacity(0.1),
              ),
              child: Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: homeController.getRoundVpnButtonColor.withOpacity(0.3),
                ),
                child: Container(
                  height: sizeScreen.height * .14,
                  width: sizeScreen.width * .14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: homeController.getRoundVpnButtonColor,
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
                        homeController.getRoundVpnButtonText,
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
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomWidget(
                  titleText:
                      homeController.vpnInfo.value.countryLongName.isEmpty
                          ? "Location"
                          : homeController.vpnInfo.value.countryLongName,
                  subtitleText: "Free",
                  roundWidgetWithIcon: CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    radius: 32,
                    child: homeController.vpnInfo.value.countryLongName.isEmpty
                        ? Icon(
                            Icons.flag_circle,
                            size: 30,
                            color: Colors.white,
                          )
                        : null,
                    backgroundImage:
                        homeController.vpnInfo.value.countryLongName.isEmpty
                            ? null
                            : AssetImage(
                                "countryFlags/${homeController.vpnInfo.value.countryShortName.toLowerCase()}.png",
                              ),
                  ),
                ),
                CustomWidget(
                  titleText:
                      homeController.vpnInfo.value.countryLongName.isEmpty
                          ? "60 ms"
                          : "${homeController.vpnInfo.value.ping} ms",
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
            );
          }),
          vpnRoundButton(),
          StreamBuilder<VpnStatus?>(
            initialData: VpnStatus(),
            stream: VpnEngine.snapshotVpnStatus(),
            builder: (context, dataSnapshot) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomWidget(
                    titleText: "${dataSnapshot.data?.byteIn ?? '0 kbps'}",
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
                    titleText: "${dataSnapshot.data?.byteOut ?? '0 kbps'}",
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
              );
            },
          )
        ],
      ),
    );
  }
}
