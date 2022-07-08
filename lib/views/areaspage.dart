import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../helpers/ad_helper.dart';
import '../main.dart';
import '../repositories/area.dart';
import '../views/zipspage.dart';

class AreasPage extends StatefulWidget {
  final String area;
  const AreasPage({Key? key, required this.area}) : super(key: key);

  @override
  State<AreasPage> createState() => _AreasPageState();
}

class _AreasPageState extends State<AreasPage> with RouteAware {
  final AreaRepository _areaRepository = AreaRepository();
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });

    BannerAd(
        adUnitId: AdHelper.bannerAdUnitId,
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        }, onAdFailedToLoad: (ad, err) {
          debugPrint(err.message);
          ad.dispose();
        })).load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var menu = _areaRepository.menu(widget.area);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.area,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: Stack(
          children: [
            ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 80),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: menu.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    visualDensity:
                        const VisualDensity(vertical: -4), // to compact
                    trailing: const Icon(Icons.chevron_right),
                    title: Text(
                      menu[index],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ZipsPage(area: [widget.area, menu[index]])));
                    },
                  );
                }),
            if (_bannerAd != null)
              Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: _bannerAd!.size.width.toDouble(),
                    height: _bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd!),
                  ))
          ],
        ));
  }
}
