import 'dart:io';
import 'package:flutter/material.dart';
import 'package:keep_notes/helper/note_provider.dart';
import 'package:keep_notes/models/note.dart';
import 'package:keep_notes/widgets/delete_popup.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../utils/theme.dart';
import 'note_view_screen.dart';

class NoteEditScreen extends StatefulWidget {
  static const route = '/edit-note';

  @override
  _NoteEditScreenState createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  File _image;

  final picker = ImagePicker();

  bool firstTime = true;
  Note selectedNote;
  int id;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if (firstTime) {
      id = ModalRoute.of(this.context).settings.arguments as int;

      if (id != null) {
        selectedNote = Provider.of<NoteProvider>(
          this.context,
          listen: false,
        ).getNote(id);

        titleController.text = selectedNote.title;
        contentController.text = selectedNote.content;

        if (selectedNote.imagePath != null) {
          _image = File(selectedNote.imagePath);
        }
      }
    }
    firstTime = false;
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    backButton(),
                    Row(
                      children: [
                        addImages(),
                        deleteButton()
                      ],
                    ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 5.0, top: 10.0, bottom: 5.0),
                child: TextField(
                  controller: titleController,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  style: createTitle,
                  decoration: const InputDecoration(
                      hintText: 'Enter Note Title', border: InputBorder.none),
                ),
              ),
              if (_image != null)
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width,
                  height: 250.0,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                            image: FileImage(_image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding:const EdgeInsets.all(12.0),
                          child: Container(
                            height: 30.0,
                            width: 30.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: redColor,
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _image = null;
                                });
                              },
                              child: const Icon(
                                Icons.close,
                                size: 16.0,
                                color: white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 5.0, top: 10.0, bottom: 5.0),
                child: TextField(
                  controller: contentController,
                  maxLines: null,
                  style: createContent,
                  decoration: const InputDecoration(
                    hintText: 'Enter Something...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.only(bottom: 10, right: 10),
        decoration: BoxDecoration(
        ),
        child: FloatingActionButton(backgroundColor: kPrimaryColor,
          shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onPressed: () {
            if (titleController.text.isEmpty) {
              titleController.text = 'Untitled Note';
            }

            saveNote();
          },
          child: const Icon(Icons.save,color: white, size: 30,),
        ),
      ),
    );
  }

  getImage(ImageSource imageSource) async {
    PickedFile imageFile = await picker.getImage(source: imageSource);

    if (imageFile == null) return;

    File tmpFile = File(imageFile.path);

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(imageFile.path);

    tmpFile = await tmpFile.copy('${appDir.path}/$fileName');

    setState(() {
      _image = tmpFile;
    });
  }

  void saveNote() {
    String title = titleController.text.trim();
    String content = contentController.text.trim();

    String imagePath = (_image != null) ? _image?.path : null;

    if (id != null) {
      Provider.of<NoteProvider>(
        this.context,
        listen: false,
      ).addOrUpdateNote(id, title, content, imagePath, EditMode.UPDATE);
      Navigator.of(this.context).pop();
    } else {
      int id = DateTime.now().millisecondsSinceEpoch;

      Provider.of<NoteProvider>(this.context, listen: false)
          .addOrUpdateNote(id, title, content, imagePath, EditMode.ADD);

      Navigator.of(this.context)
          .pushReplacementNamed(NoteViewScreen.route, arguments: id);
    }
  }
  Widget backButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: (ThemeServices().ThemeModes())? black2:grey,),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_outlined,
          color: (ThemeServices().ThemeModes())? white:black2,
        ),
        onPressed: () => Navigator.pop(this.context),
      ),
    );
  }

  Widget addImages(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: (ThemeServices().ThemeModes())? black2:grey,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        children: [
          IconButton(
            splashColor: Colors.transparent,
            icon: const Icon(Icons.photo_camera),
            color: (ThemeServices().ThemeModes())? white:black2,
            onPressed: () {
              getImage(ImageSource.camera);
            },
          ),
          VerticalDivider(color: black2,thickness: 2,),

          IconButton(
            icon: const Icon(Icons.insert_photo),
            color: (ThemeServices().ThemeModes())? white:black2,
            onPressed: () {
              getImage(ImageSource.gallery);
            },
          ),
        ],
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
        onPressed: () {
          if (id != null) {
            _showDialog();
          } else {
          }
        }
      ),
    );
  }

  void _showDialog() {
    showDialog(
        context: this.context,
        builder: (context) {
          return DeletePopUp(selectedNote);
        });
  }
}
