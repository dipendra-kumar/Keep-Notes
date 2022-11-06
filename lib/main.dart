import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:keep_notes/screens/note_view_screen.dart';
import 'package:keep_notes/utils/theme.dart';
import 'package:provider/provider.dart';
import 'helper/note_provider.dart';
import 'screens/note_edit_screen.dart';
import 'screens/note_list_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: NoteProvider(),
      child: GetMaterialApp(
        title: "Keep Notes",
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => NoteListScreen(),
          NoteViewScreen.route: (context) => NoteViewScreen(),
          NoteEditScreen.route: (context) => NoteEditScreen(),
        },
        themeMode: ThemeServices().theme,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
      ),
    );
  }
}
