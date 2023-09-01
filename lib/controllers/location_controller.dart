import 'package:SentinelVPN/helpers/pref.dart';
import 'package:get/get.dart';

import '../APIs/apis.dart';
import '../models/vpn.dart';

class LocationController extends GetxController {
  List<Vpn> vpnList = Pref.vpnList;
  final RxBool isloading = false.obs;
  Future<void> getVpnData() async {
    isloading.value = true;
    vpnList.clear();
    vpnList = await APIs.getVPNServers();
    isloading.value = false;
  }
}
