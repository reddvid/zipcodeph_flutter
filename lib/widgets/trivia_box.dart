import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../themes/app_theme.dart';

class TriviaBox extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  TriviaBox({super.key});

  @override
  State<TriviaBox> createState() => _TriviaBoxState();
}

class _TriviaBoxState extends State<TriviaBox> with RouteAware {
  List<dynamic> trivias = [];
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
        trivias.shuffle();
        currentTrivia = trivias.first;
      });
    }
    super.didPopNext();
  }

  void _readTriviasJson() {
    DefaultAssetBundle.of(context).loadString("assets/json/trivias.json").then((
      value,
    ) {
      final jsonResult = jsonDecode(value)["trivias"];
      setState(() {
        trivias = jsonResult;
        trivias.shuffle();
        currentTrivia = trivias.isNotEmpty
            ? trivias.first
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
        maxLines = maxLines == 1 ? 3 : 1;

        // showDialogAlert(
        //   context: context,
        //   title: "Did You Know",
        //   message: currentTrivia,
        //   actionButtonTitle: "Share",
        //   cancelButtonTitle: "Close",
        // ).then(
        //   (result) {
        //     debugPrint(result.toString());
        //     if (result == ButtonActionType.action) {
        //       Share.share(
        //         "Did you know? $currentTrivia #ZIPCodePH",
        //         subject: "Did You Know? ZIP Code PH Trivia",
        //       );
        //     }
        //   },
        // );
      },
      child: AnimatedSize(
        alignment: Alignment.topCenter,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 300),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Did you know?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 5.0),
              RichText(
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: currentTrivia,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              Visibility(
                visible: maxLines == 3,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    child: Icon(
                      Icons.share,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 14.0,
                    ),
                    onTap: () {
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
