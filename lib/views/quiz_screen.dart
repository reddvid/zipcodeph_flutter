import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import '../main.dart';

class AlaminPage extends StatefulWidget {
  const AlaminPage({super.key});

  @override
  State<AlaminPage> createState() => _AlaminPageState();
}

class _AlaminPageState extends State<AlaminPage> with RouteAware {
  late Future<List<dynamic>> _questionsTask;
  int score = 0;
  int totalQuestionsAvailable = 0;
  int currentIndex = 0;
  bool shuffled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });

    _questionsTask = getQuestions();
  }

  Future<List<dynamic>> getQuestions() async {
    try {
      final response = await http
          .get(Uri.parse("https://api.npoint.io/a6b2b68c75794ae319e6"));

      if (response.statusCode == 200) {
        setState(() {
          totalQuestionsAvailable = (jsonDecode(response.body)["quiz"]).length;
        });
        return jsonDecode(response.body)["quiz"];
      }
    } on SocketException {
      return [];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Alamin, Score: $score/$totalQuestionsAvailable"),
        ),
        body: SafeArea(
          child: FutureBuilder<List<dynamic>>(
              future: _questionsTask,
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  if (!shuffled) {
                    snapshot.data!.shuffle();
                    shuffled = true;
                  }
                  List<dynamic> options =
                      snapshot.data![currentIndex]["options"];
                  String answer = snapshot.data![currentIndex]["answer"];
                  if (!options.contains(answer)) options.add(answer);
                  options.shuffle();
                  bool hasAnswered = false;
                  String selectedAnswer = "";
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Card(
                          child: ExpansionTile(
                              initiallyExpanded: false,
                              title: Text("Your stats"))),
                      Card(
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.25,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 20.0),
                              child: Text(
                                snapshot.data![currentIndex]["question"],
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ))),
                      for (var o in options)
                        Card(
                            child: ListTile(
                                trailing: Visibility(
                                    visible: hasAnswered,
                                    child: o.toString() == answer
                                        ? const Icon(Icons.check)
                                        : const Icon(Icons.close)),
                                onTap: () {
                                  SnackBar snackBar;
                                  setState(() {
                                    hasAnswered = true;
                                  });
                                  if (o == answer) {
                                    snackBar = const SnackBar(
                                        duration: Duration(seconds: 3),
                                        content: Text(
                                          "Correct",
                                        ));
                                    setState(() {
                                      score++;
                                    });
                                  } else {
                                    snackBar = const SnackBar(
                                        duration: Duration(seconds: 3),
                                        content: Text(
                                          "Wrong bitches",
                                        ));
                                  }

                                  // Go next
                                  if (currentIndex <
                                      totalQuestionsAvailable - 1) {
                                    setState(() {
                                      currentIndex++;
                                      selectedAnswer = "";
                                    });
                                  } else {
                                    // TODO: Show Total Score
                                  }

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                                title: Text(o.toString()))),
                      const Spacer(),
                    ],
                  );
                } else {
                  return Center(
                      child: Stack(alignment: Alignment.center, children: [
                    Lottie.asset("assets/json/openbook.json"),
                    Container(
                        margin: const EdgeInsets.only(top: 170.0),
                        child: const Text(
                          "Loading questions...",
                          style: TextStyle(),
                        ))
                  ]));
                }
              }),
        ));
  }
}
