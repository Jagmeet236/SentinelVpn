import 'dart:math';

import 'package:SentinelVPN/controllers/home_controller.dart';
import 'package:SentinelVPN/models/vpn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/pref.dart';
import '../main.dart';
import '../services/vpn_engine.dart';

class VpnCard extends StatelessWidget {
  final Vpn vpn;

  const VpnCard({super.key, required this.vpn});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: sz.height * .01),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          controller.vpn.value = vpn;
          Pref.vpn = vpn;
          Get.back();
          if (controller.vpnState.value == VpnEngine.vpnConnected) {
            VpnEngine.stopVpn();
            Future.delayed(
                Duration(seconds: 2), () => controller.connectToVpn());
          } else {
            controller.connectToVpn();
          }
        },
        borderRadius: BorderRadius.circular(15),
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          leading: Container(
              padding: EdgeInsets.all(.5),
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).lightText),
                  borderRadius: BorderRadius.circular(5)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  'assets/flags/${vpn.countryShort.toLowerCase()}.png',
                  height: 40,
                  width: sz.width * .15,
                  fit: BoxFit.cover,
                ),
              )),
          title: Text(
            vpn.countryLong,
            style: GoogleFonts.ubuntu(),
          ),
          subtitle: Row(
            children: [
              Icon(
                Icons.speed_rounded,
                color: Colors.blue,
                size: 20,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                _formatBytes(vpn.speed, 1),
                style: GoogleFonts.ubuntu(
                    fontSize: 13, color: Theme.of(context).lightText),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                vpn.numVpnSessions.toString(),
                style: GoogleFonts.ubuntu(
                    fontSize: 13, color: Theme.of(context).lightText),
              ),
              SizedBox(
                width: 4,
              ),
              Icon(
                CupertinoIcons.person_3,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ['Bps', "Kbps", "Mbps", "Gbps", "Tbps"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}
