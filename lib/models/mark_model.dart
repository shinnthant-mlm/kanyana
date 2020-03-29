class Marks {
  String markTable = 'tblMark';
  String questionSet;
  int mark;

  Marks({this.questionSet, this.mark});

  Map<String, dynamic> toMap() => {'questionSet': questionSet, 'mark': mark};

  Marks fromMap(Map<String, dynamic> map) =>
      Marks(questionSet: map['questionSet'], mark: map['mark']);
}
