import 'package:church_express/providers/note_provider.dart';
import 'package:church_express/screens/notes.dart';
import 'package:church_express/utils/colors.dart';
import 'package:church_express/utils/text_styles.dart';
import 'package:church_express/widgets/inherited_widget/inherited_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum NoteMode { Editing, Adding }

class AddNote extends StatefulWidget {
  final NoteMode noteMode;
  final Map<String, dynamic> note;

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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: IconThemeData(color: floatButtonColor),
          backgroundColor: appBarColor,
          title: Text(
              widget.noteMode == NoteMode.Adding ? "Add note" : "Edit note",
              style: appBarTextStyle),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Title:",
                        style: noteTitleStyle,
                      ),
                      SizedBox(height: 10.0,),
                      TextField(
                        controller: _titleController,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration.collapsed(hintText: "Title",

                        ),
                        style: noteTextStyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Note:",
                        style: noteTitleStyle,
                      ),
                      SizedBox(height: 10.0,),
                      TextField(
                        cursorColor: Colors.grey,
                        controller: _textController,
                        decoration: InputDecoration.collapsed(hintText: "Note",),
                        style: noteTextStyle,
                        keyboardType: TextInputType.multiline,
                        maxLines: 22,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        NoteButton("Save", floatButtonColor, () {
                          final title = _titleController.text;
                          final text = _textController.text;
                          if (widget?.noteMode == NoteMode.Adding) {
                            NoteProvider.insertData(
                                {'title': title, 'text': text});
                          } else if (widget?.noteMode == NoteMode.Editing) {
                            NoteProvider.updateNote({
                              'id': widget.note['id'],
                              'title': _titleController.text,
                              'text': _textController.text
                            });
                          }
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (BuildContext context, _, __) => Notes(),
                                  transitionsBuilder:
                                      (_, Animation<double> animation, __, Widget child) {
                                    return new FadeTransition(
                                        opacity: animation, child: child);
                                  }));
                        }),
                        NoteButton("Discard", Color(0xFF545454), () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (BuildContext context, _, __) => Notes(),
                                  transitionsBuilder:
                                      (_, Animation<double> animation, __, Widget child) {
                                    return new FadeTransition(
                                        opacity: animation, child: child);
                                  }));
                        }),
                        widget.noteMode == NoteMode.Editing
                            ? NoteButton("Delete", Colors.red, () async {
                                await NoteProvider.deleteNote(
                                    widget.note['id']);
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (BuildContext context, _, __) => Notes(),
                                        transitionsBuilder:
                                            (_, Animation<double> animation, __, Widget child) {
                                          return new FadeTransition(
                                              opacity: animation, child: child);
                                        }));
                              })
                            : SizedBox.shrink(),
                      ],
                    ))
              ],
            )));
  }
}

class NoteButton extends StatelessWidget {
  final String _text;
  final Color _color;
  final Function _onPressed;

  NoteButton(this._text, this._color, this._onPressed);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: _onPressed,
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
      child: Text(
        _text,
        style: noteButtonStyle,
      ),
      minWidth: 100,
      color: _color,
    );
  }
}


