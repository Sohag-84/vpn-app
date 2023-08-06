// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/models/vpn_configuration.dart';
import 'package:vpn_app/models/vpn_info_model.dart';
import 'package:vpn_app/app preferences/app_preferences.dart';
import 'package:vpn_app/vpn_engine/vpn_engine.dart';

class HomeController extends GetxController {
  final Rx<VpnInfo> vpnInfo = AppPreferences.vpnInfoObj.obs;

  final vpnConnectionState = VpnEngine.vpnDisconnectedNow.obs;

  void connectToVpnNow() async {
    if (vpnInfo.value.base64OpenVPNConfigurationData.isEmpty) {
      Get.snackbar(
          "Country / Location", "Please select country/location first");
      return;
    }

    ///if vpn connection is disconnected
    ///now user is ready to start the vpn connection
    if (vpnConnectionState.value == VpnEngine.vpnDisconnectedNow) {
      final dataConfigVpn =
          Base64Decoder().convert(vpnInfo.value.base64OpenVPNConfigurationData);
      final configuration = Utf8Decoder().convert(dataConfigVpn);

      final vpnConfiguration = VpnConfiguration(
        username: 'vpn',
        password: 'vpn',
        countryName: vpnInfo.value.countryLongName,
        config: configuration,
      );

      await VpnEngine.startVpnNow(vpnConfiguration);
    } else {
      ///if vpn connection is already running
      ///now user want to stop the connection
      await VpnEngine.stopVpnNow();
    }
  }

  Color get getRoundVpnButtonColor {
    switch (vpnConnectionState.value) {
      case VpnEngine.vpnDisconnectedNow:
        return Colors.redAccent;

      case VpnEngine.vpnConnectedNow:
        return Colors.green;

      default:
        return Colors.orangeAccent;
    }
  }

  String get getRoundVpnButtonText {
    switch (vpnConnectionState.value) {
      case VpnEngine.vpnDisconnectedNow:
        return "Tap to Connect";

      case VpnEngine.vpnConnectedNow:
        return "Disconnect";

      default:
        return "Connecting....";
    }
  }
}
