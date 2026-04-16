import 'package:flutter/material.dart';

class ContentWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('좋아요 100개'),
        Text('동해물과 백두산이 마르고 닳도록 하나님이 보우하사 우리나라 만세..'),
      ],
    );
  }
}