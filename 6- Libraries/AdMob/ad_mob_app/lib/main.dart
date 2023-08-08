import 'package:ad_mob_app/interstitial_ad.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AdMob(),
    );
  }
}

class AdMob extends StatefulWidget {
  const AdMob({Key? key}) : super(key: key);

  @override
  AdMobState createState() => AdMobState();
}

class AdMobState extends State<AdMob> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdMob App'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [InterstitialAdPage()],
        ),
      ),
    );
  }
}
