import 'task.dart';

class MCQ extends SubTask{
  int _mcqId;
  String _answer;
  String _explanation;
  List<MCQOptions>_options;
 
  int get mcqId => this._mcqId;

  set mcqId(int value) => this._mcqId = value;

  get answer => this._answer;

  set answer( value) => this._answer = value;

  get explanation => this._explanation;

  set explanation( value) => this._explanation = value;

  get options => this._options;

  set options( value) => this._options = value;

  MCQ({
    int id,
    String answer,
    List<MCQOptions>options,
    String explanation
  }):_mcqId=id,
    _options=options,
    _explanation=explanation,
    _answer=answer;

  factory MCQ.fromJson(Map<String,dynamic>json)
  {
    List<MCQOptions>options=[];
    options = json['options'].map((i)=>MCQOptions.fromJson((i))).toList();

    return new MCQ(
      answer:json['answer'],
      options: options,
      explanation:json['explanation']
    );
  }

}

class MCQOptions{
  int _mcqOptionId;
  int _mcqId;
  String _option;

  MCQOptions({
    int id,
    int mcqId,
    String option
  }):_mcqOptionId=id,
    _mcqId=mcqId,
    _option=option;

  factory MCQOptions.fromJson(String option)
  {
    return new MCQOptions
    (
      option:option
    );
  }
}