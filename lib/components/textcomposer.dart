import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextComposer extends StatefulWidget {
  const TextComposer({
    Key key,
    this.sendComment,
  }) : super(key: key);

  final Function(String, String) sendComment;

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  bool _isComposing = false;
  String _posicao;
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
          IconButton(
              icon: Icon(
                Icons.add_comment,
                color: Colors.blue,
              ),
              onPressed: _isComposing
                  ? () {
                      _posicao = "Concordo";
                      widget.sendComment(_controller.text, _posicao);
                      _reset();
                    }
                  : null),
          Expanded(
            child: TextField(
              controller: _controller,
              textAlign: TextAlign.center,
              decoration: InputDecoration.collapsed(
                hintText: 'Adicionar Comentário',
              ),
              onChanged: (text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
            ),
          ),
          IconButton(
              icon: Icon(
                Icons.add_comment,
                color: Colors.red,
              ),
              onPressed: _isComposing
                  ? () {
                      _posicao = "Discordo";
                      widget.sendComment(_controller.text, _posicao);
                      _reset();
                    }
                  : null),
        ],
      ),
    );
  }
}
