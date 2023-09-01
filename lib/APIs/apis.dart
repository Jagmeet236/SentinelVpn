import 'dart:convert';
import 'dart:developer';

import 'package:SentinelVPN/helpers/pref.dart';
import 'package:csv/csv.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

import '../models/vpn.dart';

class APIs {
  static Future<List<Vpn>> getVPNServers() async {
    final List<Vpn> vpnlist = [];
    try {
      final res = await get(Uri.parse('http://www.vpngate.net/api/iphone/'));
      final csvString = res.body.split('#')[1].replaceAll('*', " ");
      List<List<dynamic>> list = const CsvToListConverter().convert(csvString);
      final header = list[0];

      for (int i = 1; i < list.length - 1; i++) {
        Map<String, dynamic> tempjson = {};

        for (int j = 0; j < header.length; j++) {
          tempjson.addAll({header[j].toString(): list[i][j]});
        }
        vpnlist.add(Vpn.fromJson(tempjson));
      }

      log(vpnlist.first.hostname);
    } catch (e) {
      log('\ngetVPNServersE:$e');
    }
    vpnlist.shuffle();
    if (vpnlist.isNotEmpty) Pref.vpnList = vpnlist;

    return vpnlist;
  }
}
