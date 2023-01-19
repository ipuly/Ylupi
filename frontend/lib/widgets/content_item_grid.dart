import 'package:flutter/material.dart';
import 'package:ylupi/screens/state_management/multi_provider/multi_provider.dart';

class contentGrid extends StatefulWidget {
  final List<Map<String, dynamic>> dataMenu;
  const contentGrid({Key? key, required this.dataMenu}) : super(key: key);

  @override
  State<contentGrid> createState() => _contentGridState();
}

class _contentGridState extends State<contentGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
      ),
      itemCount: widget.dataMenu.length,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) {
        return NewWidget(
          judulItem: widget.dataMenu[index]["judul_item"],
          warna: widget.dataMenu[index]["warna_item"],
          link: widget.dataMenu[index]["link_item"],
        );
      },
    );
  }
}

class NewWidget extends StatelessWidget {
  final String judulItem;
  final Color warna;
  final Widget link;
  const NewWidget({
    Key? key,
    required this.judulItem,
    required this.warna,
    required this.link,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => link),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(12.0),
          ),
          color: warna,
          boxShadow: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 24,
              offset: Offset(0, 11),
            ),
          ],
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            judulItem,
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ]),
      ),
    );
  }
}
