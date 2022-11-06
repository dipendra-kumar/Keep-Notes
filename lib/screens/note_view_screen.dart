import 'dart:io';
import 'package:flutter/material.dart';
import 'package:keep_notes/helper/note_provider.dart';
import 'package:keep_notes/models/note.dart';
import 'package:keep_notes/widgets/delete_popup.dart';
import 'package:provider/provider.dart';
import '../utils/theme.dart';
import 'note_edit_screen.dart';

class NoteViewScreen extends StatefulWidget {
  static const route = '/note-view';

  @override
  _NoteViewScreenState createState() => _NoteViewScreenState();
}

class _NoteViewScreenState extends State<NoteViewScreen> {
  Note selectedNote;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    final id = ModalRoute
        .of(context)
        .settings
        .arguments as int;

    final provider = Provider.of<NoteProvider>(context);

    if (provider.getNote(id) != null) {
      selectedNote = provider.getNote(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        backButton(),
                        deleteButton()
                      ],
                    )
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    selectedNote.title,
                    style: viewTitleStyle,
                  ),
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.access_time,
                        size: 18,
                      ),
                    ),
                    Text(selectedNote.date)
                  ],
                ),
                if (selectedNote.imagePath != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Image.file(
                      File(selectedNote.imagePath),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    selectedNote.content,
                    style: viewContentStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
          padding: EdgeInsets.only(right:10, bottom: 10),
          child: FloatingActionButton(
            backgroundColor: kPrimaryColor,
              shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    onPressed: () {
    Navigator.pushNamed(context, NoteEditScreen.route,
    arguments: selectedNote.id);
    },
    child: const Icon(Icons.edit,color: white,size: 30,),
    ),
        )
    ,
    );
  }

  Widget backButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: (ThemeServices().ThemeModes())? black2:grey),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_outlined,
          color: (ThemeServices().ThemeModes())? white: black2,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget deleteButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: redColor),
      child: IconButton(
        icon: const Icon(
          Icons.delete_forever_outlined,
          color: white,
        ),
        onPressed: () => _showDialog(),
      ),
    );
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return DeletePopUp(selectedNote);
        });
  }
}
