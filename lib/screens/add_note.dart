import 'package:church_express/providers/note_provider.dart';
import 'package:church_express/widgets/inherited_widget/inherited_widget.dart';
import 'package:flutter/material.dart';

enum NoteMode {
  Editing,
  Adding
}

class AddNote extends StatefulWidget {

  final NoteMode noteMode;
  final Map<String , dynamic> note;

  AddNote(this.noteMode, this.note);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  List<Map<String, String>> get _notes => NoteInheritedWidget.of(context).notes;

  @override
  void didChangeDependencies() {
    if (widget.noteMode == NoteMode.Editing) {
      _titleController.text = widget.note['title'];
      _textController.text = widget.note['text'];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.noteMode == NoteMode.Adding ? "Add note" : "Edit note"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: InputDecoration(hintText: "Note Title"),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: _textController,
                decoration: InputDecoration(hintText: "Note Title"),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _NoteButton("Save", Colors.blue, () {
                    final title = _titleController.text;
                    final text = _textController.text;
                    if(widget?.noteMode == NoteMode.Adding) {
                      NoteProvider.insertData({
                        'title': title,
                        'text': text
                      });
                    } else if(widget?.noteMode == NoteMode.Editing) {
                      NoteProvider.updateNote({
                        'id': widget.note['id'],
                        'title': _titleController.text,
                        'text': _textController.text
                      });
                    }
                    Navigator.pop(context);
                  }),
                  _NoteButton("Discard", Colors.grey, () {
                    Navigator.pop(context);
                  }),
                  widget.noteMode == NoteMode.Editing ?
                  _NoteButton("Delete", Colors.red, () async {
                    await NoteProvider.deleteNote(widget.note['id']);
                    Navigator.pop(context);
                  }) : SizedBox.shrink(),
                ],
              )
            ],
          ),
        ));
  }
}

class _NoteButton extends StatelessWidget {
  final String _text;
  final Color _color;
  final Function _onPressed;

  _NoteButton(this._text, this._color, this._onPressed);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: _onPressed,
      child: Text(
        _text,
        style: TextStyle(color: Colors.white),
      ),
      minWidth: 100,
      color: _color,
    );
  }
}
