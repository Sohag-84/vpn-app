// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/app%20preferences/app_preferences.dart';
import 'package:vpn_app/models/ip_info.dart';
import 'package:vpn_app/models/vpn_info_model.dart';
import 'package:http/http.dart' as http;

class ApiVpnGate {
  static Future<List<VpnInfo>> retrieveAllAvailableVpnServers() async {
    final List<VpnInfo> vpnServerList = [];
    try {
      final response =
          await http.get(Uri.parse("http://www.vpngate.net/api/iphone/"));
      final commaSeparatedValueString =
          response.body.split("#")[1].replaceAll("*", "");

      List<List<dynamic>> listData =
          CsvToListConverter().convert(commaSeparatedValueString);

      final header = listData[0];
      for (int i = 1; i < listData.length - 1; i++) {
        Map<String, dynamic> jsonData = {};
        for (int j = 0; j < header.length; j++) {
          jsonData.addAll(
            {
              header[j].toString(): listData[i][j],
            },
          );
        }
        vpnServerList.add(VpnInfo.fromJson(jsonData));
      }
    } catch (e) {
      Get.snackbar(
        "Error Occurred",
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.redAccent.withOpacity(0.8),
      );
    }

    vpnServerList.shuffle();
    if (vpnServerList.isNotEmpty) AppPreferences.vpnList = vpnServerList;

    return vpnServerList;
  }

  static Future<void> retrieveIPDetails(
      {required Rx<IPInfo> ipInformation}) async {
    try {
      final response = await http.get(Uri.parse("http://ip-api.com/json/"));
      final dataFromApi = jsonDecode(response.body);

      ipInformation.value = IPInfo.fromJson(dataFromApi);
    } catch (e) {
      Get.snackbar(
        "Error Occurred",
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.redAccent.withOpacity(0.8),
      );
    }
  }
}
