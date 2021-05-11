import 'dart:math';

import 'package:Vasha_Shikkha/data/controllers/topic.dart';
import 'package:Vasha_Shikkha/data/db/token.dart';
import 'package:Vasha_Shikkha/data/models/token.dart';
import 'package:Vasha_Shikkha/data/models/topic.dart';
import 'package:flutter/material.dart';
import 'package:Vasha_Shikkha/ui/base/bottom_navbar.dart';
import 'package:Vasha_Shikkha/ui/topic/subtopic_card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TopicScreen extends StatefulWidget {
  final String topicName;

  const TopicScreen({Key key, @required this.topicName}) : super(key: key);

  @override
  _TopicScreenState createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen>
    with SingleTickerProviderStateMixin {
  int _selectedLevel = 1;
  List<int> levels = [1, 2, 3, 4, 5, 6];
  bool _loading = false;
  List<Topic> topics;

  List<String> dummyImages = [
    'assets/img/places.png',
    'assets/img/birds.png',
    'assets/img/food.png',
  ];

  TabController _tabController;
  TopicController _topicController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: levels.length, vsync: this);
    _topicController = TopicController();
    _fetchSubtopics();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchSubtopics() async {
    setState(() {
      _loading = true;
    });
    Token token = await TokenDatabaseHelper().getToken();
    topics = await _topicController.getTopicList(
        token.toString(), widget.topicName, _selectedLevel);
    Future.delayed(
      Duration(seconds: 2),
      () {
        setState(() {
          _loading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
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
      bottomNavigationBar: BottomNavbar(),
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/img/reading.png',
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Text(
                widget.topicName.toUpperCase(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFFFFF0FF),
                ),
                child: TabBar(
                  labelPadding: EdgeInsets.zero,
                  controller: _tabController,
                  indicatorColor: Colors.transparent,
                  onTap: (index) {
                    setState(() {
                      _selectedLevel = index + 1;
                      _fetchSubtopics();
                    });
                  },
                  tabs: levels
                      .map(
                        (level) => level == _selectedLevel
                            ? Chip(
                                backgroundColor: Colors.purple,
                                labelStyle: TextStyle(color: Colors.white),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                label: Text(
                                  'L$level',
                                  style: TextStyle(fontSize: 16),
                                ),
                              )
                            : Text(
                                'L$level',
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 16,
                                ),
                              ),
                      )
                      .toList(),
                ),
              ),
            ),
            _loading
                ? Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SpinKitThreeBounce(
                      color: Theme.of(context).accentColor,
                    ),
                  )
                : _buildSubtopicGrid(_selectedLevel),
          ],
        ),
      ),
    );
  }

  Widget _buildSubtopicGrid(int level) {
    return GridView.count(
      childAspectRatio: 0.75,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: topics
          .map(
            (topic) => SubtopicCard(
              topicName: topic.topicName,
              imageAssetName:
                  dummyImages.elementAt(Random().nextInt(dummyImages.length)),
              progress: Random().nextInt(100).toDouble(),
            ),
          )
          .toList(),
    );
  }
}
