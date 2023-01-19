// ignore_for_file: camel_case_types, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:ylupi/contraints/data.dart';
import 'package:ylupi/screens/chat_bot/chat_screen.dart';
import 'package:ylupi/widgets/content_item_grid.dart';
import 'package:ylupi/widgets/content_item_list.dart';
import 'package:ylupi/widgets/section_title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Ylupi App"),
        actions: [
          Container(
            padding: const EdgeInsets.only(
              right: 10.0,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                );
              },
              icon: const Icon(
                Icons.chat,
                size: 20.0,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionTitle(
                title: "Materi",
              ),
              contentList(
                dataMenu: dataMenu.listData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
