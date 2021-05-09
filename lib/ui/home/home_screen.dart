import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Vasha_Shikkha/ui/base/bottom_navbar.dart';
import 'package:Vasha_Shikkha/ui/topic/topic_screen.dart';

class HomeScreen extends StatelessWidget {
  static final String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'VASHA SHIKKHA',
            style: TextStyle(
              color: Colors.purple,
              fontSize: 24,
            ),
          ),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 8.0),
            iconSize: 32,
            color: Colors.purple,
            onPressed: () {},
            icon: Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: SvgPicture.asset('assets/img/welcome.svg'),
              ),
            ),
            Text(
              'Welcome Learner!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Keep practising your English by completing new lessons and revisiting your old lessons',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TopicCard(
                  topicName: 'COMMUNICATIVE',
                  imageAssetName: 'assets/img/vocabulary.png',
                ),
                TopicCard(
                  topicName: 'GRAMMAR',
                  imageAssetName: 'assets/img/grammar.png',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TopicCard extends StatelessWidget {
  final String topicName;
  final String imageAssetName;

  const TopicCard({
    Key key,
    @required this.topicName,
    @required this.imageAssetName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TopicScreen(
              topicName: topicName,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.purple.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  imageAssetName,
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.width * 0.25,
                ),
              ),
            ),
            Text(
              topicName,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
