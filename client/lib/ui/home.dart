import 'dart:convert';
import 'package:bonus/api/user/user.dart';
import 'package:bonus/model/token.dart';
import 'package:bonus/ui/note.dart';
import 'package:bonus/ui/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../api/todo/todo.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _prompt;
  late TextEditingController _title;
  late TextEditingController _state;

  late TextEditingController _name;
  late TextEditingController _firstname;
  late TextEditingController _email;
  late TextEditingController _password;
  @override
  void initState() {
    _prompt = TextEditingController();
    _title = TextEditingController();
    _state = TextEditingController();

    _name = TextEditingController();
    _firstname = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<TokenStates>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: Container(
            height: MediaQuery.of(context).size.height,
            width: 300,
            color: Colors.blue,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                height: 118,
              ),
              FutureBuilder<String>(
                future: getUserById(state.token, state.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erreur: ${snapshot.error}');
                  } else {
                    Map<String, dynamic> json =
                        jsonDecode(snapshot.data.toString());
                    return Text(
                      json["firstname"] ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "arial",
                          fontWeight: FontWeight.w900,
                          fontSize: 30),
                    );
                  }
                },
              ),
              Container(
                height: 20,
              ),
              Container(
                height: 1,
                color: Colors.black,
                width: MediaQuery.of(context).size.width / 1,
              ),
              Container(
                height: 20,
              ),
              FutureBuilder<String>(
                future: getUserById(state.token, state.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erreur: ${snapshot.error}');
                  } else {
                    Map<String, dynamic> json =
                        jsonDecode(snapshot.data.toString());
                    return Text(
                      json["email"] ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "arial",
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    );
                  }
                },
              ),
              Container(
                height: 10,
              ),
              FutureBuilder<String>(
                future: getUserById(state.token, state.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erreur: ${snapshot.error}');
                  } else {
                    Map<String, dynamic> json =
                        jsonDecode(snapshot.data.toString());
                    return Text(
                      json["name"] ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "arial",
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    );
                  }
                },
              ),
              Container(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                title: const Text('Edit Profile 📝'),
                                content: SizedBox(
                                  height: 200,
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: _name,
                                        decoration: const InputDecoration(
                                            hintText: 'name'),
                                      ),
                                      TextField(
                                        controller: _firstname,
                                        decoration: const InputDecoration(
                                            hintText: 'firstname'),
                                      ),
                                      TextField(
                                        controller: _email,
                                        decoration: const InputDecoration(
                                            hintText: 'email'),
                                      ),
                                      TextField(
                                        onSubmitted: (value) {
                                          updateUser(
                                            state.token,
                                            state.id,
                                            _email.text,
                                            _name.text,
                                            _firstname.text,
                                            _password.text,
                                          );
                                          setState(() {});
                                          _email.clear();
                                          _firstname.clear();
                                          _name.clear();
                                          _password.clear();
                                          setState(() {});
                                          Navigator.of(context).pop();
                                        },
                                        controller: _password,
                                        decoration: const InputDecoration(
                                            hintText: 'password'),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      _email.clear();
                                      _firstname.clear();
                                      _name.clear();
                                      _password.clear();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      updateUser(
                                        state.token,
                                        state.id,
                                        _email.text,
                                        _name.text,
                                        _email.text,
                                        _password.text,
                                      );
                                      setState(() {});
                                      _email.clear();
                                      _firstname.clear();
                                      _name.clear();
                                      _password.clear();
                                      setState(() {});
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      child: const Icon(
                        Iconsax.edit,
                        color: Colors.white,
                        size: 36,
                      )),
                  Container(
                    width: 30,
                  ),
                  GestureDetector(
                      onTap: () {
                        deleteUser(state.token, state.id);
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Iconsax.trash,
                        color: Colors.white,
                        size: 36,
                      )),
                  Container(
                    width: 30,
                  ),
                  GestureDetector(
                      onTap: () {
                        var state = Provider.of<TokenStates>(context);
                        setState(() {
                          state.token = "";
                        });
                      },
                      child: const Icon(
                        Iconsax.logout,
                        color: Colors.white,
                        size: 36,
                      ))
                ],
              )
            ])),
        appBar: AppBar(
            actions: [
              GestureDetector(
                  onTap: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            SearchPage(id: state.id),
                      ),
                    );
                  },
                  child: const Icon(
                    Iconsax.search_normal,
                    size: 30,
                  )),
              Container(
                width: 10,
              ),
            ],
            leading: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          title: const Text('Add new note ➕'),
                          content: SizedBox(
                            height: 200,
                            child: Column(
                              children: [
                                TextField(
                                  controller: _title,
                                  decoration:
                                      const InputDecoration(hintText: 'Title'),
                                ),
                                TextField(
                                  controller: _prompt,
                                  decoration: const InputDecoration(
                                      hintText: 'Description'),
                                ),
                                TextField(
                                  onSubmitted: (value) {
                                    DateTime date = DateTime.now();
                                    createTodo(
                                        state.token,
                                        _title.text,
                                        _prompt.text,
                                        date.toString(),
                                        _state.text,
                                        state.id);
                                    setState(() {});
                                    _title.clear();
                                    _state.clear();
                                    _prompt.clear();
                                    Navigator.of(context).pop();
                                  },
                                  controller: _state,
                                  decoration:
                                      const InputDecoration(hintText: 'State'),
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                _title.clear();
                                _state.clear();
                                _prompt.clear();
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                DateTime date = DateTime.now();
                                createTodo(
                                    state.token,
                                    _title.text,
                                    _prompt.text,
                                    date.toString(),
                                    _state.text,
                                    state.id);
                                setState(() {});
                                _title.clear();
                                _state.clear();
                                _prompt.clear();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                },
                child: const Icon(
                  Iconsax.add5,
                  size: 30,
                ))),
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RefreshIndicator(
                    onRefresh: () async {
                      setState(() {});
                    },
                    child: FutureBuilder<String>(
                      future: getUserTodos(state.token),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Erreur: ${snapshot.error}');
                        } else {
                          List<dynamic> data =
                              jsonDecode(snapshot.data.toString());
                          data.sort((a, b) {
                            DateTime dateTimeA = DateTime.parse(a["due_time"]);
                            DateTime dateTimeB = DateTime.parse(b["due_time"]);
                            return dateTimeB.compareTo(dateTimeA);
                          });
                          return SizedBox(
                              height: MediaQuery.of(context).size.height / 1.16,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.separated(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  String title = data[index]["title"];
                                  String status = data[index]["status"];
                                  String description =
                                      data[index]["description"];
                                  String time = data[index]["due_time"];
                                  String id = data[index]["id"].toString();
                                  DateTime dateTime = DateTime.parse(time);
                                  String formattedDateTime =
                                      DateFormat('yyyy-MM-dd HH:mm').format(
                                          dateTime
                                              .add(const Duration(hours: 2)));

                                  return Slidable(
                                      key: const ValueKey(0),
                                      startActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        dismissible:
                                            DismissiblePane(onDismissed: () {
                                          deleteTodo(state.token, id);
                                          setState(() {});
                                        }),
                                        children: [
                                          SlidableAction(
                                            onPressed: (context) async {
                                              deleteTodo(state.token, id);
                                              setState(() {});
                                            },
                                            backgroundColor:
                                                const Color(0xFFFE4A49),
                                            foregroundColor: Colors.white,
                                            icon: Iconsax.trash,
                                            label: 'Delete',
                                          ),
                                        ],
                                      ),
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.push<void>(
                                              context,
                                              MaterialPageRoute<void>(
                                                builder:
                                                    (BuildContext context) =>
                                                        NotePage(
                                                  note: description,
                                                  title: title,
                                                  status: status,
                                                  index: id,
                                                  id: state.id,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                              height: 80,
                                              color: const Color.fromARGB(
                                                  255, 34, 65, 99),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 25,
                                                  ),
                                                  Container(
                                                      width: 150,
                                                      height: 40,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        title,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: "arial",
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontSize: 30,
                                                        ),
                                                      )),
                                                  Container(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                      width: 40,
                                                      height: 40,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                          "${status == "todo" ? " ⌛️" : status == "in progress" ? " 🏗" : " ✅"}",
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: "arial",
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            fontSize: 30,
                                                          ))),
                                                  Container(
                                                    width: 15,
                                                  ),
                                                  Text(formattedDateTime,
                                                      style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontFamily: "arial",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15,
                                                      )),
                                                ],
                                              ))));
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Container(
                                    height: 2,
                                  );
                                },
                              ));
                        }
                      },
                    )),
              ],
            )));
  }
}
