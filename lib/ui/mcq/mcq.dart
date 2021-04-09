class MCQ {
  final int id;
  final String question;
  final List<String> options;
  final String correctOption;

  MCQ({this.id, this.question, this.options, this.correctOption});

  factory MCQ.fromJson(Map<String, dynamic> json) {
    List<String> options = [];
    options.add(json['option1']);
    options.add(json['option2']);
    options.add(json['option3']);
    return MCQ(
      id: json['id'] as int,
      question: json['question'] as String,
      options: options,
      correctOption: json['correct_option'] as String,
    );
  }
}
