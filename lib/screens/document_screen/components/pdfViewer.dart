import 'dart:convert';

import 'package:e_health/resources/store_methods.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({super.key, required this.url, required this.title});
  final String title;
  final String url;

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  deleteFile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString('userCredentials');
    final Map<String, dynamic> userCredentials = jsonDecode(json!);

    StoreMethods().deleteFile(userCredentials['uid'], widget.title);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: SfPdfViewer.network(widget.url),
        floatingActionButton: FloatingActionButton(
          onPressed: deleteFile,
          child: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
