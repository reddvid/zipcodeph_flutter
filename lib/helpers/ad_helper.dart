import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
      //return "ca-app-pub-2042503086093877/2897579782";
    } else {
      throw UnsupportedError('Unsupported paltform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712";
      // return "ca-app-pub-2042503086093877/9825501477";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
