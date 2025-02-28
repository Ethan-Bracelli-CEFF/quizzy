import 'package:domain_entities/domain_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class QuestionItem extends StatefulWidget {
  const QuestionItem(
      {required this.name,
      required this.form,
      this.onDelete,
      this.text,
      this.answers,
      super.key});

  final String name;
  final VoidCallback? onDelete;
  final GlobalKey<FormBuilderState> form;
  final String? text;
  final List<Response>? answers;

  @override
  State<QuestionItem> createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem> {
  final List<ResponseField> fields = [];
  var _newTextFieldId = 0;

  void _createExistingAnswers(List<Response> answers) {
    for (int i = 0; i < answers.length; i++) {
      createAnswer(answers[i].text, answers[i].correct);
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.answers != null) {
      _createExistingAnswers(widget.answers!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ExpansionTile(
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        title: Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: FormBuilderTextField(
                initialValue: widget.text,
                name: widget.name,
                decoration: InputDecoration(
                  labelText: 'Question',
                ),
                validator: (value) {
                  if (value == null || value == '') {
                    return 'Veuillez entrer une question';
                  }

                  if (fields.length < 2) {
                    return 'Veuillez avoir au minimum 2 réponses';
                  }

                  late ResponseField? field;
                  field = fields.firstWhere(
                    (v) => v.isCorrect == true,
                    orElse: () => ResponseField(
                      name: '',
                      form: widget.form,
                      correct: false,
                      onDelete: () {},
                    ),
                  );

                  if (field.isCorrect == true) return null;
                  return 'Veuillez avoir au minimum une bonne réponse';
                },
              ),
            ),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
                  onPressed: () {
                    setState(() {
                      if (fields.length < 15) {
                        createAnswer('', false);
                      }
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.green,
                      ),
                      SizedBox(width: 5.0),
                      Text('Ajouter une réponse'),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: widget.onDelete,
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
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      SizedBox(width: 5.0),
                      Text('Supprimer la question'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ...fields,
        ],
      ),
    );
  }

  void createAnswer(String text, bool correct) {
    final newTextFieldName = '${widget.name}_rep_${_newTextFieldId++}';
    final newTextFieldKey = ValueKey(_newTextFieldId);

    fields.add(
      ResponseField(
        correct: correct,
        text: text,
        key: newTextFieldKey,
        name: newTextFieldName,
        form: widget.form,
        onDelete: () {
          setState(() {
            fields.removeWhere((e) => e.key == newTextFieldKey);
          });
          widget.form.currentState?.removeInternalFieldValue(newTextFieldName);
          widget.form.currentState
              ?.removeInternalFieldValue('${newTextFieldName}_correct');
        },
      ),
    );

    widget.form.currentState
        ?.setInternalFieldValue('${newTextFieldName}_correct', correct);
    widget.form.currentState?.setInternalFieldValue(newTextFieldName, text);
    widget.form.currentState?.save();
  }
}

class ResponseField extends StatefulWidget {
  ResponseField(
      {required this.name,
      required this.form,
      this.onDelete,
      this.correct,
      this.text,
      super.key})
      : isCorrect = correct ?? false;

  String name;
  final VoidCallback? onDelete;
  final bool? correct;
  bool isCorrect;
  GlobalKey<FormBuilderState> form;
  final String? text;

  @override
  State<ResponseField> createState() => _ResponseFieldState();
}

class _ResponseFieldState extends State<ResponseField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: FormBuilderTextField(
                  name: widget.name,
                  decoration: InputDecoration(labelText: 'Réponse'),
                  initialValue: widget.text,
                  validator: (value) {
                    if (value != null && value.trim() == "") {
                      return "Veuillez entrer une réponse";
                    }

                    return null;
                  },
                ),
              ),
            ),
          ),
          widget.isCorrect
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      widget.form.currentState?.setInternalFieldValue(
                          '${widget.name}_correct', false);
                      widget.form.currentState?.save();
                      widget.isCorrect = false;
                    });
                  },
                  icon: Icon(Icons.check),
                  color: Colors.green,
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      widget.form.currentState?.setInternalFieldValue(
                          '${widget.name}_correct', true);
                      widget.form.currentState?.save();
                      widget.isCorrect = true;
                    });
                  },
                  icon: Icon(Icons.close),
                  color: Colors.red,
                ),
          IconButton(
            onPressed: widget.onDelete,
            icon: Icon(Icons.delete),
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
