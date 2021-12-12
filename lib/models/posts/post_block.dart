import 'package:flutter/material.dart';

abstract class PostBlock {
  String type;
  PostBlock.withType(this.type);
  PostBlock();

  Map<String, dynamic> toJson();
  Widget showBlock();
}
