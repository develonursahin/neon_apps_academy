import 'package:ad_mob_app/ad_helper.dart';
import 'package:ad_mob_app/ad_view.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdPage extends StatefulWidget {
  const InterstitialAdPage({super.key});

  @override
  State<InterstitialAdPage> createState() => _InterstitialAdPageState();
}

class _InterstitialAdPageState extends State<InterstitialAdPage> {
  InterstitialAd? _interstitialAd;
  bool _isAdLoaded = false;
  bool _isAdShown = false;

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  void loadAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          setState(() {
            _isAdLoaded = true;
          });
          debugPrint('InterstitialAd loaded.');
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  /// Shows the interstitial ad.
  void showInterstitialAd() {
    if (_isAdLoaded && _interstitialAd != null && !_isAdShown) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {
          _isAdShown = true;
        },
        onAdImpression: (ad) {},
        onAdDismissedFullScreenContent: (ad) {
          reloadAd();
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AdMobView(),
          ));
        },
        onAdFailedToShowFullScreenContent: (ad, err) {
          reloadAd();
        },
        onAdClicked: (ad) {},
      );
      _interstitialAd!.show();
    } else {
      debugPrint('InterstitialAd not ready yet.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Reklam yükleniyor...'),
          duration: Duration(seconds: 2),
        ),
      );
      loadAd();
    }
  }

  void reloadAd() {
    _interstitialAd?.dispose();
    _interstitialAd = null;
    _isAdLoaded = false;
    _isAdShown = false;
    loadAd();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (_isAdLoaded) {
            showInterstitialAd();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Reklam yükleniyor...'),
                duration: Duration(seconds: 2),
              ),
            );
            loadAd();
          }
        },
        child: const Text('Reklam Sayfasına Git'),
      ),
    );
  }
}

class DuzClass {
  InterstitialAd? interstitialAd;
  bool isAdLoaded = false;
  bool isAdShown = false;

  Future<void> loadAd() async {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          isAdLoaded = true;
          debugPrint('InterstitialAd loaded.');
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  void showInterstitialAd() {
    if (isAdLoaded && !isAdShown) {
      interstitialAd!.show();
      isAdShown = true;
    } else {
      isAdLoaded =
          false; // Reset the flag to ensure ad loading is attempted again
      loadAd();
    }
  }
}
