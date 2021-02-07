import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';

class AdMobService {
  static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['quiz', 'quiz app'],
    contentUrl: 'https://flutter.io',
    childDirected: false,
    /*
     testDevices: <String>[
      "6060867288BB65EA291435A65837982F"
    ],
     */
  );

  String getInterstitialAdId() {
    if (Platform.isIOS) {
//      return '';
      return 'ca-app-pub-3940256099942544/4411468910';
    } else if (Platform.isAndroid) {
//      return '';
      return "ca-app-pub-7320294568722835/2930119744";
    }
    return null;
  }

  static InterstitialAd getNewTripInterstitial() {
    return InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
      targetingInfo: MobileAdTargetingInfo(
        testDevices: <String>["6060867288BB65EA291435A65837982F"],
      ),
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
        if (event == MobileAdEvent.closed) {}
      },
    );
  }
}
