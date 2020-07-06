import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextComposer extends StatefulWidget {
  const TextComposer({
    Key key,
    this.sendComment,
  }) : super(key: key);

  final Function(String) sendComment;

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  bool _isComposing = false;
  final TextEditingController _controller = TextEditingController();

  void _reset() {
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration.collapsed(
                hintText: 'Adicionar Comentário',
              ),
              onChanged: (text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: (text) {
                widget.sendComment(text);
                _reset();
              },
            ),
          ),
          IconButton(
              icon: Icon(Icons.add_comment),
              onPressed: _isComposing
                  ? () {
                      widget.sendComment(_controller.text);
                      _reset();
                    }
                  : null),
        ],
      ),
    );
  }
}
