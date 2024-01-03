import 'dart:convert';

import 'package:flutter/material.dart';

class Authorization{
  static String? username;
  static String? password;
}

Image fromBase64String(String image){
  return Image.memory(base64Decode(image));
}