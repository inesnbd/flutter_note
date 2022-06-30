import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:note/helper/note_provider.dart';
import 'package:note/screens/note_edit_screen.dart';
import 'package:note/screens/note_list_screen.dart';
import 'package:note/screens/note_view_screen.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: NoteProvider(),
      child: MaterialApp(
        title: "Notes flutter",
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => NoteListScreen(),
          NoteViewScreen.route: (context) => NoteViewScreen(),
          NoteEditScreen.route: (context) => NoteEditScreen(),
        },
      ),
    );
  }
}
