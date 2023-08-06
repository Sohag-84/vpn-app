import 'package:get/get.dart';
import 'package:vpn_app/models/vpn_info_model.dart';
import 'package:vpn_app/app preferences/app_preferences.dart';

class HomeController extends GetxController{
  final Rx<VpnInfo> vpnInfo = AppPreferences.vpnInfoObj.obs;



}