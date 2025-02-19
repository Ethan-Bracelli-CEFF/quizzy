import 'package:flutter/material.dart';

class SearchsBar extends StatefulWidget {
  const SearchsBar({this.initialValue, required this.click, super.key});

  final String? initialValue;
  final Function(String value) click;

  @override
  State<SearchsBar> createState() => _SearchsBarState();
}

class _SearchsBarState extends State<SearchsBar> {
  late final TextEditingController _searchsBar;
  @override
  void initState() {
    _searchsBar = TextEditingController(text: widget.initialValue);
    _searchsBar.addListener(() {
      widget.click(_searchsBar.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: TextFormField(
        controller: _searchsBar,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 17.0),
            child: const Icon(Icons.search, color: Colors.grey),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        ),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.text,
      ),
    );
  }
}
