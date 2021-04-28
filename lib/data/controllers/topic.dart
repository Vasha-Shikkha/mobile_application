

import '../models/token.dart';
import '../models/topic.dart';
import '../rest/topic.dart'; // just for testing
import '../db/topic.dart';

class TopicController{
  TopicRest topicRest = new TopicRest();
  TopicDatabaseHelper topicDatabaseHelper = new TopicDatabaseHelper();

  Future<void>_insertTopicList(TopicList topicList) async{
    List<Topic>list = topicList.topics;

    for(int i =0;i<list.length;i++)
      topicDatabaseHelper.insertTopic(list[i].toDatabase());
  }

  Future<void>_insertCountList(TopicLevelCountList topicLevelCountList){
    List<TopicLevelCount>list = topicLevelCountList.countList;
    for(int i=0;i<list.length;i++)
      topicDatabaseHelper.insertTopicLevelCount(list[i].toDatabase());
  }

  Future<List<Topic>> getTopicList(String token,String topicType,int level) async{
    //since data will persist, we just see whether we have downloaded
    //the data before or not.
    int count = await topicDatabaseHelper.getCount();
    TopicList topicList;
    TopicLevelCountList topicLevelCountList;
    if(count == 0){
      //we will deal with the errors later. For now, this
      //will do
      topicList = await topicRest.getAllTopics(token);
      topicLevelCountList = await topicRest.getTopicCounts(token);

      _insertTopicList(topicList);
      _insertCountList(topicLevelCountList);
    }
    List<Topic> result = await topicDatabaseHelper.getTopics(topicType,level);
    return result;
  }
}
