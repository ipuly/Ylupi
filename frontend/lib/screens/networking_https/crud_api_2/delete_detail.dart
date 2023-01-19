// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'edit_data.dart';
import 'package:http/http.dart' as http;
import 'read_data.dart';

class Detail extends StatefulWidget {
  List list;
  int index;

  Detail({required this.index, required this.list});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Future<http.Response> deleteData(id) async {
    var result = await http.delete(
      Uri.parse("http://localhost:8082/api/user/deleteUser/${id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail - ${widget.list[widget.index]['name']}"),
      ),
      body: Container(
        height: 300,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          "Email",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          "Gender",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " : ${widget.list[widget.index]['name']}",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          " : ${widget.list[widget.index]['email']}",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          " : ${widget.list[widget.index]['gender']}",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ElevatedButton(
                      child: Text("EDIT"),
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => EditData(
                          list: widget.list,
                          index: widget.index,
                        ),
                      )),
                    ),
                    ElevatedButton(
                        child: Text("DELETE"),
                        onPressed: () async {
                          await modalDelete(context);
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> modalDelete(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
              "Are You sure want to delete '${widget.list[widget.index]['name']}' ?"),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 51, 0),
                  ),
                  child: Text(
                    "DELETE",
                    style: TextStyle(
                      color: Color(0xffffffff),
                    ),
                  ),
                  onPressed: () {
                    deleteData(widget.list[widget.index]['id']);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => CrudApi(),
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  child: Text("CANCEL"),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
