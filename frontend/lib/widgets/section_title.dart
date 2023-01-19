import 'package:flutter/material.dart';

class sectionTitle extends StatelessWidget {
  final String title;
  sectionTitle({
    Key? key,
    required String this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Center(
            child: Text(
              "$title",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
