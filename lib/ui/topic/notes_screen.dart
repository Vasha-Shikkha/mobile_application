import 'package:flutter/material.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class NotesScreen extends StatefulWidget {
  final String subtopicName;
  final Widget exercise;
  final String notes;

  const NotesScreen({
    Key key,
    @required this.subtopicName,
    @required this.exercise,
    @required this.notes,
  }) : super(key: key);

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CircleAvatar(
            radius: 10,
            backgroundColor: Color(0xFFFFB8B8),
            child: IconButton(
              padding: EdgeInsets.all(0),
              iconSize: 20,
              color: Colors.white,
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 10,
        decoration: BoxDecoration(
          color: Theme.of(context).disabledColor,
          border: Border(
            top: BorderSide(color: Theme.of(context).primaryColorLight),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).primaryColorDark),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => widget.exercise,
                ),
              );
            },
            child: Text(
              'Try Exercises',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              widget.subtopicName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Scrollbar(
              controller: _scrollController,
              isAlwaysShown: true,
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 200),
                child: HtmlWidget(
                  md.markdownToHtml(
                    widget.notes,
                    extensionSet: md.ExtensionSet.gitHubWeb,
                  ),
                  customStylesBuilder: (element) {
                    if (element.localName == 'table') {
                      return {
                        'border': '1px solid grey',
                        'border-collapse': 'collapse',
                      };
                    }
                    if (element.localName == 'th' ||
                        element.localName == 'td') {
                      return {
                        'border': '1px solid grey',
                        'padding': '10px',
                      };
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
