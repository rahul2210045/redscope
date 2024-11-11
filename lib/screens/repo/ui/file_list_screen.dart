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
          style: headingH2.copyWith(
            fontSize: screenWidth * 0.05,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4A90E2), Color(0xFF56CCF2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: ListView.builder(
          itemCount: files.length,
          itemBuilder: (context, index) {
            final fileName = files.keys.elementAt(index);
            final fileData = files[fileName];
            return Card(
              margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.015,
                ),
                title: Text(
                  fileName,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A90E2),
                  ),
                ),
                subtitle: Text(
                  "Language: ${fileData['language'] ?? 'N/A'}",
                  style: bodyBig.copyWith(
                    fontSize: screenWidth * 0.04,
                    color: Colors.grey[700],
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: screenWidth * 0.045,
                  color: Colors.grey[600],
                ),
                onTap: () {
                  // Handle file tap
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
