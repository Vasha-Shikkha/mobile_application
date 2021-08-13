import 'dart:math';

import 'package:Vasha_Shikkha/data/controllers/dict.dart';
import 'package:Vasha_Shikkha/data/models/dict.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Flashcard extends StatefulWidget {
  static const String route = '/flashcard';

  @override
  _FlashcardState createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> {
  final String meaning =
      "A word having the same or almost the same meaning as another word";
  DictController dictController;
  List<DictEntry> flashCards;
  bool loading;
  int currentIndex;

  Future<void> fetchFlashCards() async {
    setState(() {
      loading = true;
      currentIndex = 0;
    });
    try {
      flashCards = await dictController.getFlashCards();
      print(flashCards);
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    dictController = new DictController();
    loading = false;
    fetchFlashCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          icon: Icon(
            Icons.cancel,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "FLASH CARDS",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColorDark,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32.0,
          vertical: 8.0,
        ),
        child: (loading || flashCards.isEmpty)
            ? Container(
                width: 0,
                height: 0,
              )
            : ElevatedButton(
                child: Text(
                  "Next",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  setState(() {
                    if (currentIndex + 1 < flashCards.length) {
                      currentIndex++;
                    } else {
                      currentIndex = 0;
                    }
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColorLight),
                  foregroundColor: MaterialStateProperty.all(Colors.deepPurple),
                  elevation: MaterialStateProperty.all(5.0),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  shadowColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColorDark),
                ),
              ),
      ),
      body: loading
          ? SizedBox(
              width: 50,
              child: SpinKitWanderingCubes(
                size: 20,
                color: Theme.of(context).primaryColorDark,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(80.0),
              child: flashCards.isEmpty
                  ? Center(
                      child: Text(
                        'Please try a few exercises to learn new words',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : Stack(
                      alignment: Alignment.center,
                      fit: StackFit.expand,
                      children: [
                        Transform.rotate(
                          angle: -pi / 8,
                          child: Card(
                            elevation: 10,
                            color: Colors.white,
                            shadowColor: Theme.of(context).primaryColorLight,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        Transform.rotate(
                          angle: -pi / 16,
                          child: Card(
                            elevation: 10,
                            color: Colors.white,
                            shadowColor: Theme.of(context).primaryColorLight,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 10,
                          color: Colors.white,
                          shadowColor: Theme.of(context).primaryColorLight,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  flashCards[currentIndex].word,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                                Divider(
                                  indent: 40,
                                  endIndent: 40,
                                  height: 4,
                                  thickness: 2,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 2,
                                    );
                                  },
                                  itemCount:
                                      flashCards[currentIndex].meanings.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal: 16.0,
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: CircleAvatar(
                                              radius: 8,
                                              child: Text(
                                                "${index + 1}",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            flashCards[currentIndex]
                                                .meanings[index],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "Examples",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                flashCards[currentIndex].examples.isEmpty
                                    ? Text("No example available")
                                    : ListView.separated(
                                        shrinkWrap: true,
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                            height: 2,
                                          );
                                        },
                                        itemCount: flashCards[currentIndex]
                                            .examples
                                            .length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8.0,
                                              horizontal: 16.0,
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: CircleAvatar(
                                                    radius: 8,
                                                    child: Text(
                                                      "${index + 1}",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  flashCards[currentIndex]
                                                      .examples[index],
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
    );
  }
}
