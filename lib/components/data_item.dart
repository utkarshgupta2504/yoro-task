import 'package:flutter/material.dart';

class DataItem extends StatelessWidget {
  DataItem({
    Key? key,
    required this.isRightAligned,
    required this.image,
    required this.title,
  }) : super(key: key);

  final bool isRightAligned;
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isRightAligned ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 60.0),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
