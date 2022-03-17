import 'package:flutter/material.dart';

typedef TextChangValue = Function(String value);

class SearchBarItem extends StatefulWidget {
  const SearchBarItem({Key? key, required this.textChangValue})
      : super(key: key);

  final TextChangValue textChangValue;

  @override
  _SearchBarItemState createState() => _SearchBarItemState();
}

class _SearchBarItemState extends State<SearchBarItem> {
  final _textController = TextEditingController();

  void _onClearTapped() {
    _textController.text = '';
    widget.textChangValue('');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            offset: const Offset(0.0, 2.0), //(x,y)
            blurRadius: 4.0,
          ),
        ],
      ),
      child: TextFormField(
        controller: _textController,
        autocorrect: false,
        onChanged: (text) {
          widget.textChangValue(text);
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          suffixIcon: GestureDetector(
            onTap: _onClearTapped,
            child: const Icon(Icons.clear),
          ),
          border: InputBorder.none,
          hintText: 'Enter a search term',
        ),
      ),
    );
  }
}
