import 'package:domain_entities/domain_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:quiz_list/quiz_list.dart';

class FormQuiz extends StatefulWidget {
  const FormQuiz({this.quiz, super.key});

  final Quiz? quiz;

  @override
  State<FormQuiz> createState() => _FormQuizState();
}

class _FormQuizState extends State<FormQuiz> {
  final _form = GlobalKey<FormBuilderState>();

  final List<QuestionItem> fields = [];
  final List<Tag> tags = [];
  var _newTextFieldId = 0;
  var _newTagFieldId = 0;
  String savedValue = '';

  late Quiz _editedQuiz;

  late TextEditingController tagController;

  @override
  void dispose() {
    super.dispose();

    tagController.dispose();
  }

  @override
  void initState() {
    super.initState();

    _editedQuiz = widget.quiz ??
        Quiz(
          creator: context.read<UserListProvider>().userState.user.username,
          title: '',
          description: '',
          category: 'Autres',
          id: '',
          tags: [],
          questions: [],
        );

    _createExistingTags();
    _createExistingQuestions();

    tagController = TextEditingController();
  }

  Quiz _getQuizFromValues() {
    Quiz quiz = Quiz(
        creator: context.read<UserListProvider>().userState.user.username,
        title: '',
        description: '',
        category: 'Autres',
        id: '',
        tags: [],
        questions: []);

    _form.currentState?.save();
    Map? values = _form.currentState?.value;
    if (values != null) {
      final title = values['Title'];
      final description = values['Description'];
      final categorie = values['Categorie'];

      final List<String> tags = [];
      for (var t in this.tags) {
        tags.add(t.text);
      }

      final List<Question> questions = [];

      for (int i = 0; i < fields.length + 5; i++) {
        final List<Response> responses = [];

        if (values.keys.contains('question_$i') &&
            values['question_$i'] != null) {
          for (int j = 0; j < 25; j++) {
            final repString = 'question_${i}_rep_$j';
            if (values.keys.contains(repString) && values[repString] != null) {
              responses.add(
                Response(
                    text: values[repString],
                    correct: values['${repString}_correct']),
              );
            }
          }

          questions.add(
            Question(title: values['question_$i'], answers: responses),
          );
        }
      }

      quiz = quiz.copyWith(
        title: title,
        description: description,
        questions: questions,
        tags: tags,
        category: categorie,
        id: _editedQuiz.id,
      );
    }
    return quiz;
  }

  void _saveForm(Quiz quiz) {
    if (quiz.id != '') {
      context.read<QuizListProvider>().updateQuiz(quiz);
      Navigator.of(context).pop();

      return;
    }
    context.read<QuizListProvider>().addQuiz(quiz);
    Navigator.of(context).pop();
  }

  void _createExistingTags() {
    for (int i = 0; i < _editedQuiz.tags.length; i++) {
      createTag(_editedQuiz.tags[i]);
    }
  }

