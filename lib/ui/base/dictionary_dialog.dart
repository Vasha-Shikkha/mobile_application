import 'package:Vasha_Shikkha/data/controllers/dict.dart';
import 'package:Vasha_Shikkha/data/models/dict.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DictionaryDialog extends StatefulWidget {
  @override
  _DictionaryDialogState createState() => _DictionaryDialogState();
}

class _DictionaryDialogState extends State<DictionaryDialog> {
  DictController dictController;
  bool loading;
  List<String> words;
  String searchWord;
  DictEntry searchResult;

  Future<void> fetchWordsFromDictionary() async {
    setState(() {
      loading = true;
    });
    try {
      words = await dictController.getWordList();
      print(words);
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> fetchSearchResult() async {
    try {
      searchResult = await dictController.getDictEntry(searchWord);
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    dictController = DictController();
    loading = false;
    fetchWordsFromDictionary();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height / 5,
        horizontal: 40,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: loading
            ? Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 30.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.8,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.8,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Dictionary Search",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      IconButton(
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
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).disabledColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: Theme(
                        data: ThemeData(
                          textSelectionTheme: TextSelectionThemeData(
                            cursorColor: Theme.of(context).primaryColorDark,
                          ),
                          inputDecorationTheme: InputDecorationTheme(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColorDark),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColorDark,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        child: Autocomplete(
                          optionsBuilder: (TextEditingValue value) {
                            // When the field is empty
                            if (value.text.isEmpty) {
                              setState(() {
                                searchResult = null;
                              });
                              return [];
                            }

                            // The logic to find out which ones should appear
                            return words
                                .where((suggestion) => suggestion
                                    .toLowerCase()
                                    .startsWith(value.text.toLowerCase()))
                                .take(5);
                          },
                          onSelected: (value) {
                            setState(() {
                              searchWord = value;
                              fetchSearchResult();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  searchResult == null
                      ? Container()
                      : Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Meanings",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 2,
                                );
                              },
                              itemCount: searchResult.meanings.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: CircleAvatar(
                                          radius: 8,
                                          child: Text(
                                            "${index + 1}",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        searchResult.meanings[index],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                ],
              ),
      ),
    );
  }
}
