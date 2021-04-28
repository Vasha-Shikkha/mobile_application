class TopicList{
  List<Topic> _topics;
  
  List<Topic> get topics => this._topics;

  set topics(List<Topic> value) => this._topics = value;

  TopicList({
    List<Topic>topics
  }):_topics= topics;

  factory TopicList.fromJson(List<dynamic> json){
    List<Topic>topics = [];
    topics = json.map((i)=>Topic.fromJson((i))).toList();
    return new TopicList(topics:topics);
  }

  factory TopicList.fromDatabase(List<dynamic>maps){
    List<Topic>topics = [];
    topics=maps.map((i)=>Topic.fromDatabase(i)).toList();
    return new TopicList(topics:topics);
  }

}


class Topic{
  int _id;
  String _topicName;
  String _topicType;
  String _image;
  
  get id => this._id;

  set id( value) => this._id = value;

  get topicName => this._topicName;

  set topicName( value) => this._topicName = value;

  get topicType => this._topicType;

  set topicType( value) => this._topicType = value;

  get image => this._image;

  set image( value) => this._image = value;

  Topic({
    int id,
    String topicName,
    String topicType,
    String image
  }): _id=id,
      _topicName=topicName,
      _topicType=topicType,
      _image=image;

  factory Topic.fromJson (Map<String,dynamic> json)
  { 
    print("Zekrom");
    return new Topic
    (
      id:json['id'],
      topicName:json['name'],
      topicType:json['type'],
      image:json['image']
    );
  }

  Map<String,dynamic>toDatabase()
  { 
    Map<String,dynamic>result= new Map();
    result['TopicId'] = id;
    result['TopicName'] = topicName;
    result['TopicType'] = topicType;
    result['TopicImage'] = image;

    return result;
  }

  factory Topic.fromDatabase(Map<String,dynamic>map)
  {
    return new Topic
    (
      id: map['TopicId'],
      topicName: map['TopicName'],
      topicType: map['TopicType'],
      image: map['TopicImage'],
    );
  }

  void debugMessage()
  {
    String message="PK: "+id.toString()+" ,Name: "+topicName+", Type: "+topicType;
    print(message);
  }
}


class TopicLevelCountList{
  List<TopicLevelCount>_countList;
  
  get countList => this._countList;

  set countList(List<TopicLevelCount> value) => this._countList = value;

  TopicLevelCountList({List<TopicLevelCount>countList}):_countList=countList;

  factory TopicLevelCountList.fromJson(List<dynamic> json){
    List<TopicLevelCount>countList = [];
    countList = json.map((i)=>TopicLevelCount.fromJson((i))).toList();
    return new TopicLevelCountList(countList:countList);
  }

  factory TopicLevelCountList.fromDatabase(List<dynamic> maps){
    List<TopicLevelCount>countList = [];
    countList = maps.map((i)=>TopicLevelCount.fromDatabase((i))).toList();
    return new TopicLevelCountList(countList:countList);
  }
}


class TopicLevelCount{
  int _id;
  int _topicId;
  int _level;
  int _count;
  
  get id => this._id;

  set id( value) => this._id = value;

  get topicId => this._topicId;

  set topicId( value) => this._topicId = value;

  get level => this._level;

  set level( value) => this._level = value;

  get count => this._count;

  set count( value) => this._count = value;
  
  TopicLevelCount({
    int id,
    int topicId,
    int level,
    int count
  }):_id=id,
    _topicId=topicId,
    _level=level,
    _count=count;

  factory TopicLevelCount.fromJson(Map<String,dynamic>json){
      
      return new TopicLevelCount
      (
        id:json['id'],
        topicId:json['topic_id'],
        level:json['level'],
        count:json['count']
      );
  }

  Map<String,dynamic>toDatabase()
  {

    Map<String,dynamic>result = new Map();
    result['TopicLevelCountId']=id;
    result['TopicId']=topicId;
    result['Level']=level;
    result['Count']=count;

    return result;
  }

  factory TopicLevelCount.fromDatabase(Map<String,dynamic>map)
  {
    return new TopicLevelCount(
      id : map['TopicLevelCountId'],
      topicId: map['TopicId'],
      level: map['Level'],
      count: map['Count']
    );
  }

  /*
  void debugMessage()
  {
    String message="PK: "+id+" ,TopicId: "+topicId+", Level: "+level;
    print(message);
  }
  */
}