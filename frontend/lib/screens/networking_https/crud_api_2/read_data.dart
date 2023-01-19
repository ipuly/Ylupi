import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'delete_detail.dart';
import 'create_data.dart';

class CrudApi extends StatefulWidget {
  @override
  _CrudApiState createState() => _CrudApiState();
}

class _CrudApiState extends State<CrudApi> {
  Future<http.Response> getData() async {
    var result = await http.get(
      Uri.parse("http://localhost:8082/api/user/getAllUser"),
    );
    return result;
  }

  @override
  Widget build(BuildContext context) {
    late Future<http.Response> data = getData();
    return Scaffold(
      appBar: AppBar(
        title: Text("CRUD Flutter"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => AddData(),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<dynamic>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? ItemList(
                    list: jsonDecode(snapshot.data!.body),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => Detail(
                  list: list,
                  index: index,
                ),
              ),
            ),
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(list[index]["name"][0]),
                ),
                title: Text(list[index]["name"]),
                subtitle:
                    Text("${list[index]["gender"]} , ${list[index]["email"]}"),
              ),
            ),
          ),
        );
      },
    );
  }
}
