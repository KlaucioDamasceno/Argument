import 'package:flutter/material.dart';

class RespostaComposer extends StatefulWidget {
  final Function(String, String) sendRespost;

  const RespostaComposer({Key key, this.sendRespost}) : super(key: key);
  @override
  _RespostaComposerState createState() => _RespostaComposerState();
}

class _RespostaComposerState extends State<RespostaComposer> {
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
                      widget.sendRespost(_controller.text, _posicao);
                      _reset();
                    }
                  : null),
          Expanded(
            child: TextField(
              controller: _controller,
              textAlign: TextAlign.center,
              decoration: InputDecoration.collapsed(
                hintText: 'Adicionar Resposta',
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
                      widget.sendRespost(_controller.text, _posicao);
                      _reset();
                    }
                  : null),
        ],
      ),
    );
  }
}
