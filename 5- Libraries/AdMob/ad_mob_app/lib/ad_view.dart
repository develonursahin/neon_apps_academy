import 'package:ad_mob_app/banner_widget.dart';
import 'package:ad_mob_app/rewarded_ad.dart';
import 'package:flutter/material.dart';

class AdMobView extends StatefulWidget {
  const AdMobView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AdMobViewState createState() => _AdMobViewState();
}

class _AdMobViewState extends State<AdMobView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdMob Challenge'),
      ),
      body: const Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [RewardedAdPage()],
          ),
          BannerAdPage(),
        ],
      ),
    );
  }
}
