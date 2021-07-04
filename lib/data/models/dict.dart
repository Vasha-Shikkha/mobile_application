class Dictionary{
  List<DictEntry>_list;

  List<DictEntry> get list => this._list;

  set list(List<DictEntry> value) => this._list = value;

  Dictionary({
    List<DictEntry>list
  }):_list= list;

  factory Dictionary.fromJson(List<dynamic> json){
    
    List<DictEntry>dict = [];

    dict= json.map((e) => DictEntry.fromJson(e)).toList();

    return new Dictionary(list:dict);
  }
}

class DictEntry{
  String _word;
  List<String> _meanings;
  List<String> _examples;
  DateTime _timestamp;

  get word => this._word;

  set word( value) => this._word = value;

  get meanings => this._meanings;

  set meanings( value) => this._meanings = value;

  get examples => this._examples;

  set examples( value) => this._examples = value;

  get timestamp => this._timestamp;

  set timestamp( value) => this._timestamp = value;

  DictEntry({
    String word,
    List<String> meanings,
    List<String> examples,
    DateTime timestamp
  }):_word= word,
    _meanings=meanings,
    _examples=examples,
    _timestamp=timestamp;

  factory DictEntry.fromJson(Map<String,dynamic>json)
  {
    List<String>wordMeanings=[];
    List<String>wordExamples=[];
  
    if(json['meaning']!=null)
    {
      for(String meaning in json['meaning'])
        wordMeanings.add(meaning);
    }

    if(json['example']!=null)
    {
      for(String example in json['example'])
        wordExamples.add(example);
    }
  
    return new DictEntry(
      word:json['word'],
      meanings: wordMeanings,
      examples: wordExamples,
      timestamp: null,
    );
  
  }

  String concatenateElement(List<String>list)
  {
    
    if(list.isEmpty)
      return null;
    String result="";
    for(String element in list)
      result=result+element+"#";
    result=result.substring(0,result.length-1);
    return result;
  }

  Map<String,dynamic>toDict(){
    Map<String,dynamic>map = new Map();
  
    map['Word']=word;
    map['Meaning']=concatenateElement(meanings);
    map['Examples']=concatenateElement(examples);

    return map;
  }

  void debugMessage()
  {
    print("Word: "+word.toString());
    print("Meaning: "+concatenateElement(meanings));
  }

  factory DictEntry.fromDatabase(Map<String,dynamic>json)
  { 
    List<String>wordMeanings=[];
    List<String>wordExamples=[];

    
    if(json['Meaning']!=null)
    { 
      print("gegege");
      wordMeanings=json['Meaning'].split('#');
    }
      
    if(json['Examples']!=null)
    { 
      print("Hello World");
      wordExamples=json['Examples'].split('#');
    }
      

    return new DictEntry(
      word:json['Word'],
      meanings: wordMeanings,
      examples: wordExamples,
      
    );
  }
}