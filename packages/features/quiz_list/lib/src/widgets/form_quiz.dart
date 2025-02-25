import 'package:domain_entities/domain_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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

  @override
  void initState() {
    super.initState();

    _editedQuiz = widget.quiz ??
        Quiz(
          creator: '',
          title: '',
          description: '',
          category: 'Autres',
          id: '',
          tags: [],
          questions: [],
        );
  }

  Quiz _getQuizFromValues() {
    Quiz quiz = Quiz(
        creator: 'Me',
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

      final List<Question> questions = [];

      for (int i = 0; i < fields.length + 5; i++) {
        final List<Response> responses = [];

        if (values.keys.contains('question_$i') &&
            values['question_$i'] != null) {
          for (int j = 0; j < 25; j++) {
            final repString = 'question_$i\_rep_$j';
            if (values.keys.contains(repString) && values[repString] != null) {
              responses.add(
                Response(
                    text: values[repString],
                    correct: values['$repString\_correct']),
              );
            }
          }

          questions.add(
            Question(title: values['question_$i'], answers: responses),
          );
        }
      }

      quiz = quiz.copyWith(
          title: title, description: description, questions: questions);
    }
    return quiz;
  }

  void _saveForm(Quiz quiz) {
    // TODO Add the quiz to the provider
    Navigator.of(context).pop();
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
                validator: FormBuilderValidators.required(),
                decoration: InputDecoration(labelText: 'Titre'),
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
                validator: FormBuilderValidators.required(),
                decoration: InputDecoration(labelText: 'Description'),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: FormBuilderTextField(
                name: 'Tags',
                decoration: InputDecoration(labelText: 'Tags'),
                onSubmitted: (value) {
                  if (value != null && value.trim() != '') {
                    if (tags.indexWhere((t) => t.text == value) != -1) {
                      return;
                    }
                    createTag(value);
                  }
                },
              ),
            ),
          ),
          Wrap(
            spacing: 5.0,
            runSpacing: 5.0,
            children: [...tags],
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
            onDelete: () {
              setState(() {
                fields.removeWhere((e) => e.key == newTextFieldKey);
              });
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
