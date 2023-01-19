// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'read_data.dart';

class EditData extends StatefulWidget {
  final List list;
  final int index;

  EditData({required this.list, required this.index});

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  late TextEditingController controllerName;
  late TextEditingController controllerEmail;
  late TextEditingController controllerGender;

  Future<http.Response> editData(id) async {
    Map<String, dynamic> data = {
      "id": widget.list[widget.index]['id'],
      "name": controllerName.text,
      "email": controllerEmail.text,
      "gender": controllerGender.text,
    };

    var result = await http.put(
        Uri.parse("http://localhost:8082/api/user/updateUser/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data));
    print(result.statusCode);
    print(result.body);
    return result;
  }

  @override
  void initState() {
    controllerName =
        TextEditingController(text: widget.list[widget.index]['name']);
    controllerEmail =
        TextEditingController(text: widget.list[widget.index]['email']);
    controllerGender =
        TextEditingController(text: widget.list[widget.index]['gender']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit User"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                TextField(
                  controller: controllerName,
                  decoration:
                      InputDecoration(hintText: "Name", labelText: "Name"),
                ),
                TextField(
                  controller: controllerEmail,
                  decoration:
                      InputDecoration(hintText: "Email", labelText: "Email"),
                ),
                TextField(
                  controller: controllerGender,
                  decoration:
                      InputDecoration(hintText: "Gender", labelText: "Gender"),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  child: Text("EDIT DATA"),
                  onPressed: () async {
                    await editData(widget.list[widget.index]['id']);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => CrudApi(),
                      ),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
