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

  final List<Widget> fields = [];
  var _newTextFieldId = 0;
  String savedValue = '';

  @override
  void initState() {
    savedValue = _form.currentState?.value.toString() ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _form,
      clearValueOnUnregister: true,
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
              ),
            ),
          ),
          SizedBox(height: 15.0),
          // TODO Tags field
          Divider(thickness: 3.0),
          SizedBox(height: 15.0),
          ...fields,
          // TODO Button decoration
          TextButton(
            child: Text('Ajouter une question'),
            onPressed: () {
              final newTextFieldName = 'question_${_newTextFieldId++}';
              final newTextFieldKey = ValueKey(_newTextFieldId);
              setState(() {
                fields.add(QuestionItem(
                  key: newTextFieldKey,
                  name: newTextFieldName,
                  onDelete: () {
                    setState(() {
                      fields.removeWhere((e) => e.key == newTextFieldKey);
                    });
                  },
                ));
              });
            },
          )
        ],
        // TODO Button cancel and send
      ),
    );
  }
}
