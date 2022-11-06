import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:keep_notes/helper/note_provider.dart';
import 'package:keep_notes/screens/note_edit_screen.dart';
import 'package:keep_notes/utils/theme.dart';
import 'package:keep_notes/widgets/list_item.dart';
import 'package:provider/provider.dart';

class NoteListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<NoteProvider>(context, listen: false).getNotes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    darkModeBtn(),
                    Consumer<NoteProvider>(
                        child: noNotesUI(context),
                        builder: (context, noteprovider, child) {
                          return (noteprovider.items.isEmpty)
                              ? noNotesUI(context)
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: noteprovider.items.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return header();
                                    } else {
                                      final i = index - 1;
                                      final item = noteprovider.items[i];

                                      return ListItem(
                                        item.id,
                                        item.title,
                                        item.content,
                                        item.imagePath,
                                        item.date,
                                      );
                                    }
                                  },
                                );
                        }),
                  ],
                ),
              ),
              floatingActionButton: Container(
                padding: EdgeInsets.only(bottom: 10, right: 10),
                decoration: BoxDecoration(
                ),
                child: FloatingActionButton(
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: () {
                    goToNoteEditScreen(context);
                  },
                  child: const Icon(
                    Icons.add,
                    color: white,
                    size: 30,
                  ),
                ),
              ),
            );
          }
        }
        return Container();
      },
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 20, bottom: 50),
      child: Text(
        'Your \nNotes',
        style: headerNotesStyle.copyWith(
            color: (ThemeServices().ThemeModes()) ? white : black2),
      ),
    );
  }

  Widget noNotesUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50, left: 20, bottom: 50),
          child: Text(
            "No \nNotes",
            style: headerNotesStyle.copyWith(
                color: (ThemeServices().ThemeModes()) ? white : black2),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 180),
            child: RichText(
              text: TextSpan(
                  style: noNotesStyle.copyWith(
                      color: (ThemeServices().ThemeModes()) ? white : black2),
                  children: [
                    const TextSpan(
                        text: " You do not have any notes.\n Tap on "),
                    TextSpan(
                        text: '+',
                        style: boldPlus,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            goToNoteEditScreen(context);
                          }),
                    const TextSpan(text: ' to add new note.')
                  ]),
            ),
          ),
        ),
      ],
    );
  }

  darkModeBtn() {
    return Padding(
      padding: EdgeInsets.only(top: 50, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              boxShadow: shadow,
                color: (ThemeServices().ThemeModes()) ? black2 : grey,
                borderRadius: BorderRadius.circular(8)),
            child: GestureDetector(
              onTap: () {
                ThemeServices().switchTheme();
              },
              child: Icon((ThemeServices().ThemeModes())
                  ? Icons.light_mode
                  : Icons.dark_mode),
            ),
          )
        ],
      ),
    );
  }

  void goToNoteEditScreen(BuildContext context) {
    Navigator.of(context).pushNamed(NoteEditScreen.route);
  }
}
