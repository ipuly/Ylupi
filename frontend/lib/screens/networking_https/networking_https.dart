import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<http.Response> getData() async {
  var result = await http.get(
    Uri.parse("https://jsonplaceholder.typicode.com/users"),
  );
  // print(result.body);
  return result;
}

Future<http.Response> postData() async {
  Map<String, dynamic> data = {
    "name": "Jhon",
    "email": "asasas@gamil.com",
  };

  var result =
      await http.post(Uri.parse("https://jsonplaceholder.typicode.com/users"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data));
  print(result.statusCode);
  print(result.body);
  return result;
}

Future<http.Response> updateData(id) async {
  Map<String, dynamic> data = {
    "name": "Jhon",
    "email": "asasas@gamil.com",
  };

  var result = await http.put(
      Uri.parse("https://jsonplaceholder.typicode.com/users/$id"),
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
    Uri.parse("https://jsonplaceholder.typicode.com/users/${id}"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  print(result.statusCode);
  print(result.body);
  return result;
}

class NetworkingHttps extends StatelessWidget {
  NetworkingHttps({super.key});

  var data = getData();

  @override
  Widget build(BuildContext context) {
    // print(postData());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Networking Https"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                postData();
              },
              icon: const Icon(
                Icons.add,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          // future: getData().then((value) => value.body),
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
                      subtitle: Text("${decoded[index]["email"]}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              updateData(decoded[index]['id']);
                            },
                            icon: const Icon(
                              Icons.edit,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              deleteData(decoded[index]["id"]);
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
                children: [
                  const CircularProgressIndicator(
                    backgroundColor: Colors.yellow,
                    color: Colors.black54,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text("Loading...")
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
