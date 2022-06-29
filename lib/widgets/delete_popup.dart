import 'package:flutter/material.dart';
import '../helper/note_provider.dart';
import '../models/note.dart';
import 'package:provider/provider.dart';

class DeletePopUp extends StatelessWidget {
  final Note selectedNote;

  DeletePopUp(this.selectedNote);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text('Supprimer ?'),
      content: Text('Souhaitez vous supprimer cette note ?'),
      actions: [
        FlatButton( //TextButton
          child: Text('Oui'),
          onPressed: () {
            Provider.of<NoteProvider>(context, listen: false)
                .deleteNote(selectedNote.id);
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ),
        FlatButton( //TextButton à voir si il faut remplacer
          child: Text('Non'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}