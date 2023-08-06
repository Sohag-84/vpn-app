// ignore_for_file: prefer_const_declarations

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:vpn_app/models/vpn_configuration.dart';
import 'package:vpn_app/models/vpn_status.dart';

class VpnEngine {
  ///native channel
  static final String eventChannelVpnStage = "vpnStage";
  static final String eventChannelVpnStatus = "vpnStatus";
  static final String methodChannelVpnControl = "vpnControl";

  ///vpn connection stage snapshot
  static Stream<String> snapshotVpnStage() =>
      EventChannel(eventChannelVpnStage).receiveBroadcastStream().cast();

  ///vpn connection status snapshot
  static Stream<VpnStatus?> snapshotVpnStatus() =>
      EventChannel(eventChannelVpnStatus)
          .receiveBroadcastStream()
          .map((event) => VpnStatus.fromJson(jsonDecode(event)))
          .cast();

  ///start vpn
  static Future<void> startVpnNow(VpnConfiguration vpnConfiguration) {
    return MethodChannel(methodChannelVpnControl).invokeMethod('start', {
      "config": vpnConfiguration.config,
      'country': vpnConfiguration.countryName,
      'username': vpnConfiguration.username,
      'password': vpnConfiguration.password,
    });
  }

  ///stop vpn
  static Future<void> stopVpnNow() {
    return MethodChannel(methodChannelVpnControl).invokeMethod('stop');
  }
}
