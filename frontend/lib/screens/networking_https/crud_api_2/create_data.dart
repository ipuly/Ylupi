import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ylupi/screens/networking_https/crud_api_2/read_data.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

final _formKey = GlobalKey<FormState>();
final _controller = TextEditingController();

class _AddDataState extends State<AddData> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerGender = TextEditingController();

  Future<http.Response> addData() async {
    Map<String, dynamic> data = {
      "name": controllerName.text,
      "email": controllerEmail.text,
      "gender": controllerGender.text,
    };

    var result =
        await http.post(Uri.parse("http://localhost:8082/api/user/insertUser"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(data));
    print(result.statusCode);
    print(result.body);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Jangan kosong dek";
                      }
                      return null;
                    },
                    controller: controllerName,
                    decoration: const InputDecoration(
                      hintText: "Masukkan Nama",
                      labelText: "Name",
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Jangan kosong dek";
                      }
                      return null;
                    },
                    controller: controllerEmail,
                    decoration: const InputDecoration(
                      hintText: "Masukkan Email",
                      labelText: "Email",
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Jangan kosong dek";
                      }
                      return null;
                    },
                    controller: controllerGender,
                    decoration: const InputDecoration(
                      hintText: "Masukkan Jenis Kelamin",
                      labelText: "Gender",
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    child: const Text("ADD USER"),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await addData();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => CrudApi(),
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
