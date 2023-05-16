import 'package:bonus/api/todo/todo.dart';
import 'package:bonus/model/token.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  NotePage(
      {super.key,
      required this.title,
      required this.status,
      required this.index,
      required this.id,
      required this.note});
  String note;
  String id;
  String title;
  String status;
  String index;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late TextEditingController _note;
  late TextEditingController _title;

  @override
  void initState() {
    _note = TextEditingController();
    _title = TextEditingController();
    _note.text = widget.note;
    _title.text = widget.title;
    super.initState();
  }

  @override
  void dispose() {
    _note.dispose();
    _title.dispose();
    super.dispose();
  }

  String description = "";
  Widget _notes(BuildContext context, String token,
      {required TextEditingController controller}) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: TextField(
            maxLines: 100,
            onChanged: (value) async {
              DateTime now = DateTime.now();
              updateTodo(token, widget.index, _title.text, _note.text,
                  now.toString(), widget.status, widget.id);
            },
            cursorColor: const Color.fromARGB(255, 53, 34, 85),
            keyboardAppearance: Brightness.light,
            style: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
            controller: controller,
            decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(0, 0, 0, 0), width: 0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 0),
                ),
                hintText: "Une idée? 💡",
                hintStyle: TextStyle(color: Colors.black))));
  }

  @override
  Widget build(BuildContext context) {
    var token = Provider.of<TokenStates>(context).token;
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Container(
              width: 200,
              alignment: Alignment.center,
              child: TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) async {
                    DateTime now = DateTime.now();
                    setState(() {
                      _title.text;
                    });
                    updateTodo(token, widget.index, _title.text, _note.text,
                        now.toString(), widget.status, widget.id);
                  },
                  cursorColor: const Color.fromARGB(255, 53, 34, 85),
                  keyboardAppearance: Brightness.light,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w800),
                  controller: _title,
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(0, 0, 0, 0), width: 0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0),
                      ),
                      hintText: "Title",
                      hintStyle: TextStyle(color: Colors.black))))),
      body: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: ListView(
            children: [_notes(context, token, controller: _note)],
          )),
    );
  }
}
