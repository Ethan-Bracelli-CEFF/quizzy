import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class QuestionItem extends StatefulWidget {
  const QuestionItem(
      {required this.name, required this.form, this.onDelete, super.key});

  final String name;
  final VoidCallback? onDelete;
  final GlobalKey<FormBuilderState> form;

  @override
  State<QuestionItem> createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem> {
  final List<ResponseField> fields = [];
  var _newTextFieldId = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ExpansionTile(
        // collapsedBackgroundColor: Colors.white,
        title: Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: FormBuilderTextField(
                name: widget.name,
                decoration: InputDecoration(
                  labelText: 'Question',
                ),
                validator: (value) {
                  if (value == null || value == '') {
                    return 'This field cannot be empty';
                  }

                  if (fields.length < 2) {
                    return 'Have at least 2 responses fields';
                  }

                  if (fields.length > 15) {
                    return 'You can\'t have more than 15 questions';
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
                  return 'You must have at least one correct field';
                },
              ),
            ),
          ),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    final newTextFieldName =
                        '${widget.name}_rep_${_newTextFieldId++}';
                    final newTextFieldKey = ValueKey(_newTextFieldId);

                    if (fields.length < 15) {
                      fields.add(
                        ResponseField(
                          key: newTextFieldKey,
                          name: newTextFieldName,
                          form: widget.form,
                          onDelete: () {
                            setState(() {
                              fields
                                  .removeWhere((e) => e.key == newTextFieldKey);
                            });
                          },
                        ),
                      );
                    }
                  });
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                iconSize: 20.0,
              ),
              IconButton(
                onPressed: widget.onDelete,
                icon: Icon(Icons.delete),
                color: Colors.red,
              ),
            ],
          ),
          ...fields,
        ],
      ),
    );
  }
}

class ResponseField extends StatefulWidget {
  ResponseField(
      {required this.name,
      required this.form,
      this.onDelete,
      this.correct,
      super.key})
      : isCorrect = correct ?? false;

  String name;
  final VoidCallback? onDelete;
  final bool? correct;
  bool isCorrect;
  GlobalKey<FormBuilderState> form;

  @override
  State<ResponseField> createState() => _ResponseFieldState();
}

class _ResponseFieldState extends State<ResponseField> {
  @override
  void initState() {
    super.initState();

    widget.form.currentState
        ?.setInternalFieldValue('${widget.name}_correct', false);
  }

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
                  validator: FormBuilderValidators.required(),
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
