
import 'package:flutter/cupertino.dart';

class NoteList extends StatefulWidget{
  @override
  NoteListState createState(){
    return new NoteListState();
  }
}

class NoteListState extends State<NoteList>{
  List<Map<String, String>> get _notes => NoteInheritedWidget.of(context).notes;

      @override
      Widget build(BuildContext context) {
        // TODO: implement build
        return null;
      }


    }

    class NoteInheritedWidget {
    static of(BuildContext context) {}
}