  void _createExistingQuestions() {
    for (int i = 0; i < _editedQuiz.questions.length; i++) {
      createQuestion(question: _editedQuiz.questions[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _form,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: FormBuilderTextField(
                name: 'Title',
                validator: (value) {
                  if (value != null && value.trim() == "") {
                    return "Veuillez entrer un titre";
                  }

                  if (fields.isEmpty) {
                    return "Veuillez avoir au moins une question";
                  }

                  return null;
                },
                decoration: InputDecoration(labelText: 'Titre'),
                initialValue: _editedQuiz.title,
                onSaved: (value) {
                  _editedQuiz.copyWith(title: value);
                },
              ),
            ),
          ),
          SizedBox(height: 15.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: FormBuilderTextField(
                name: 'Description',
                validator: (value) {
                  if (value != null && value.trim() == "") {
                    return "Veuillez entrer une description";
                  }

                  return null;
                },
                decoration: InputDecoration(labelText: 'Description'),
                initialValue: _editedQuiz.description,
                onSaved: (value) {
                  _editedQuiz.copyWith(description: value);
                },
              ),
            ),
          ),
          SizedBox(height: 15.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: FormBuilderTextField(
                      controller: tagController,
                      name: 'Tag',
                      decoration: InputDecoration(labelText: 'Tag'),
                      onSubmitted: (value) {
                        if (value != null && value.trim() != '') {
                          if (tags.indexWhere((t) => t.text == value) != -1) {
                            return;
                          }
                          createTag(value);
                        }

                        tagController.text = "";
                      },
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (tagController.text.trim() != '') {
                      if (tags.indexWhere(
                              (t) => t.text == tagController.text) !=
                          -1) {
                        return;
                      }
                      createTag(tagController.text);
                    }
                    tagController.text = "";
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                    foregroundColor: WidgetStatePropertyAll(Colors.green),
                    shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  icon: Icon(Icons.add),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Wrap(
              spacing: 5.0,
              runSpacing: 5.0,
              children: [...tags],
            ),
          ),
          FormBuilderRadioGroup<String>(
            decoration: const InputDecoration(
              label: Text(
                'Categorie',
                style: TextStyle(color: Colors.white),
              ),
            ),
            initialValue: _editedQuiz.category,
            name: 'Categorie',
            options: [
              'Culture G',
              'Géographie',
              'Histoire',
              'Sport',
              'Informatique',
              'Films et Séries',
              'Autres'
            ]
                .map(
                  (lang) => FormBuilderFieldOption(
                    value: lang,
                    child: Text(
                      lang,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
                .toList(growable: false),
          ),
          Divider(thickness: 3.0),
          SizedBox(height: 15.0),
          ...fields,
          TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              foregroundColor: WidgetStatePropertyAll(Colors.black),
              shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.green,
                ),
                SizedBox(width: 5.0),
                Text('Ajouter une question'),
              ],
            ),
            onPressed: () {
              createQuestion();
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Divider(thickness: 3.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
                  foregroundColor: WidgetStatePropertyAll(Colors.red),
                  shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: Text(
                  'Annuler',
                  style: TextStyle(fontSize: 16.0),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(width: 20.0),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
                  foregroundColor: WidgetStatePropertyAll(Colors.black),
                  shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: Text(
                  'Sauvegarder',
                  style: TextStyle(fontSize: 16.0),
                ),
                onPressed: () {
                  _form.currentState?.validate();
                  if (_form.currentState != null &&
                      !_form.currentState!.isValid) {
                    return;
                  }

                  Quiz quiz = _getQuizFromValues();
                  _saveForm(quiz);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void createQuestion({Question? question}) {
    final Question editedQuestion =
        question ?? Question(answers: [], title: '');

    final newTextFieldName = 'question_${_newTextFieldId++}';
    final newTextFieldKey = ValueKey(_newTextFieldId);
    setState(
      () {
        fields.add(
          QuestionItem(
            key: newTextFieldKey,
            name: newTextFieldName,
            form: _form,
            text: editedQuestion.title,
            answers: editedQuestion.answers,
            onDelete: () {
              setState(() {
                fields.removeWhere((e) => e.key == newTextFieldKey);
              });
              _form.currentState?.removeInternalFieldValue(newTextFieldName);
            },
          ),
        );
      },
    );
  }

  void createTag(String text) {
    final newTextFieldName = 'tag_${_newTagFieldId++}';
    final newTextFieldKey = ValueKey('tag_$_newTagFieldId');

    setState(() {
      tags.add(
        Tag(
          key: newTextFieldKey,
          name: newTextFieldName,
          text: text,
          onDelete: () {
            setState(() {
              tags.removeWhere((e) => e.key == newTextFieldKey);
            });
          },
        ),
      );
    });
  }
}

class Tag extends StatelessWidget {
  const Tag({required this.name, required this.text, this.onDelete, super.key});

  final String name;
  final String text;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onDelete,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.white),
        foregroundColor: WidgetStatePropertyAll(Colors.black),
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          SizedBox(width: 2.0),
          Icon(Icons.close, color: Colors.red, size: 15.0),
        ],
      ),
    );
  }
}
