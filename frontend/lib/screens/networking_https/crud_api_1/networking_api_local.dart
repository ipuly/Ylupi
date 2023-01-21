// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<http.Response> getData() async {
  var result = await http.get(
    Uri.parse("http://localhost:8082/api/user/getAllUser"),
  );
  // print(result.body);
  return result;
}

Future<http.Response> postData(Map<String, dynamic> data) async {
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

Future<http.Response> updateData(int id, Map<String, dynamic> data) async {
  var result =
      await http.put(Uri.parse("http://localhost:8082/api/user/updateUser/$id"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data));
  print(result.statusCode);
  print(result.body);
  return result;
}

Future<http.Response> deleteData(id) async {
  var result = await http.delete(
    Uri.parse("http://localhost:8082/api/user/deleteUser/${id}"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  print(result.statusCode);
  print(result.body);
  return result;
}

class NetworkingApiLocal extends StatefulWidget {
  NetworkingApiLocal({super.key});

  @override
  State<NetworkingApiLocal> createState() => _NetworkingApiLocalState();
}

class _NetworkingApiLocalState extends State<NetworkingApiLocal> {
  late Future<http.Response> data = getData();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Networking Https"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<dynamic> decoded = jsonDecode(snapshot.data!.body);
              return ListView.builder(
                itemCount: decoded.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(decoded[index]["name"][0]),
                      ),
                      title: Text(decoded[index]["name"]),
                      subtitle: Text(
                          "${decoded[index]["gender"]} , ${decoded[index]["email"]}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              final _formKey = GlobalKey<FormState>();
                              nameController.text = decoded[index]["name"];
                              emailController.text = decoded[index]["email"];
                              genderController.text = decoded[index]["gender"];
                              String gender = "";
                              showDialog(
                                  context: context,
                                  builder: (builder) {
                                    return AlertDialog(
                                      title: Text("Edit User"),
                                      content: Form(
                                        key: _formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextFormField(
                                              controller: nameController,
                                              decoration: InputDecoration(
                                                hintText: "Name",
                                                labelText: "Name",
                                              ),
                                            ),
                                            TextFormField(
                                              controller: emailController,
                                              decoration: InputDecoration(
                                                hintText: "Email",
                                                labelText: "Email",
                                              ),
                                            ),
                                            DropdownSearch<String>(
                                              popupProps: PopupProps.dialog(
                                                fit: FlexFit.loose,
                                                showSelectedItems: true,
                                              ),
                                              items: ["Male", "Female"],
                                              onChanged: (value) {
                                                gender = value!;
                                              },
                                              dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  labelText: "Gender",
                                                ),
                                              ),
                                              selectedItem:
                                                  genderController.text,
                                            ),
                                            // Column(
                                            //   crossAxisAlignment:
                                            //       CrossAxisAlignment.start,
                                            //   children: [
                                            //     RadioListTile(
                                            //       title: Text("Laki - Laki"),
                                            //       value: "Pria",
                                            //       groupValue:
                                            //           dataUser["datauser"].sex,
                                            //       onChanged: (value) {
                                            //         setState(() {
                                            //           gValue = value.toString();
                                            //           print(gValue);
                                            //         });
                                            //       },
                                            //     ),
                                            //     RadioListTile(
                                            //       title: Text("Perempuan"),
                                            //       value: "Wanita",
                                            //       groupValue:
                                            //           dataUser["datauser"].sex,
                                            //       onChanged: (value) {
                                            //         setState(() {
                                            //           gValue = value.toString();
                                            //           print(dataUser["datauser"]
                                            //               .id
                                            //               .toString());
                                            //         });
                                            //       },
                                            //     ),
                                            //   ],
                                            // ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                print(gender);
                                                await updateData(
                                                    decoded[index]["id"], {
                                                  "name": nameController.text,
                                                  "email": emailController.text,
                                                  "gender": gender,
                                                });
                                                setState(
                                                  () {
                                                    Navigator.pop(context);
                                                  },
                                                );
                                              },
                                              child: const Text("Update"),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            icon: const Icon(
                              Icons.edit,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              deleteData(decoded[index]["id"]);
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.delete,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const CircularProgressIndicator(
                    backgroundColor: Colors.yellow,
                    color: Colors.black54,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text("Loading...")
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final _formKey = GlobalKey<FormState>();
          showDialog(
            context: context,
            builder: (builder) {
              String name = "";
              String email = "";
              String gender = "";

              return AlertDialog(
                title: Text("Add User"),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          name = value;
                        },
                        decoration: InputDecoration(
                          hintText: "Name",
                          labelText: "Name",
                        ),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                          labelText: "Email",
                        ),
                      ),
                      DropdownSearch<String>(
                        popupProps: PopupProps.dialog(
                          fit: FlexFit.loose,
                          showSelectedItems: true,
                        ),
                        items: ["Male", "Female"],
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Gender",
                            hintText: "country in menu mode",
                          ),
                        ),
                        onChanged: (value) {
                          gender = value!;
                        },
                        selectedItem: "Select your gender",
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await postData(
                            {
                              "name": name,
                              "email": email,
                              "gender": gender,
                            },
                          );
                          setState(
                            () {
                              Navigator.pop(context);
                            },
                          );
                        },
                        child: const Text("Kirim"),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
