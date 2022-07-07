import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
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
        appBar: AppBar(title: const Text("Help & About")),
        body: ListView.separated(
            itemCount: 1,
            separatorBuilder: (context, index) => const Divider(
                  color: Colors.black,
                ),
            itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                        title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              "What is a ZIP Code?",
                              style: Theme.of(context).textTheme.headline6,
                            )),
                        Text(
                            "ZIP (Zone Identification Plan) Codes are a system of postal codes first used by the United States Postal Services (USPS) in 1963 - so that the mail travels more efficiently, and therefore more quickly, when senders use the code in the postal address.",
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    )),
                    ListTile(
                        title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text(
                              "In the Philippines, the ZIP Code is used by the Philippine Postal Corporation (PhilPost) to simplify the distribution of mail.",
                              style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(height: 20),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                "Where to put the ZIP Code?",
                                style: Theme.of(context).textTheme.headline6,
                              )),
                          Text(
                              "The ZIP Code is usually placed at the left-hand corner of the last line where the city/town is written:",
                              style: Theme.of(context).textTheme.bodyMedium),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                                border: Border(
                              top: BorderSide(width: 1, color: Colors.grey),
                              left: BorderSide(width: 1, color: Colors.grey),
                              right: BorderSide(width: 1, color: Colors.grey),
                              bottom: BorderSide(width: 1, color: Colors.grey),
                            )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Mr. Juan Dela Cruz",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  "Malacañang Complex",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  "J.P. Laurel Street",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  "1005 San Miguel, Manila",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic),
                                )
                              ],
                            ),
                          ),
                        ])),
                    ListTile(
                      leading: Transform.translate(
                          offset: const Offset(0, 0),
                          child: const Icon(Icons.share_outlined)),
                      minLeadingWidth: 0,
                      title: Transform.translate(
                        offset: const Offset(0, 0),
                        child: const Text("Share app to your friends"),
                      ),
                      onTap: () {
                        Share.share(
                            'Sending out mail or parcel? Or even filling out forms? Look up Philippines ZIP codes in ZIP Code PH app. Download here: https://reddavid.me/zipcodeph-app/',
                            subject: "Share ZIP Code PH app");
                      },
                    ),
                    ListTile(
                      leading: Transform.translate(
                          offset: const Offset(0, 0),
                          child: const Icon(Icons.coffee_outlined)),
                      minLeadingWidth: 0,
                      title: Transform.translate(
                        offset: const Offset(0, 0),
                        child: const Text("Buy me a coffee"),
                      ),
                      onTap: () {
                        _launchUrl("https://buymeacoffee.com/reddavid");
                      },
                    ),
                    ListTile(
                      leading: Transform.translate(
                          offset: const Offset(0, 0),
                          child: const Icon(Icons.feedback_outlined)),
                      minLeadingWidth: 0,
                      title: Transform.translate(
                        offset: const Offset(0, 0),
                        child: const Text("Send feedback"),
                      ),
                      onTap: () {
                        _launchUrl(
                            "mailto:reddavidapps?subject=[FEEDBACK] ZIP Code PH&body=App version: " +
                                _packageInfo.version +
                                " build " +
                                _packageInfo.buildNumber);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                        title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Photo/Image Attributions:"),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                            onTap: () {
                              _launchUrl(
                                  "https://unsplash.com/@seanyoro?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText");
                            },
                            child: Text("Makati City during Night by Sean Yoro",
                                style: Theme.of(context).textTheme.bodyMedium)),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                            onTap: () {
                              _launchUrl(
                                  "https://unsplash.com/es/@camillesanvicente?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText");
                            },
                            child: Text("Mayon Volcano by Camille San Vicente",
                                style: Theme.of(context).textTheme.bodyMedium)),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                            onTap: () {
                              _launchUrl(
                                  "https://unsplash.com/@rob1p?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText");
                            },
                            child: Text("Bohol Chocolate Hills by Robin P",
                                style: Theme.of(context).textTheme.bodyMedium)),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                            onTap: () {
                              _launchUrl(
                                  "https://unsplash.com/es/@aluengo91?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText");
                            },
                            child: Text("Kawhagan Island by Alejandro Luengo",
                                style: Theme.of(context).textTheme.bodyMedium)),
                      ],
                    )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(15, 20, 10, 20),
                        child: Text(
                          "version " +
                              _packageInfo.version +
                              "b" +
                              _packageInfo.buildNumber,
                          style: const TextStyle(
                              fontSize: 12.0, color: Colors.grey),
                        ))
                  ],
                )));
  }

  void _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }
}
