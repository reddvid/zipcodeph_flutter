import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../constants.dart';
import '../widgets/tile_icon.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: "",
    packageName: "",
    version: "",
    buildNumber: "",
  );

  @override
  void initState() {
    _initPackageInfo();
    super.initState();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Help & About".toUpperCase(),
          style: kAppBarTitleStyle,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 16.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        "What is a ZIP Code?",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    subtitle: Text(
                      "ZIP (Zone Identification Plan) Codes are a system of postal codes first used by the United States Postal Services (USPS) in 1963 - so that the mail travels more efficiently, and therefore more quickly, when senders use the code in the postal address.\n\nIn the Philippines, the ZIP Code is used by the Philippine Postal Corporation (PhilPost) to simplify the distribution of mail.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        "Where to put the ZIP Code?",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                            "The ZIP Code is usually placed at the left-hand corner of the last line where the city/town is written:",
                            style: Theme.of(context).textTheme.bodyMedium),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 16.0),
                          padding: const EdgeInsets.only(
                            top: 24.0,
                            left: 24.0,
                            right: 24.0,
                            bottom: 40.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.0,
                              color: const Color(0xFFEAD0A5),
                            ),
                            color: Colors.brown.shade100,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x33000000),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (String text in sampleFormatText)
                                Text(
                                  text,
                                  style: const TextStyle(
                                    fontSize: 10.0,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            TileIcon(
              iconData: Icons.share,
              label: "Share this app",
              onTap: () {
                Share.share(
                    'Sending out mail or parcel? Or even filling out forms? Look up Philippines ZIP codes in ZIP Code PH app. Download here: https://reddavid.me/zipcodeph-app/',
                    subject: "Share ZIP Code PH app");
              },
            ),
            TileIcon(
              iconData: Icons.feedback,
              label: "Send feedback",
              onTap: () {
                launchUrlString(
                    "mailto:hi@reddavid.me?subject=[FEEDBACK] ZIP Code PH (Pro)&body=App version: ${_packageInfo.version} build ${_packageInfo.buildNumber}");
              },
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 24.0,
                left: 16.0,
                right: 16.0,
                bottom: 16.0,
              ),
              child: Text(
                "Photo/Image Attributions:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                children: [
                  for (Set<String> attrib in kAttributions)
                    ListTile(
                      visualDensity: const VisualDensity(vertical: -4.0),
                      onTap: () {
                        launchUrlString(attrib.last.toString());
                      },
                      dense: true,
                      title: Text(
                        attrib.first,
                        style: const TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    )
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 24.0, horizontal: 16.0),
                child: Text(
                  "version ${_packageInfo.version} build ${_packageInfo.buildNumber}",
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
