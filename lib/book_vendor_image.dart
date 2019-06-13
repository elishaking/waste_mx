import 'dart:io';

import 'package:flutter/material.dart';

class BookVendorImagePage extends StatelessWidget {
  final File imageFile;

  BookVendorImagePage(this.imageFile);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Image.file(imageFile)
      ),
    );
  }
}