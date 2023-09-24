import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Description extends StatefulWidget {
  var title;
  var img;
  var des;
  Description({
    required this.title,
    required this.img,
    required this.des,
  });
  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              child: Image.network(
                widget.img,
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height * .65,
                width: MediaQuery.of(context).size.width * 1,
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  child: Column(
                    children: [
                      Text(widget.title),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      Text(widget.des),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
