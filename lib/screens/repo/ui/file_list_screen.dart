import 'package:flutter/material.dart';
import 'package:redscope_assignment/constant/constant.dart';

class FileListScreen extends StatelessWidget {
  final Map<String, dynamic> gist;

  const FileListScreen({Key? key, required this.gist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final files = gist['files'] as Map<String, dynamic>? ?? {};
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Files in Gist",
          style: headingH2.copyWith(fontSize: screenWidth * 0.05),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: ListView.builder(
          itemCount: files.length,
          itemBuilder: (context, index) {
            final fileName = files.keys.elementAt(index);
            final fileData = files[fileName];
            return ListTile(
              title: Text(
                fileName,
                style: TextStyle(fontSize: screenWidth * 0.045),
              ),
              subtitle: Text(
                "Language: ${fileData['language'] ?? 'N/A'}",
                style: bodyBig.copyWith(fontSize: screenWidth * 0.04),
              ),
              onTap: () {
                // Handle file tap
              },
            );
          },
        ),
      ),
    );
  }
}
