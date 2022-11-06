import 'dart:io';
import 'package:flutter/material.dart';
import 'package:keep_notes/screens/note_view_screen.dart';
import 'package:keep_notes/utils/theme.dart';

class ListItem extends StatelessWidget {
  final int id;
  final String title;
  final String content;
  final String imagePath;
  final String date;

  ListItem(this.id, this.title, this.content, this.imagePath, this.date);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height * 0.13,
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, NoteViewScreen.route, arguments: id);
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: (ThemeServices().ThemeModes()) ? black2 : white,
            boxShadow: shadow,
            borderRadius: BorderRadius.circular(7.0),
            border: Border.all(
              color: (ThemeServices().ThemeModes()) ? grey2 : grey,
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: itemTitle.copyWith(
                            color: (ThemeServices().ThemeModes())
                                ? white
                                : black2),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        date,
                        overflow: TextOverflow.ellipsis,
                        style: itemDateStyle.copyWith(
                            color:
                                (ThemeServices().ThemeModes()) ? grey : grey2),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Expanded(
                        child: Text(
                          content,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: itemContentStyle.copyWith(
                              color: (ThemeServices().ThemeModes())
                                  ? grey
                                  : grey2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (imagePath != null)
                Row(
                  children: [
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      width: width * 0.2,
                      height: height * 0.11,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        image: DecorationImage(
                          image: FileImage(
                            File(imagePath),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final int id;
  final String title;
  final String content;
  final String date;

  GridItem(this.id, this.title, this.content, this.date);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: black2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: itemTitle.copyWith(
                color: (ThemeServices().ThemeModes()) ? white : black2),
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            date,
            overflow: TextOverflow.ellipsis,
            style: itemDateStyle.copyWith(
                color: (ThemeServices().ThemeModes()) ? grey : grey2),
          ),
          SizedBox(
            height: 8.0,
          ),
          Expanded(
            child: Text(
              content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: itemContentStyle.copyWith(
                  color: (ThemeServices().ThemeModes()) ? grey : grey2),
            ),
          ),
        ],
      ),
    );
  }
}
