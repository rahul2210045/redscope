import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FullScreenImage extends StatefulWidget {
  final String imageUrl;

  FullScreenImage({required this.imageUrl});

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _checkBookmark();
  }

  Future<void> _checkBookmark() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isBookmarked = prefs.getStringList('bookmarks')?.contains(widget.imageUrl) ?? false;
    });
  }

  Future<void> _toggleBookmark() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList('bookmarks') ?? [];
    if (isBookmarked) {
      bookmarks.remove(widget.imageUrl);
    } else {
      bookmarks.add(widget.imageUrl);
    }
    await prefs.setStringList('bookmarks', bookmarks);
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
            onPressed: _toggleBookmark,
          ),
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.network(
            widget.imageUrl,
            width: screenWidth * 0.9,
            height: screenHeight * 0.9,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}