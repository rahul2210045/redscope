import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redscope_assignment/constant/constant.dart';
import 'dart:convert';
import 'package:redscope_assignment/screens/repo/ui/file_list_screen.dart';

class RepoListScreen extends StatefulWidget {
  @override
  _RepoListScreenState createState() => _RepoListScreenState();
}

class _RepoListScreenState extends State<RepoListScreen> {
  List<dynamic> _gists = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchGists();
  }

  Future<void> _fetchGists() async {
    final url = Uri.parse('https://api.github.com/gists/public');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          _gists = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load gists');
      }
    } catch (error) {
      print('Error fetching gists: $error');
    }
  }

  void _showOwnerInfoDialog(Map<String, dynamic> owner) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: Colors.white,
          title: Text(
            "Owner Information",
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(owner['avatar_url']),
                radius: 50,
              ),
              SizedBox(height: 15),
              Text(
                "Username: ${owner['login']}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              Text(
                "ID: ${owner['id']}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Close",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToFileList(Map<String, dynamic> gist) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FileListScreen(gist: gist),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Repository List',
          style: headingH3.copyWith(color: Colors.white),
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _gists.length,
              itemBuilder: (context, index) {
                final gist = _gists[index];
                final owner = gist['owner'] ?? {};
                return GestureDetector(
                  onTap: () => _navigateToFileList(gist),
                  onLongPress: () => _showOwnerInfoDialog(owner),
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 4,
                    margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.03,
                      vertical: screenHeight * 0.01,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            gist['description'] ?? 'No description',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: headingH4.copyWith(
                              color: Color(0xFF4A90E2),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Divider(color: Colors.grey[400]),
                          SizedBox(height: screenHeight * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Comments: ${gist['comments']}",
                                    style: bodyBig.copyWith(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    "Created: ${gist['created_at']}",
                                    style: bodyBig.copyWith(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    "Updated: ${gist['updated_at']}",
                                    style: bodyBig.copyWith(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
