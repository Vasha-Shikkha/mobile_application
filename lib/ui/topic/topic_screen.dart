import 'package:flutter/material.dart';
import 'package:vasha_shikkha/ui/base/bottom_navbar.dart';
import 'package:vasha_shikkha/ui/topic/subtopic_card.dart';

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
  List<SubTopic> subTopics = [
    SubTopic(name: 'Places', imageAsset: 'assets/img/places.png', progress: 44),
    SubTopic(name: 'Birds', imageAsset: 'assets/img/birds.png', progress: 12),
    SubTopic(name: 'Food', imageAsset: 'assets/img/food.png'),
  ];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: levels.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
                widget.topicName,
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
            _buildSubtopicGrid(_selectedLevel),
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
      children: subTopics
          .map(
            (e) => SubtopicCard(
              topicName: e.name,
              imageAssetName: e.imageAsset,
              progress: e.progress,
            ),
          )
          .toList(),
    );
  }
}

class SubTopic {
  final String name;
  final String imageAsset;
  final double progress;

  SubTopic({@required this.name, @required this.imageAsset, this.progress = 0});
}
