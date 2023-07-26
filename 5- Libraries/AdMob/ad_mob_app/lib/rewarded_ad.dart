import 'package:ad_mob_app/ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedAdPage extends StatefulWidget {
  const RewardedAdPage({super.key});

  @override
  State<RewardedAdPage> createState() => _RewardedAdPageState();
}

class _RewardedAdPageState extends State<RewardedAdPage> {
  RewardedAd? _rewardedAd;
  bool _isAdLoaded = false;
  bool _isAdShown = false;

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  void loadAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {
              _isAdShown = true;
            },
            onAdImpression: (ad) {},
            onAdFailedToShowFullScreenContent: (ad, err) {
              ad.dispose();
            },
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _isAdLoaded = false;
              _isAdShown = false;
            },
            onAdClicked: (ad) {},
          );

          debugPrint('$ad loaded.');
          _rewardedAd = ad;
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('RewardedAd failed to load: $error');
        },
      ),
    );
  }

  void showAd() {
    if (_isAdLoaded && !_isAdShown) {
      _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {},
      );
    } else {
      debugPrint('RewardedAd not ready yet or already shown.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Reklam yükleniyor...'),
          duration: Duration(seconds: 2),
        ),
      );
      loadAd();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          showAd();
        },
        child: const Text('Ödüllü Reklamı Göster'),
      ),
    );
  }
}
