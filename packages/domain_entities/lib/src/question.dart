class Question {
    const Question({
        required this.title,
        required this.answers,
        required this.rightAnswer,
    });

  final String title;
  final List<String> answers;
  final int rightAnswer;

}