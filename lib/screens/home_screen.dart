import 'package:SentinelVPN/controllers/home_controller.dart';
import 'package:SentinelVPN/helpers/pref.dart';

import 'package:SentinelVPN/screens/location_screen.dart';
import 'package:SentinelVPN/widgets/count_down_timer.dart';
import 'package:SentinelVPN/widgets/home_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';
import '../models/vpn_status.dart';
import '../services/vpn_engine.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    VpnEngine.vpnStageSnapshot().listen((event) {
      _controller.vpnState.value = event;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sentinel VPN",
          style: GoogleFonts.ubuntu(
              color: Theme.of(context).lightText,
              letterSpacing: 1,
              fontSize: 18),
        ),
        automaticallyImplyLeading: false,
        leading: Icon(
          CupertinoIcons.home,
          color: Theme.of(context).lightText,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.changeThemeMode(
                    Pref.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                Pref.isDarkMode = !Pref.isDarkMode;
                ;
              },
              icon: Icon(
                Icons.brightness_medium,
                size: 26,
                color: Theme.of(context).lightText,
              )),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.info,
                  size: 27,
                  color: Theme.of(context).lightText,
                )),
          ),
        ],
      ),
      bottomNavigationBar: _changelocation(context),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Obx(() => _vpnButton(context)),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomeCard(
                title: _controller.vpn.value.countryLong.isEmpty
                    ? 'Country'
                    : '${_controller.vpn.value.countryLong}',
                subtitle: 'FREE',
                icon: CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xFFBEFC8D),
                    child: _controller.vpn.value.countryLong.isEmpty
                        ? Icon(
                            Icons.vpn_lock_outlined,
                            size: 30,
                            color: Colors.white,
                          )
                        : null,
                    backgroundImage: _controller.vpn.value.countryLong.isEmpty
                        ? null
                        : AssetImage(
                            'assets/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png')),
              ),
              HomeCard(
                title: _controller.vpn.value.countryLong.isEmpty
                    ? '100ms'
                    : _controller.vpn.value.ping + 'ms',
                subtitle: 'PING',
                icon: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.orange,
                  child: Icon(
                    Icons.equalizer_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        StreamBuilder<VpnStatus?>(
          initialData: VpnStatus(),
          stream: VpnEngine.vpnStatusSnapshot(),
          builder: (context, snapshot) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomeCard(
                title: '${snapshot.data?.byteIn ?? '0 kbps'}',
                subtitle: 'DOWNLOAD',
                icon: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.arrow_downward_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              HomeCard(
                title: '${snapshot.data?.byteOut ?? '0 kbps'}',
                subtitle: 'UPLOAD',
                icon: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.arrow_upward_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

//vpn Button
  Widget _vpnButton(BuildContext context) => Column(
        children: [
          //button
          Semantics(
            button: true,
            child: InkWell(
              onTap: () {
                _controller.connectToVpn();
              },
              borderRadius: BorderRadius.circular(100),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _controller.getButtonColor.withOpacity(.2)),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _controller.getButtonColor.withOpacity(.4)),
                  child: Container(
                    width: sz.height * .14,
                    height: sz.height * .14,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _controller.getButtonColor),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.power_settings_new_rounded,
                            color: Theme.of(context).lightText),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          _controller.getButtonText,
                          style: GoogleFonts.ubuntu(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).lightText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          //Connection Status Label
          Container(
            margin: EdgeInsets.only(
                top: sz.height * .015, bottom: sz.height * 0.02),
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            decoration: BoxDecoration(
                color: Theme.of(context).bottomNav,
                borderRadius: BorderRadius.circular(15)),
            child: Text(
              _controller.vpnState.value == VpnEngine.vpnDisconnected
                  ? "Not Connected"
                  : _controller.vpnState.replaceAll('_', " ").toUpperCase(),
              style: GoogleFonts.ubuntu(
                  fontSize: 12.5,
                  color: Theme.of(context).lightText,
                  letterSpacing: 0.5),
            ),
          ),
          Obx(() => CountDownTimer(
              startTimer:
                  _controller.vpnState.value == VpnEngine.vpnConnected)),
        ],
      );

//bottom navigation to change location
  Widget _changelocation(BuildContext context) => SafeArea(
        child: Semantics(
          button: true,
          child: InkWell(
            onTap: () => Get.to(() => LocationScreen()),
            child: Container(
              color: Theme.of(context).bottomNav,
              padding: EdgeInsets.symmetric(horizontal: sz.width * .04),
              height: 60,
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.globe,
                    color: Theme.of(context).lightText,
                    size: 28,
                  ),
                  //for adding some space
                  SizedBox(width: sz.width * 0.02),
                  Text(
                    'Change Location',
                    style: GoogleFonts.ubuntu(
                        color: Theme.of(context).lightText,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: .5),
                  ),
                  //for covering available space
                  Spacer(),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: Colors.black54,
                      size: 26,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
