import 'package:domain_entities/domain_entities.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_repository/quiz_repository.dart';

void main() {
  late Map<String, dynamic> questionData;
  late Map<String, dynamic> quizData;
  late Question question;

  setUp(() {
    questionData = {
      "title": "Quel est le nom de famille de Fabian?",
      "responses": [
        {"text": "Ewan"},
        {"text": "Quentin", "correct": true},
        {"text": "Martim"},
        {"text": "Le Hockey"},
      ]
    };
    quizData = {
      "id": "quiz1",
      "creator": "Fabrioche",
      "title": "Étudiants de la classe ICH-2DEV",
      "description": "Connaissez vous les étudiants de la classe ICH-2DEV?",
      "tags": ["#Etudiant", "#Ecole"],
      "questions": [
        {
          "title": "Quel est le nom de famille de Fabian?",
          "responses": ["Martin", "Marti", "Martim", "Marteau"],
          "correct_answer": 2
        },
        {
          "title": "Quel est le surnom de Ethan Hoftetter?",
          "responses": ["Bratch", "Mini", "Greg", "Niry"],
          "correct_answer": 4
        },
        {
          "title": "Quelle spécialisation ne va pas prendre Simon Golay?",
          "responses": ["Web", "C#", "Mobile"],
          "correct_answer": 3
        },
        {
          "title": "Quel est le sport favori de Ethan Bracelli?",
          "responses": ["L'escalade", "Le foot", "Le Rugby", "Le Hockey"],
          "correct_answer": 4
        },
        {
          "title": "Qui a eu la meilleure note au cie 295?",
          "responses": ["Ewan", "Ylan", "Ryan", "Fabian"],
          "correct_answer": 2
        },
        {
          "title": "Laquelle de ces personnes préfère le cours de mobile?",
          "responses": ["Simon", "Quentin", "Martim", "Fabian"],
          "correct_answer": 2
        },
        {
          "title":
              "D'une manière très objective quel est le meilleurs cours du jeudi?",
          "responses": ["Agilité", "NoSQL", "Docker", "Mandats-2.0"],
          "correct_answer": 3
        },
        {
          "title": "Qui est le maître de classe des ICH-2DEV ce semestre?",
          "responses": ["Guerdat", "Mathez", "Vogel", "Gagnebin"],
          "correct_answer": 1
        },
        {
          "title":
              "A partir de quelle note Fabian Marti va venir râler auprès du prof?",
          "responses": ["4", "5", "5.2", "5.5"],
          "correct_answer": 3
        },
        {
          "title":
              "Combien d'élèves sont dans la classe ICH-2DEV? (plein-temps)",
          "responses": ["14", "15", "12", "17"],
          "correct_answer": 1
        },
        {
          "title": "Quel jeu a réussi a terminer l'ensemble de la classe?",
          "responses": [
            "Aucun",
            "Minecraft",
            "Make more paperclips",
            "Cookie clicker"
          ],
          "correct_answer": 2
        },
        {
          "title": "M Guerdat est-il le meilleur prof?",
          "responses": ["Oui", "Non"],
          "correct_answer": 1
        }
      ]
    };
    question = Question(
      title: 'Quel est le nom de famille de Fabian?',
      answers: [
        Response(text: 'Ewan', correct: false),
        Response(text: 'Quentin', correct: true),
        Response(text: 'Martim', correct: false),
        Response(text: 'Le Hockey', correct: false)
      ],
    );
  });

  test('QuestionLocalModel.fromJson return a Question', () {
    expect(QuestionLocalModel.fromJson(questionData).toDomainEntity([]),
        isA<Question>());
  });

  test('QuestionLocalModel.fromJson return a Question with good values', () {
    expect(
        QuestionLocalModel.fromJson(questionData).toDomainEntity([]), question);
  });

  test('QuizLocalModel.fromJson return a Quiz', () {
    expect(QuizLocalModel.fromJson(quizData).toDomainEntity([question]),
        isA<Quiz>());
  });

  test('QuizLocalModel.fromJson return a Quiz with good values', () {
    expect(
        QuizLocalModel.fromJson(quizData).toDomainEntity([question]),
        Quiz(
            id: 'quiz1',
            creator: 'Fabrioche',
            title: 'Étudiants de la classe ICH-2DEV',
            description: 'Connaissez vous les étudiants de la classe ICH-2DEV?',
            tags: ['#Etudiant', '#Ecole'],
            questions: [question]));
  });
}
