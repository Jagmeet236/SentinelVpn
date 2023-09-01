import 'package:SentinelVPN/controllers/location_controller.dart';
import 'package:SentinelVPN/widgets/vpn_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../main.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen({Key? key}) : super(key: key);
  final _controller = LocationController();
  @override
  Widget build(BuildContext context) {
    if (_controller.vpnList.isEmpty) _controller.getVpnData();

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            "Sentinel VPN (${_controller.vpnList.length})",
            style: GoogleFonts.ubuntu(
                color: Theme.of(context).lightText,
                letterSpacing: 1,
                fontSize: 18),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).lightText,
            ),
          ),
        ),

        //refresh button
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 10.0, bottom: 10),
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).bottomNav,
            onPressed: () => _controller.getVpnData(),
            child: Icon(
              CupertinoIcons.refresh,
              color: Theme.of(context).lightText,
            ),
          ),
        ),
        body: _controller.isloading.value
            ? _loadingWidget(context)
            : _controller.vpnList.isEmpty
                ? _noVPNFOUNd(context)
                : _vpnData(),
      ),
    );
  }

  _vpnData() => ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: _controller.vpnList.length,
      padding: EdgeInsets.only(
          top: sz.height * .015,
          bottom: sz.height * .1,
          left: sz.width * .04,
          right: sz.width * .04),
      itemBuilder: (context, i) => VpnCard(
            vpn: _controller.vpnList[i],
          ));

  _loadingWidget(BuildContext context) {
    var sizedBox = SizedBox(height: sz.height * .10);
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          sizedBox,
          LottieBuilder.asset(
            'assets/animations/loading.json',
            width: sz.width * .8,
          ),
          Text(
            "Loading VPNs.... 🙂",
            style: GoogleFonts.ubuntu(
                fontSize: 18,
                color: Theme.of(context).lightText,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  _noVPNFOUNd(BuildContext context) => Center(
        child: Text(
          "VPNs Not Found... 😔",
          style: GoogleFonts.ubuntu(
              fontSize: 18,
              color: Theme.of(context).lightText,
              fontWeight: FontWeight.bold),
        ),
      );
}
