import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zipcodeph_flutter/faves.dart';
import 'package:zipcodeph_flutter/search.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDarkMode = false;

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // _shuffleTrivia();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(10.0),
          margin: MediaQuery.of(context).padding,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(21)),
                      onTap: () {},
                      child: SizedBox(
                        height: 42,
                        width: 42,
                        child: Icon(Icons.info),
                      )),
                  InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(21)),
                      onTap: () {},
                      child: SizedBox(
                          height: 42,
                          width: 42,
                          child: Icon(isDarkMode
                              ? Icons.wb_sunny_rounded
                              : Icons.nightlight_round)))
                ],
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  child: InkWell(
                      onTap: () {
                        _showMyDialog();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Did You Know?',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                          Divider(
                            color: Colors.transparent,
                            height: 10.0,
                          ),
                          Text(
                            'Trivia Text',
                            maxLines: 2,
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.white),
                          ),
                          Divider(
                            color: Colors.transparent,
                            height: 10.0,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(21)),
                                    onTap: () {},
                                    child: SizedBox(
                                        child: Row(
                                      children: [
                                        Icon(Icons.share,
                                            size: 16.0, color: Colors.white),
                                        VerticalDivider(
                                          width: 5.0,
                                        ),
                                        Text('Share',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.white))
                                      ],
                                    )))
                              ])
                        ],
                      )),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF2F80ED),
                          Color(0xFFEB5757),
                        ],
                      ))),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: Row(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        InkWell(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchPage()),
                              );
                            },
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: SizedBox(
                                    height: 42.0,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.search,
                                        ),
                                        VerticalDivider(
                                          width: 5.0,
                                        ),
                                        Text('Search ZIP codes')
                                      ],
                                    ))))
                      ]),
                      Spacer(),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        InkWell(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FavoritesPage()),
                              );
                            },
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: SizedBox(
                                    height: 42,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.favorite_outline,
                                          size: 18.0,
                                        ),
                                        VerticalDivider(
                                          width: 5.0,
                                        ),
                                        Text(
                                          'Favorites',
                                        )
                                      ],
                                    ))))
                      ])
                    ],
                  )),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                            height: 120.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: AssetImage('assets/ncr.png'),
                                  fit: BoxFit.cover,
                                ))),
                        Material(
                          type: MaterialType.transparency,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            onPressed: () {},
                            child: Text(
                              'Metro Manila',
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            height: 120.0,
                            minWidth: MediaQuery.of(context).size.width,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Stack(
                      children: [
                        Container(
                            height: 120.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: AssetImage('assets/luzon.png'),
                                  fit: BoxFit.cover,
                                ))),
                        Material(
                          type: MaterialType.transparency,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            onPressed: () {},
                            child: Text(
                              'Luzon',
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            height: 120.0,
                            minWidth: MediaQuery.of(context).size.width,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Stack(
                      children: [
                        Container(
                            height: 120.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: AssetImage('assets/visayas.png'),
                                  fit: BoxFit.cover,
                                ))),
                        Material(
                          type: MaterialType.transparency,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            onPressed: () {},
                            child: Text(
                              'Visayas',
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            height: 120.0,
                            minWidth: MediaQuery.of(context).size.width,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Stack(
                      children: [
                        Container(
                            height: 120.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: AssetImage('assets/mindanao.png'),
                                  fit: BoxFit.cover,
                                ))),
                        Material(
                          type: MaterialType.transparency,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            onPressed: () {},
                            child: Text(
                              'Mindanao',
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            height: 120.0,
                            minWidth: MediaQuery.of(context).size.width,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ))
            ],
          )),
    );
  }
}
