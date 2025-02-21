import 'package:domain_entities/domain_entities.dart';
import 'package:equatable/equatable.dart';

class Question extends Equatable {
  const Question({
    required this.title,
    required this.answers,
  });

  final String title;
  final List<Response> answers;

  @override
  List<Object?> get props => [
        title,
        answers,
      ];

  @override
  bool? get stringify => true;
}
