import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zipcodeph_flutter/constants.dart';

class TriviaBox extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  TriviaBox({super.key});

  @override
  State<TriviaBox> createState() => _TriviaBoxState();
}

class _TriviaBoxState extends State<TriviaBox> with RouteAware {
  List<dynamic> triviaList = [];
  String currentTrivia = "";
  bool showTrivia = false;
  int maxLines = 1;

  @override
  void initState() {
    _readTriviasJson();
    super.initState();
  }

  @override
  void didPopNext() {
    if (!showTrivia) {
      setState(() {
        triviaList.shuffle();
        currentTrivia = triviaList.first;
      });
    }
    super.didPopNext();
  }

  void _readTriviasJson() {
    DefaultAssetBundle.of(context)
        .loadString("assets/json/trivias.json")
        .then((value) {
      final jsonResult = jsonDecode(value)["trivias"];
      setState(() {
        triviaList = jsonResult;
        triviaList.shuffle();
        currentTrivia = triviaList.isNotEmpty
            ? triviaList.first
            : "this app was made by one person";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          showTrivia = true;
        });
        maxLines = maxLines == 1 ? 5 : 1;
      },
      child: AnimatedSize(
        alignment: Alignment.topCenter,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 300),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: 15.0,
            left: 15.0,
            right: 15.0,
            bottom: maxLines == 1 ? 16.0 : 12.0,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.red,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Did you know?".toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  maxLines == 1
                      ? const Icon(
                          Icons.keyboard_arrow_down,
                          size: 16.0,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.keyboard_arrow_up,
                          size: 16.0,
                          color: Colors.white,
                        ),
                ],
              ),
              const SizedBox(height: 5.0),
              RichText(
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: currentTrivia,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 5.0),
              Visibility(
                visible: maxLines == 5,
                child: Align(
                  alignment: Alignment.topRight,
                  child: FilledButton.tonal(
                    child: const Text("Share"),
                    onPressed: () {
                      Share.share(
                        "Did you know? $currentTrivia #ZIPCodePH",
                        subject: "Did You Know? ZIP Code PH Trivia",
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
