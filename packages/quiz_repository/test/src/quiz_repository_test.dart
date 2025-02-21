import 'package:domain_entities/domain_entities.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quiz_repository/quiz_repository.dart';

class MockQuizLocalStorage extends Mock implements QuizLocalStorage {}

void main() {
  late QuizRepository quizRepository;

  group('QuizLocalStorage', () {
    late MockQuizLocalStorage mockQuizLocalStorage;
    setUp(() {
      mockQuizLocalStorage = MockQuizLocalStorage();
      quizRepository = QuizRepository(storage: mockQuizLocalStorage);
    });

    final quizLocal = [
      Quiz(
        creator: 'Fabrioche',
        title: 'Étudiants de la classe ICH-2DEV',
        description: 'Connaissez vous les étudiants de la classe ICH-2DEV?',
        id: 'Hello',
        tags: ['#Etudiant', '#Ecole'],
        questions: [
          Question(
            title: 'Quel est le nom de famille de Fabian?',
            answers: [
              Response(text: 'Ewan', correct: false),
              Response(text: 'Quentin', correct: true),
              Response(text: 'Martim', correct: false),
              Response(text: 'Le Hockey', correct: false),
            ],
          )
        ],
      ),
      Quiz(
        creator: 'Fabrioche',
        title: 'Culture générale',
        description: 'Savez vous des choses innutiles?',
        id: 'Hallo',
        tags: ['#Culture', '#General'],
        questions: [
          Question(
            title: 'Quelle est la capitale de la suisse?',
            answers: [
              Response(text: 'Le Hockey', correct: false),
              Response(text: 'Quentin', correct: true),
              Response(text: 'Ewan', correct: false),
              Response(text: 'Fabian', correct: true),
            ],
          )
        ],
      ),
    ];
    void prepaMockReturnQuiz() {
      when(() => mockQuizLocalStorage.getAllQuizzes())
          .thenAnswer((_) async => quizLocal);
    }

    test('QuizRepo getAllQuizzes call getAllQuiz of QuizLocalStorage', () {
      prepaMockReturnQuiz();
      quizRepository.getAllQuizzes();
      verify(() => mockQuizLocalStorage.getAllQuizzes()).called(1);
    });
    test('QuizRepo getAllQuizzes return two Quizzes', () async {
      prepaMockReturnQuiz();
      final result = await quizRepository.getAllQuizzes();
      expect(result.length, 2);
    });
    test('QuizRepo getAllQuizzes return Quizzes with good values', () async {
      prepaMockReturnQuiz();
      final result = await quizRepository.getAllQuizzes();
      expect(result, quizLocal);
    });
  });
}
