// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseStream extends StatefulWidget {
  FirebaseStream({super.key});

  @override
  State<FirebaseStream> createState() => _FirebaseStreamState();
}

class _FirebaseStreamState extends State<FirebaseStream> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Stream"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: users.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Loading...');
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var ds = snapshot.data!;
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(ds.docs[index]["name"][0]),
                    ),
                    title: Text(ds.docs[index]["name"]),
                    subtitle: Text(
                      ds.docs[index]["gender"] +
                          " , " +
                          ds.docs[index]["email"],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            final _formKey = GlobalKey<FormState>();
                            nameController.text = ds.docs[index]["name"];
                            emailController.text = ds.docs[index]["email"];
                            genderController.text = ds.docs[index]["gender"];
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
                                            selectedItem: genderController.text,
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          ElevatedButton(
                                            onPressed: () async {
                                              print(ds.docs[index].id);
                                              await users
                                                  .doc(ds.docs[index].id)
                                                  .update({
                                                'name': nameController.text,
                                                'email': emailController.text,
                                                'gender': gender,
                                              });
                                              Navigator.pop(context);
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
                          onPressed: () async {
                            // print(ds.docs[index].id);
                            await users.doc(ds.docs[index].id).delete();
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
                        popupProps: PopupProps.menu(
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
                          await users.add(
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
