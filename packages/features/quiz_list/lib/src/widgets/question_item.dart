import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class QuestionItem extends StatefulWidget {
  const QuestionItem({required this.name, this.onDelete, super.key});

  final String name;
  final VoidCallback? onDelete;

  @override
  State<QuestionItem> createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem> {
  final List<Widget> fields = [];
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
              ),
            ),
          ),
        ),
        children: [
          ...fields,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    final newTextFieldName =
                        '${widget.name}_rep_${_newTextFieldId++}';
                    final newTextFieldKey = ValueKey(_newTextFieldId);

                    fields.add(
                      ResponseField(
                        key: newTextFieldKey,
                        name: newTextFieldName,
                        onDelete: () {
                          setState(() {
                            fields.removeWhere((e) => e.key == newTextFieldKey);
                          });
                        },
                      ),
                    );
                  });
                },
                icon: Icon(
                  Icons.add,
                  // color: Colors.white,
                ),
                iconSize: 20.0,
              ),
              IconButton(
                onPressed: widget.onDelete,
                icon: Icon(Icons.delete),
                color: Colors.red,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ResponseField extends StatelessWidget {
  const ResponseField({required this.name, this.onDelete, super.key});

  final String name;
  final VoidCallback? onDelete;

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
                  name: name,
                  decoration: InputDecoration(labelText: 'Réponse'),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.close),
            color: Colors.red,
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.check),
          //   color: Colors.green,
          // ),
          IconButton(
            onPressed: onDelete,
            icon: Icon(Icons.delete),
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
