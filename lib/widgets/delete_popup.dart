import 'package:flutter/material.dart';
import 'package:keep_notes/helper/note_provider.dart';
import 'package:keep_notes/models/note.dart';
import 'package:provider/provider.dart';

import '../utils/theme.dart';

class DeletePopUp extends StatelessWidget {
  final Note selectedNote;

  DeletePopUp(this.selectedNote);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:  (ThemeServices().ThemeModes())? black:white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: Text('Delete Note?'),
      content: Text('Are you sure to delete this note?'),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              child: Text('No', style: btnTxtStyle.copyWith(color: (ThemeServices().ThemeModes())? white:black2)),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all((ThemeServices().ThemeModes())? black2:grey)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(width: 20,),
            TextButton(
              child: Text(
                'Delete',
                style: btnTxtStyle.copyWith(color: white),
              ),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(redColor)),
              onPressed: () {
                Provider.of<NoteProvider>(context, listen: false)
                    .deleteNote(selectedNote.id);
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
          ],
        ),
      ],
    );
  }
}
