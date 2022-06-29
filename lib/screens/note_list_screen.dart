import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:note/helper/note_provider.dart';
import 'package:note/screens/note_edit_screen.dart';
import 'package:note/utils/constants.dart';
import 'package:note/widgets/list_item.dart';


class NoteListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<NoteProvider>(context, listen: false).getNotes(),
      builder: (context, snapshot)
      {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if(snapshot.connectionState == ConnectionState.done)
          {
            return Scaffold(
              body: Consumer<NoteProvider>(
                child: noNotesUI(context),
                builder: (context, noteprovider, child) =>
                  Container(
                    child: noteprovider.items.length <= 0
                        ? child
                        : ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: noteprovider.items.length + 1,
                            itemBuilder: (context, index){
                              if(index == 0) {
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
                          ),
                  ),
                      ),
              floatingActionButton: FloatingActionButton(
                onPressed: (){
                  goToNoteEditScreen(context);
                },
                child: Icon(Icons.add),
              ),
            );
          }
        }
        return Container();
      },
    );
  }
}

Widget header() {
  return GestureDetector(
    onTap: _launchUrl,
    child: Container(
      decoration: BoxDecoration(
        color: headerColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(75.0),
        ),
      ),
      height: 150,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Ines NEBBAD',
            style: headerRideStyle,
          ),
          Text(
            'NOTES',
            style: headerNotesStyle,
          ),
        ],
      ),
    ),
  );
}

void _launchUrl() async {
  const url = '#';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Impossible de lancer $url';
  }
}

Widget noNotesUI(BuildContext context) {
  return ListView(
    children: [
      header(),
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Image.asset(
              'emoji.jpg',
              fit: BoxFit.cover,
              width: 200,
              height: 200,
            ),
          ),
          RichText(
            text: TextSpan(
              style: noNotesStyle,
              children: [
                TextSpan(text: ' Non disponible'),
                TextSpan(
                    text: '+',
                    style: boldPlus,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        goToNoteEditScreen(context);
                      }),
                TextSpan(text: 'ajouter une nouvelle note'),
              ],
            ),
          )
        ],
      ),
    ],
  );
}

void goToNoteEditScreen(BuildContext context) {
  Navigator.of(context).pushNamed(NoteEditScreen.route);
}