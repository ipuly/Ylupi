// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Stream<Future<http.Response>> localStream() async* {
//   while (true) {
//     await Future.delayed(Duration(milliseconds: 500));
//     yield getData();
//   }
// }

Future<http.Response> getData() async {
  var result = await http.get(
    Uri.parse("http://localhost:8082/api/user/getAllUser"),
  );
  // print(result.body);
  if (result.statusCode == 200) {
    return result;
  } else {
    throw Exception('Failed to load post');
  }
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

class StreamLocalRefreshRafi extends StatefulWidget {
  StreamLocalRefreshRafi({super.key});

  @override
  State<StreamLocalRefreshRafi> createState() => _StreamLocalRefreshRafiState();
}

class _StreamLocalRefreshRafiState extends State<StreamLocalRefreshRafi> {
  // late Future<http.Response> data = getData();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();

  StreamController localStream = StreamController(sync: true);

  bool _isLoading = false;

  late Timer _timer;

  // Future<void> _handleRefresh() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   await Future.delayed(Duration(seconds: 2));

  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  Future<Null> _handleRefresh() async {
    getData().then((value) {
      var res = jsonDecode(value.body);
      localStream.add(res);
      return null;
    });
  }

  @override
  void initState() {
    _timer = Timer.periodic(Duration(milliseconds: 5), (_) {
      setState(() {});
    });
    getData().then((value) {
      var res = jsonDecode(value.body);
      localStream.add(res);
      return res;
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Networking Https"),
      ),
      body: Container(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder(
            stream: localStream.stream,
            builder: (context, stream) {
              if (!stream.hasData) {
                return Text("loading");
              } else {
                return ListView.builder(
                  itemCount: stream.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(stream.data[index]["name"][0]),
                        ),
                        title: Text(stream.data[index]["name"]),
                        subtitle: Text(
                            "${stream.data[index]["gender"]} , ${stream.data[index]["email"]}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                final _formKey = GlobalKey<FormState>();
                                nameController.text =
                                    stream.data[index]["name"];
                                emailController.text =
                                    stream.data[index]["email"];
                                genderController.text =
                                    stream.data[index]["gender"];
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
                                                  searchFieldProps:
                                                      TextFieldProps(
                                                    controller:
                                                        genderController,
                                                  ),
                                                ),
                                                items: ["Male", "Female"],
                                                dropdownDecoratorProps:
                                                    DropDownDecoratorProps(
                                                  dropdownSearchDecoration:
                                                      InputDecoration(
                                                    labelText: "Gender",
                                                    hintText:
                                                        "country in menu mode",
                                                  ),
                                                ),
                                                selectedItem:
                                                    "${genderController.text}",
                                              ),
                                              const SizedBox(
                                                height: 20.0,
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  await updateData(
                                                      stream.data[index]["id"],
                                                      {
                                                        "name":
                                                            nameController.text,
                                                        "email": emailController
                                                            .text,
                                                        "gender":
                                                            genderController
                                                                .text,
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
                                // updateData(decoded[index]['id']);
                                // setState(() {});
                              },
                              icon: const Icon(
                                Icons.edit,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                deleteData(stream.data[index]["id"]);
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
              }
            },
          )

          // RefreshIndicator(
          //   onRefresh: _handleRefresh,
          //   child:
          //   FutureBuilder(
          //     future: getData(),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData) {
          //         List<dynamic> decoded = jsonDecode(snapshot.data!.body);
          //         return ListView.builder(
          //           itemCount: decoded.length,
          //           shrinkWrap: true,
          //           physics: const ScrollPhysics(),
          //           itemBuilder: (context, index) {
          //             return Card(
          //               child: ListTile(
          //                 leading: CircleAvatar(
          //                   child: Text(decoded[index]["name"][0]),
          //                 ),
          //                 title: Text(decoded[index]["name"]),
          //                 subtitle: Text(
          //                     "${decoded[index]["gender"]} , ${decoded[index]["email"]}"),
          //                 trailing: Row(
          //                   mainAxisSize: MainAxisSize.min,
          //                   children: [
          //                     IconButton(
          //                       onPressed: () {
          //                         final _formKey = GlobalKey<FormState>();
          //                         nameController.text = decoded[index]["name"];
          //                         emailController.text = decoded[index]["email"];
          //                         genderController.text =
          //                             decoded[index]["gender"];
          //                         showDialog(
          //                             context: context,
          //                             builder: (builder) {
          //                               return AlertDialog(
          //                                 title: Text("Edit User"),
          //                                 content: Form(
          //                                   key: _formKey,
          //                                   child: Column(
          //                                     mainAxisSize: MainAxisSize.min,
          //                                     children: [
          //                                       TextFormField(
          //                                         controller: nameController,
          //                                         decoration: InputDecoration(
          //                                           hintText: "Name",
          //                                           labelText: "Name",
          //                                         ),
          //                                       ),
          //                                       TextFormField(
          //                                         controller: emailController,
          //                                         decoration: InputDecoration(
          //                                           hintText: "Email",
          //                                           labelText: "Email",
          //                                         ),
          //                                       ),
          //                                       DropdownSearch<String>(
          //                                         popupProps: PopupProps.dialog(
          //                                           fit: FlexFit.loose,
          //                                           showSelectedItems: true,
          //                                           searchFieldProps:
          //                                               TextFieldProps(
          //                                             controller:
          //                                                 genderController,
          //                                           ),
          //                                         ),
          //                                         items: ["Male", "Female"],
          //                                         dropdownDecoratorProps:
          //                                             DropDownDecoratorProps(
          //                                           dropdownSearchDecoration:
          //                                               InputDecoration(
          //                                             labelText: "Gender",
          //                                             hintText:
          //                                                 "country in menu mode",
          //                                           ),
          //                                         ),
          //                                         selectedItem:
          //                                             "${genderController.text}",
          //                                       ),
          //                                       const SizedBox(
          //                                         height: 20.0,
          //                                       ),
          //                                       ElevatedButton(
          //                                         onPressed: () async {
          //                                           await updateData(
          //                                               decoded[index]["id"], {
          //                                             "name": nameController.text,
          //                                             "email":
          //                                                 emailController.text,
          //                                             "gender":
          //                                                 genderController.text,
          //                                           });
          //                                           setState(
          //                                             () {
          //                                               Navigator.pop(context);
          //                                             },
          //                                           );
          //                                         },
          //                                         child: const Text("Update"),
          //                                       )
          //                                     ],
          //                                   ),
          //                                 ),
          //                               );
          //                             });
          //                         // updateData(decoded[index]['id']);
          //                         // setState(() {});
          //                       },
          //                       icon: const Icon(
          //                         Icons.edit,
          //                       ),
          //                     ),
          //                     IconButton(
          //                       onPressed: () {
          //                         deleteData(decoded[index]["id"]);
          //                         setState(() {});
          //                       },
          //                       icon: const Icon(
          //                         Icons.delete,
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             );
          //           },
          //         );
          //       } else if (snapshot.hasError) {
          //         return Text('${snapshot.error}');
          //       }
          //       return Center(
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           // ignore: prefer_const_literals_to_create_immutables
          //           children: [
          //             const CircularProgressIndicator(
          //               backgroundColor: Colors.yellow,
          //               color: Colors.black54,
          //             ),
          //             const SizedBox(
          //               height: 20.0,
          //             ),
          //             const Text("Loading...")
          //           ],
          //         ),
          //       );
          //     },
          //   ),
          // ),
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
