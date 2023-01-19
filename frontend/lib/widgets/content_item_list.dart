// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class contentList extends StatefulWidget {
  final List<Map<String, dynamic>> dataMenu;
  const contentList({Key? key, required this.dataMenu}) : super(key: key);

  @override
  State<contentList> createState() => _contentListState();
}

class _contentListState extends State<contentList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.dataMenu.length,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) {
        return ItemList(
          judulItem: widget.dataMenu[index]["judul_item"],
          linkItem: widget.dataMenu[index]["link_item"],
        );
      },
    );
  }
}

class ItemList extends StatelessWidget {
  final String judulItem;
  final Widget linkItem;
  const ItemList({
    Key? key,
    required this.judulItem,
    required this.linkItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => linkItem),
          );
        },
        child: ListTile(
          title: Text(judulItem),
        ),
      ),
    );
  }
}
