import 'package:flutter/material.dart';


class NoteInheritedWidget extends InheritedWidget {

  final notes = [
    {
      'title': 'asdmask',
      'text': 'asdmaskldmsklasdmaskldmsklasdmaskldmsklasdmaskldmskl'
    },
    {
      'title': 'sadkask',
      'text': 'sadkasksadkasksadkasksadkasksadkasksadkask'
    },
    {
      'title': 'asafas3',
      'text': '3asafas3253asafas3253asafa3asafas3253asafas3253asafa3asafas3253asafas3253asafa'
    }
  ];

  NoteInheritedWidget(Widget child) : super(child: child);

  static NoteInheritedWidget of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(NoteInheritedWidget)as NoteInheritedWidget);
  }

  @override
  bool updateShouldNotify( NoteInheritedWidget oldWidget) {
    return oldWidget.notes != notes;
  }
}